package com.jtspringproject.controller;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.jtspringproject.configuration.SecurityConfiguration;
import com.jtspringproject.models.Category;
import com.jtspringproject.models.Product;
import com.jtspringproject.models.User;
import com.jtspringproject.services.CategoryService;
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

@WebMvcTest(AdminController.class)
@Import(SecurityConfiguration.class)
class AdminControllerTest {

  @Autowired private MockMvc mockMvc;

  @MockBean private UserService userService;
  @MockBean private CategoryService categoryService;
  @MockBean private ProductService productService;
  @MockBean private PasswordEncoder passwordEncoder;

  private Category category;
  private Product product;
  private User adminUser;

  @BeforeEach
  void setUp() {
    category = new Category();
    category.setId(1);
    category.setName("Fruits");

    product = new Product();
    product.setId(1);
    product.setName("Apple");
    product.setPrice(3);
    product.setQuantity(10);
    product.setWeight(100);
    product.setCategory(category);

    adminUser = new User();
    adminUser.setId(1);
    adminUser.setUsername("admin");
    adminUser.setPassword("{noop}123");
    adminUser.setEmail("admin@test.com");
    adminUser.setRole("ROLE_ADMIN");
  }

  // --- Login ---

  @Test
  void adminLoginPage_accessible_withoutAuth() throws Exception {
    mockMvc.perform(get("/admin/login")).andExpect(status().isOk()).andExpect(view().name("adminLogin"));
  }

  @Test
  void adminLoginPage_withErrorParam_showsErrorMessage() throws Exception {
    mockMvc
        .perform(get("/admin/login").param("error", "true"))
        .andExpect(status().isOk())
        .andExpect(model().attributeExists("msg"));
  }

  // --- Dashboard ---

  @Test
  @WithMockUser(roles = "ADMIN")
  void adminHome_authenticated_returnsAdminHomeView() throws Exception {
    mockMvc.perform(get("/admin/")).andExpect(status().isOk()).andExpect(view().name("adminHome"));
  }

  @Test
  void adminHome_unauthenticated_redirectsToLogin() throws Exception {
    mockMvc.perform(get("/admin/")).andExpect(status().is3xxRedirection());
  }

  // --- Categories ---

  @Test
  @WithMockUser(roles = "ADMIN")
  void getCategories_returnsCategoriesView() throws Exception {
    when(categoryService.getCategories()).thenReturn(List.of(category));

    mockMvc
        .perform(get("/admin/categories"))
        .andExpect(status().isOk())
        .andExpect(view().name("categories"))
        .andExpect(model().attributeExists("categories"));
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void addCategory_redirectsAfterPost() throws Exception {
    when(categoryService.addCategory("Fruits")).thenReturn(category);

    mockMvc
        .perform(post("/admin/categories").with(csrf()).param("categoryname", "Fruits"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("categories"));

    verify(categoryService).addCategory("Fruits");
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void deleteCategory_redirectsToCategories() throws Exception {
    when(categoryService.deleteCategory(1)).thenReturn(true);

    mockMvc
        .perform(get("/admin/categories/delete").param("id", "1"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/admin/categories"));
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void updateCategory_redirectsToCategories() throws Exception {
    when(categoryService.updateCategory(1, "Vegetables")).thenReturn(category);

    mockMvc
        .perform(
            get("/admin/categories/update")
                .param("categoryid", "1")
                .param("categoryname", "Vegetables"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/admin/categories"));
  }

  // --- Products ---

  @Test
  @WithMockUser(roles = "ADMIN")
  void getProducts_returnsProductsView() throws Exception {
    when(productService.getProducts()).thenReturn(List.of(product));

    mockMvc
        .perform(get("/admin/products"))
        .andExpect(status().isOk())
        .andExpect(view().name("products"))
        .andExpect(model().attributeExists("products"));
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void getProducts_empty_showsMessage() throws Exception {
    when(productService.getProducts()).thenReturn(List.of());

    mockMvc
        .perform(get("/admin/products"))
        .andExpect(status().isOk())
        .andExpect(model().attributeExists("msg"));
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void addProductForm_returnsAddView_withCategories() throws Exception {
    when(categoryService.getCategories()).thenReturn(List.of(category));

    mockMvc
        .perform(get("/admin/products/add"))
        .andExpect(status().isOk())
        .andExpect(view().name("productsAdd"))
        .andExpect(model().attributeExists("categories"));
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void addProduct_redirectsAfterPost() throws Exception {
    when(categoryService.getCategory(1)).thenReturn(category);
    when(productService.addProduct(any())).thenReturn(product);

    mockMvc
        .perform(
            post("/admin/products/add")
                .with(csrf())
                .param("name", "Apple")
                .param("categoryid", "1")
                .param("price", "3")
                .param("weight", "100")
                .param("quantity", "10")
                .param("description", "Fresh apple")
                .param("productImage", "apple.jpg"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/admin/products"));
  }

  @Test
  @WithMockUser(roles = "ADMIN")
  void deleteProduct_redirectsToProducts() throws Exception {
    when(productService.deleteProduct(1)).thenReturn(true);

    mockMvc
        .perform(get("/admin/products/delete").param("id", "1"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/admin/products"));
  }

  // --- Customers ---

  @Test
  @WithMockUser(roles = "ADMIN")
  void getCustomers_returnsCustomersView() throws Exception {
    when(userService.getUsers()).thenReturn(List.of(adminUser));

    mockMvc
        .perform(get("/admin/customers"))
        .andExpect(status().isOk())
        .andExpect(view().name("displayCustomers"))
        .andExpect(model().attributeExists("customers"));
  }

  // --- Profile ---

  @Test
  @WithMockUser(username = "admin", roles = "ADMIN")
  void profileDisplay_returnsUpdateProfileView() throws Exception {
    when(userService.getUserByUsername("admin")).thenReturn(adminUser);

    mockMvc
        .perform(get("/admin/profileDisplay"))
        .andExpect(status().isOk())
        .andExpect(view().name("updateProfile"))
        .andExpect(model().attributeExists("userid", "username", "email"));
  }

  @Test
  @WithMockUser(username = "admin", roles = "ADMIN")
  void updateUserProfile_redirectsToIndex() throws Exception {
    when(userService.getUserById(1)).thenReturn(adminUser);
    when(passwordEncoder.encode(anyString())).thenReturn("{bcrypt}hashed");
    when(userService.updateUser(any())).thenReturn(adminUser);

    mockMvc
        .perform(
            post("/admin/updateuser")
                .with(csrf())
                .param("userid", "1")
                .param("username", "admin")
                .param("email", "admin@test.com")
                .param("password", "newpassword")
                .param("address", "123 Main St"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("index"));
  }
}
