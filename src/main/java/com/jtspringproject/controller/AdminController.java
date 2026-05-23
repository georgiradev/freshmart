package com.jtspringproject.controller;

import com.jtspringproject.models.Category;
import com.jtspringproject.models.Product;
import com.jtspringproject.models.User;
import com.jtspringproject.services.CategoryService;
import com.jtspringproject.services.ProductService;
import com.jtspringproject.services.UserService;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

  private final UserService userService;
  private final CategoryService categoryService;
  private final ProductService productService;
  private final PasswordEncoder passwordEncoder;

  @Autowired
  public AdminController(
      UserService userService,
      CategoryService categoryService,
      ProductService productService,
      PasswordEncoder passwordEncoder) {
    this.userService = userService;
    this.categoryService = categoryService;
    this.productService = productService;
    this.passwordEncoder = passwordEncoder;
  }

  @GetMapping("/index")
  public String index(Model model) {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    log.debug("Admin index accessed by: {}", username);
    model.addAttribute("username", username);
    return "index";
  }

  @GetMapping("/login")
  public ModelAndView adminLogin(@RequestParam(required = false) String error) {
    if ("true".equals(error)) {
      log.warn("Failed admin login attempt");
    }
    ModelAndView mv = new ModelAndView("adminLogin");
    if ("true".equals(error)) {
      mv.addObject("msg", "Invalid username or password. Please try again.");
    }
    return mv;
  }

  @GetMapping(value = {"/", "Dashboard"})
  public ModelAndView adminHome(Model model) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    log.debug("Admin dashboard accessed by: {}", authentication.getName());
    ModelAndView mv = new ModelAndView("adminHome");
    mv.addObject("admin", authentication.getName());
    return mv;
  }

  @GetMapping("/categories")
  public ModelAndView getcategory() {
    List<Category> categories = this.categoryService.getCategories();
    log.debug("Categories page loaded: {} categories", categories.size());
    ModelAndView mView = new ModelAndView("categories");
    mView.addObject("categories", categories);
    return mView;
  }

  @PostMapping("/categories")
  public String addCategory(@RequestParam("categoryname") String category_name) {
    log.info("Admin adding category: {}", category_name);
    this.categoryService.addCategory(category_name);
    return "redirect:categories";
  }

  @GetMapping("/categories/delete")
  public String removeCategoryDb(@RequestParam("id") int id) {
    log.info("Admin deleting category: id={}", id);
    this.categoryService.deleteCategory(id);
    return "redirect:/admin/categories";
  }

  @GetMapping("/categories/update")
  public String updateCategory(
      @RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryname) {
    log.info("Admin updating category: id={}, newName={}", id, categoryname);
    this.categoryService.updateCategory(id, categoryname);
    return "redirect:/admin/categories";
  }

  @GetMapping("/products")
  public ModelAndView getproduct() {
    List<Product> products = this.productService.getProducts();
    log.debug("Products page loaded: {} products", products.size());
    ModelAndView mView = new ModelAndView("products");
    if (products.isEmpty()) {
      mView.addObject("msg", "No products are available");
    } else {
      mView.addObject("products", products);
    }
    return mView;
  }

  @GetMapping("/products/add")
  public ModelAndView addProduct() {
    ModelAndView mView = new ModelAndView("productsAdd");
    List<Category> categories = this.categoryService.getCategories();
    mView.addObject("categories", categories);
    return mView;
  }

  @PostMapping("/products/add")
  public String addProduct(
      @RequestParam("name") String name,
      @RequestParam("categoryid") int categoryId,
      @RequestParam("price") int price,
      @RequestParam("weight") int weight,
      @RequestParam("quantity") int quantity,
      @RequestParam("description") String description,
      @RequestParam("productImage") String productImage) {
    log.info("Admin adding product: name={}, categoryId={}, price={}", name, categoryId, price);
    Category category = this.categoryService.getCategory(categoryId);
    Product product = new Product();
    product.setName(name);
    product.setCategory(category);
    product.setDescription(description);
    product.setPrice(price);
    product.setImage(productImage);
    product.setWeight(weight);
    product.setQuantity(quantity);
    this.productService.addProduct(product);
    return "redirect:/admin/products";
  }

  @GetMapping("/products/update/{id}")
  public ModelAndView updateproduct(@PathVariable("id") int id) {
    log.debug("Admin loading product update form: id={}", id);
    Product product = this.productService.getProduct(id);
    List<Category> categories = this.categoryService.getCategories();
    ModelAndView mView = new ModelAndView("productsUpdate");
    mView.addObject("categories", categories);
    mView.addObject("product", product);
    return mView;
  }

  @PostMapping("/products/update/{id}")
  public String updateProduct(
      @PathVariable("id") int id,
      @RequestParam("name") String name,
      @RequestParam("categoryid") int categoryId,
      @RequestParam("price") int price,
      @RequestParam("weight") int weight,
      @RequestParam("quantity") int quantity,
      @RequestParam("description") String description,
      @RequestParam("productImage") String productImage) {
    log.info("Admin updating product: id={}", id);
    Category category = this.categoryService.getCategory(categoryId);
    Product product = this.productService.getProduct(id);

    product.setName(name != null ? name : product.getName());
    product.setCategory(category != null ? category : product.getCategory());
    product.setDescription(description != null ? description : product.getDescription());
    product.setPrice(price > 0 ? price : product.getPrice());
    product.setImage(productImage != null ? productImage : product.getImage());
    product.setWeight(weight > 0 ? weight : product.getWeight());
    product.setQuantity(quantity > 0 ? quantity : product.getQuantity());

    this.productService.updateProduct(id, product);
    return "redirect:/admin/products";
  }

  @GetMapping("/products/delete")
  public String removeProduct(@RequestParam("id") int id) {
    log.info("Admin deleting product: id={}", id);
    this.productService.deleteProduct(id);
    return "redirect:/admin/products";
  }

  @PostMapping("/products")
  public String postproduct() {
    return "redirect:/admin/categories";
  }

  @GetMapping("/customers")
  public ModelAndView getCustomerDetail() {
    List<User> users = this.userService.getUsers();
    log.debug("Customers page loaded: {} customers", users.size());
    ModelAndView mView = new ModelAndView("displayCustomers");
    mView.addObject("customers", users);
    return mView;
  }

  @GetMapping("/profileDisplay")
  public String profileDisplay(Model model) {
    String username = SecurityContextHolder.getContext().getAuthentication().getName();
    log.debug("Admin profile display for: {}", username);
    User user = userService.getUserByUsername(username);
    if (user != null) {
      model.addAttribute("userid", user.getId());
      model.addAttribute("username", user.getUsername());
      model.addAttribute("email", user.getEmail());
      model.addAttribute("password", user.getPassword());
      model.addAttribute("address", user.getAddress());
    }
    return "updateProfile";
  }

  @PostMapping("/updateuser")
  public String updateUserProfile(
      @RequestParam("userid") int userid,
      @RequestParam("username") String username,
      @RequestParam("email") String email,
      @RequestParam("password") String password,
      @RequestParam("address") String address) {
    log.info("Admin updating profile: userId={}, username={}", userid, username);
    User user = userService.getUserById(userid);
    if (user != null) {
      user.setUsername(username);
      user.setEmail(email);
      user.setAddress(address);
      if (!password.startsWith("{") && !password.startsWith("$2")) {
        user.setPassword(passwordEncoder.encode(password));
      } else {
        user.setPassword(password);
      }
      userService.updateUser(user);

      Authentication newAuth =
          new UsernamePasswordAuthenticationToken(
              username,
              null,
              SecurityContextHolder.getContext().getAuthentication().getAuthorities());
      SecurityContextHolder.getContext().setAuthentication(newAuth);
      log.info("Admin profile updated successfully: username={}", username);
    }
    return "redirect:index";
  }
}
