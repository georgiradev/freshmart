package com.jtspringproject.controller;

import com.jtspringproject.exception.DuplicateUsernameException;
import com.jtspringproject.models.CartProduct;
import com.jtspringproject.models.Product;
import com.jtspringproject.models.User;
import com.jtspringproject.services.CartService;
import com.jtspringproject.services.ProductService;
import com.jtspringproject.services.UserService;
import java.io.IOException;
import java.util.Base64;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Slf4j
public class UserController {

  private static final Set<String> ALLOWED_IMAGE_TYPES =
      Set.of("image/jpeg", "image/png", "image/gif", "image/webp");

  private final UserService userService;
  private final ProductService productService;
  private final CartService cartService;
  private final PasswordEncoder passwordEncoder;

  @Autowired
  public UserController(UserService userService, ProductService productService,
      CartService cartService, PasswordEncoder passwordEncoder) {
    this.userService = userService;
    this.productService = productService;
    this.cartService = cartService;
    this.passwordEncoder = passwordEncoder;
  }

  @GetMapping("/register")
  public String registerUser() {
    return "register";
  }

  @GetMapping("/buy")
  public String buy() {
    return "buy";
  }

  @GetMapping("/login")
  public ModelAndView userLogin(@RequestParam(required = false) String error) {
    if ("true".equals(error)) {
      log.warn("Failed user login attempt");
    }
    ModelAndView mv = new ModelAndView("userLogin");
    if ("true".equals(error)) {
      mv.addObject("msg", "Please enter correct username and password");
    }
    return mv;
  }

  @GetMapping("/")
  public ModelAndView indexPage() {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    log.debug("Home page accessed by: {}", username);
    ModelAndView mView = new ModelAndView("index");
    mView.addObject("username", username);
    List<Product> products = productService.getProducts();
    if (products.isEmpty()) {
      mView.addObject("msg", "No products are available");
    } else {
      mView.addObject("products", products);
    }
    User user = userService.getUserByUsername(username);
    if (user != null) {
      Map<Integer, CartProduct> cartMap = cartService.getCartItems(user).stream()
          .collect(Collectors.toMap(cp -> cp.getProduct().getId(), cp -> cp));
      mView.addObject("cartMap", cartMap);
      mView.addObject("profileImage", user.getProfileImage());
    }
    return mView;
  }

  @PostMapping("/newuserregister")
  public ModelAndView newUseRegister(@ModelAttribute User user) {
    log.info("Registration attempt for username: {}", user.getUsername());
    try {
      user.setRole("ROLE_NORMAL");
      userService.addUser(user);
      log.info("User registered successfully: {}", user.getUsername());
      return new ModelAndView("userLogin");
    } catch (DuplicateUsernameException ex) {
      ModelAndView mView = new ModelAndView("register");
      mView.addObject("msg", user.getUsername() + " is taken. Please choose a different username.");
      return mView;
    }
  }

  @GetMapping("/profileDisplay")
  public String profileDisplay(Model model) {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    log.debug("Profile display for: {}", username);
    User user = userService.getUserByUsername(username);
    if (user != null) {
      model.addAttribute("userid", user.getId());
      model.addAttribute("username", user.getUsername());
      model.addAttribute("email", user.getEmail());
      model.addAttribute("password", user.getPassword());
      model.addAttribute("address", user.getAddress());
      model.addAttribute("profileImage", user.getProfileImage());
    } else {
      log.warn("Profile display — user not found in DB: {}", username);
      model.addAttribute("msg", "User not found");
    }
    return "updateProfile";
  }

