package com.jtspringproject.services;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.jtspringproject.exception.ResourceNotFoundException;

import com.jtspringproject.dao.ProductDao;
import com.jtspringproject.models.Category;
import com.jtspringproject.models.Product;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class ProductServiceTest {

  @Mock private ProductDao productDao;
  @InjectMocks private ProductService productService;

  private Product product;

  @BeforeEach
  void setUp() {
    Category category = new Category();
    category.setId(1);
    category.setName("Fruits");

    product = new Product();
    product.setId(10);
    product.setName("Apple");
    product.setPrice(3);
    product.setQuantity(40);
    product.setWeight(76);
    product.setDescription("Fresh apple");
    product.setCategory(category);
  }

  @Test
  void getProducts_returnsList() {
    when(productDao.findAll()).thenReturn(List.of(product));

    List<Product> result = productService.getProducts();

    assertEquals(1, result.size());
    assertEquals("Apple", result.get(0).getName());
  }

  @Test
  void addProduct_delegatesToDao() {
    when(productDao.save(product)).thenReturn(product);

    Product result = productService.addProduct(product);

    verify(productDao).save(product);
    assertNotNull(result);
  }

  @Test
  void getProduct_returnsById() {
    when(productDao.findById(10)).thenReturn(Optional.of(product));

    Product result = productService.getProduct(10);

    assertNotNull(result);
    assertEquals(10, result.getId());
  }

  @Test
  void getProduct_notFound_throwsException() {
    when(productDao.findById(999)).thenReturn(Optional.empty());

    assertThrows(ResourceNotFoundException.class, () -> productService.getProduct(999));
  }

  @Test
  void updateProduct_setsIdAndSaves() {
    when(productDao.existsById(10)).thenReturn(true);
    when(productDao.save(product)).thenReturn(product);

    Product result = productService.updateProduct(10, product);

    assertEquals(10, product.getId());
    verify(productDao).save(product);
    assertNotNull(result);
  }

  @Test
  void deleteProduct_existing_returnsTrue() {
    when(productDao.existsById(10)).thenReturn(true);

    boolean result = productService.deleteProduct(10);

    assertTrue(result);
    verify(productDao).deleteById(10);
  }

  @Test
  void deleteProduct_notFound_returnsFalse() {
    when(productDao.existsById(999)).thenReturn(false);

    assertFalse(productService.deleteProduct(999));
    verify(productDao, never()).deleteById(any());
  }
}
