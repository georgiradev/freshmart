package com.jtspringproject.controller;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import com.jtspringproject.configuration.SecurityConfiguration;
import com.jtspringproject.exception.DuplicateUsernameException;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.jtspringproject.models.Product;
import com.jtspringproject.models.User;
import com.jtspringproject.services.CartService;
import com.jtspringproject.services.ProductService;
import com.jtspringproject.services.UserService;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest(UserController.class)
@Import(SecurityConfiguration.class)
class UserControllerTest {

  @Autowired private MockMvc mockMvc;

  @MockBean private UserService userService;
  @MockBean private ProductService productService;
  @MockBean private CartService cartService;
  @MockBean private PasswordEncoder passwordEncoder;

  private User user;
  private Product product;

  @BeforeEach
  void setUp() {
    user = new User();
    user.setId(2);
    user.setUsername("lisa");
    user.setPassword("{noop}765");
    user.setEmail("lisa@test.com");
    user.setRole("ROLE_NORMAL");

    product = new Product();
    product.setId(1);
    product.setName("Apple");
    product.setPrice(3);
  }

  // --- Public pages ---

  @Test
  void loginPage_accessible_withoutAuth() throws Exception {
    mockMvc.perform(get("/login")).andExpect(status().isOk()).andExpect(view().name("userLogin"));
  }

  @Test
  void loginPage_withErrorParam_showsMessage() throws Exception {
    mockMvc
        .perform(get("/login").param("error", "true"))
        .andExpect(status().isOk())
        .andExpect(model().attributeExists("msg"));
  }

  @Test
  void registerPage_accessible_withoutAuth() throws Exception {
    mockMvc.perform(get("/register")).andExpect(status().isOk()).andExpect(view().name("register"));
  }

  // --- Registration ---

  @Test
  void newUserRegister_newUsername_redirectsToLogin() throws Exception {
    when(userService.addUser(any(User.class))).thenReturn(user);

    mockMvc
        .perform(
            post("/newuserregister")
                .with(csrf())
                .param("username", "newuser")
                .param("password", "pass123")
                .param("email", "new@test.com")
                .param("address", "456 Oak St"))
        .andExpect(status().isOk())
        .andExpect(view().name("userLogin"));

    verify(userService).addUser(any(User.class));
  }

  @Test
  void newUserRegister_existingUsername_showsError() throws Exception {
    when(userService.addUser(any(User.class)))
        .thenThrow(new DuplicateUsernameException("lisa"));

    mockMvc
        .perform(
            post("/newuserregister")
                .with(csrf())
                .param("username", "lisa")
                .param("password", "pass123")
                .param("email", "lisa@test.com")
                .param("address", ""))
        .andExpect(status().isOk())
        .andExpect(view().name("register"))
        .andExpect(model().attributeExists("msg"));
  }

  // --- Authenticated pages ---

  @Test
  @WithMockUser(roles = "USER")
  void indexPage_authenticated_returnsIndexView() throws Exception {
    when(productService.getProducts()).thenReturn(List.of(product));

    mockMvc
        .perform(get("/"))
        .andExpect(status().isOk())
        .andExpect(view().name("index"))
        .andExpect(model().attributeExists("products"));
  }

  @Test
  @WithMockUser(roles = "USER")
  void indexPage_noProducts_showsMessage() throws Exception {
    when(productService.getProducts()).thenReturn(List.of());

    mockMvc
        .perform(get("/"))
        .andExpect(status().isOk())
        .andExpect(view().name("index"))
        .andExpect(model().attributeExists("msg"));
  }

  @Test
  @WithMockUser(username = "lisa", roles = "USER")
  void profileDisplay_returnsUpdateProfileView() throws Exception {
    when(userService.getUserByUsername("lisa")).thenReturn(user);

    mockMvc
        .perform(get("/profileDisplay"))
        .andExpect(status().isOk())
        .andExpect(view().name("updateProfile"))
        .andExpect(model().attributeExists("userid", "username", "email"));
  }

  @Test
  @WithMockUser(username = "lisa", roles = "USER")
  void updateProfile_savesAndReturnsView() throws Exception {
    when(userService.getUserByUsername("lisa")).thenReturn(user);
    when(userService.updateUser(any(User.class))).thenReturn(user);
    when(passwordEncoder.encode(any())).thenReturn("{bcrypt}hashed");

    mockMvc
        .perform(
            post("/updateProfile")
                .with(csrf())
                .param("username", "lisa")
                .param("email", "lisa@test.com")
                .param("password", "newpass")
                .param("address", "123 Main St"))
        .andExpect(status().isOk())
        .andExpect(view().name("updateProfile"))
        .andExpect(model().attribute("msg", "saved"));
  }

  @Test
  void indexPage_unauthenticated_redirectsToLogin() throws Exception {
    mockMvc.perform(get("/")).andExpect(status().is3xxRedirection());
  }
}