  @PostMapping("/updateProfile")
  public String updateProfile(
      @RequestParam String username,
      @RequestParam String email,
      @RequestParam(required = false, defaultValue = "") String password,
      @RequestParam(required = false, defaultValue = "") String address,
      @RequestParam(value = "profilePhoto", required = false) MultipartFile profilePhoto,
      Model model) {
    String currentUsername = SecurityContextHolder.getContext().getAuthentication().getName();
    User user = userService.getUserByUsername(currentUsername);
    if (user != null) {
      user.setUsername(username);
      user.setEmail(email);
      user.setAddress(address);
      if (!password.isBlank()) {
        user.setPassword(passwordEncoder.encode(password));
      }
      if (profilePhoto != null && !profilePhoto.isEmpty()) {
        String saved = saveProfilePhoto(user.getId(), profilePhoto);
        if (saved != null) {
          user.setProfileImage(saved);
        }
      }
      userService.updateUser(user);
      if (!username.equals(currentUsername)) {
        SecurityContextHolder.getContext().setAuthentication(
            new UsernamePasswordAuthenticationToken(username, null,
                SecurityContextHolder.getContext().getAuthentication().getAuthorities()));
      }
      log.info("Profile updated for: {}", username);
      model.addAttribute("profileImage", user.getProfileImage());
    }
    model.addAttribute("userid", user != null ? user.getId() : 0);
    model.addAttribute("username", username);
    model.addAttribute("email", email);
    model.addAttribute("address", address);
    model.addAttribute("msg", "saved");
    return "updateProfile";
  }

  private String saveProfilePhoto(int userId, MultipartFile file) {
    String contentType = file.getContentType();
    if (contentType == null || !ALLOWED_IMAGE_TYPES.contains(contentType)) {
      log.warn("Rejected profile photo upload — unsupported type: {}", contentType);
      return null;
    }
    try {
      String base64 = Base64.getEncoder().encodeToString(file.getBytes());
      return "data:" + contentType + ";base64," + base64;
    } catch (IOException e) {
      log.error("Failed to process profile photo: {}", e.getMessage());
      return null;
    }
  }

  // ── Cart ──

  @GetMapping("/cart")
  public String viewCart(Model model) {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    User user = userService.getUserByUsername(username);
    List<CartProduct> items = cartService.getCartItems(user);
    int total = items.stream().mapToInt(i -> i.getProduct().getPrice() * i.getQuantity()).sum();
    int totalItems = items.stream().mapToInt(CartProduct::getQuantity).sum();
    model.addAttribute("cartItems", items);
    model.addAttribute("cartTotal", total);
    model.addAttribute("cartItemCount", items.size());
    model.addAttribute("cartTotalItems", totalItems);
    model.addAttribute("username", username);
    if (user != null) {
      model.addAttribute("profileImage", user.getProfileImage());
    }
    log.debug("Cart viewed by: {}, {} distinct items, {} total qty", username, items.size(), totalItems);
    return "cartproduct";
  }

  @PostMapping("/cart/add")
  public String addToCart(@RequestParam int productId,
      @RequestParam(defaultValue = "1") int quantity) {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    User user = userService.getUserByUsername(username);
    Product product = productService.getProduct(productId);
    cartService.addProduct(user, product, Math.max(1, quantity));
    return "redirect:/";
  }

  @GetMapping("/cart/remove")
  public String removeFromCart(@RequestParam int itemId) {
    cartService.removeItem(itemId);
    return "redirect:/cart";
  }

  @GetMapping("/cart/increase")
  public String increaseQuantity(@RequestParam int itemId,
      @RequestParam(defaultValue = "cart") String from) {
    cartService.increaseQuantity(itemId);
    return "home".equals(from) ? "redirect:/" : "redirect:/cart";
  }

  @GetMapping("/cart/decrease")
  public String decreaseQuantity(@RequestParam int itemId,
      @RequestParam(defaultValue = "cart") String from) {
    cartService.decreaseQuantity(itemId);
    return "home".equals(from) ? "redirect:/" : "redirect:/cart";
  }

  @GetMapping("/cart/clear")
  public String clearCart() {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    User user = userService.getUserByUsername(username);
    cartService.clearCart(user);
    return "redirect:/cart";
  }

  // Learning/demo endpoints
  @GetMapping("/test")
  public String test(Model model) {
    model.addAttribute("author", "jay gajera");
    model.addAttribute("id", 40);
    List<String> friends = new ArrayList<>();
    friends.add("xyz");
    friends.add("abc");
    model.addAttribute("f", friends);
    return "test";
  }

  @GetMapping("/test2")
  public ModelAndView test2() {
    ModelAndView mv = new ModelAndView("test2");
    mv.addObject("name", "jay gajera 17");
    mv.addObject("id", 40);
    List<Integer> marks = new ArrayList<>();
    marks.add(10);
    marks.add(25);
    mv.addObject("marks", marks);
    return mv;
  }
}
