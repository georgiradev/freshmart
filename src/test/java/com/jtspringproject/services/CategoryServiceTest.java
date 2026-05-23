package com.jtspringproject.services;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import com.jtspringproject.exception.ResourceNotFoundException;

import com.jtspringproject.dao.CategoryDao;
import com.jtspringproject.models.Category;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class CategoryServiceTest {

  @Mock private CategoryDao categoryDao;
  @InjectMocks private CategoryService categoryService;

  private Category category;

  @BeforeEach
  void setUp() {
    category = new Category();
    category.setId(1);
    category.setName("Fruits");
  }

  @Test
  void addCategory_savesAndReturnsCategory() {
    when(categoryDao.save(any(Category.class))).thenReturn(category);

    Category result = categoryService.addCategory("Fruits");

    assertNotNull(result);
    assertEquals("Fruits", result.getName());
    verify(categoryDao).save(any(Category.class));
  }

  @Test
  void getCategories_returnsList() {
    when(categoryDao.findAll()).thenReturn(List.of(category));

    List<Category> result = categoryService.getCategories();

    assertEquals(1, result.size());
    assertEquals("Fruits", result.get(0).getName());
  }

  @Test
  void deleteCategory_existing_returnsTrue() {
    when(categoryDao.existsById(1)).thenReturn(true);

    Boolean result = categoryService.deleteCategory(1);

    assertTrue(result);
    verify(categoryDao).deleteById(1);
  }

  @Test
  void deleteCategory_notFound_returnsFalse() {
    when(categoryDao.existsById(99)).thenReturn(false);

    assertFalse(categoryService.deleteCategory(99));
    verify(categoryDao, never()).deleteById(any());
  }

  @Test
  void updateCategory_existing_returnsUpdated() {
    category.setName("Vegetables");
    when(categoryDao.findById(1)).thenReturn(Optional.of(category));
    when(categoryDao.save(category)).thenReturn(category);

    Category result = categoryService.updateCategory(1, "Vegetables");

    assertNotNull(result);
    assertEquals("Vegetables", result.getName());
  }

  @Test
  void updateCategory_notFound_throwsException() {
    when(categoryDao.findById(99)).thenReturn(Optional.empty());

    assertThrows(ResourceNotFoundException.class, () -> categoryService.updateCategory(99, "X"));
  }

  @Test
  void getCategory_existing_returnsCategory() {
    when(categoryDao.findById(1)).thenReturn(Optional.of(category));

    Category result = categoryService.getCategory(1);

    assertNotNull(result);
    assertEquals(1, result.getId());
  }

  @Test
  void getCategory_notFound_throwsException() {
    when(categoryDao.findById(99)).thenReturn(Optional.empty());

    assertThrows(ResourceNotFoundException.class, () -> categoryService.getCategory(99));
  }
}
