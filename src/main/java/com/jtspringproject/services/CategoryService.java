package com.jtspringproject.services;

import com.jtspringproject.dao.CategoryDao;
import com.jtspringproject.exception.ResourceNotFoundException;
import com.jtspringproject.models.Category;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CategoryService {

  private final CategoryDao categoryDao;

  @Autowired
  public CategoryService(CategoryDao categoryDao) {
    this.categoryDao = categoryDao;
  }

  public Category addCategory(String name) {
    Category category = new Category();
    category.setName(name);
    Category saved = categoryDao.save(category);
    log.info("Category added: id={}, name={}", saved.getId(), saved.getName());
    return saved;
  }

  public List<Category> getCategories() {
    List<Category> categories = categoryDao.findAll();
    log.debug("Fetched {} categories", categories.size());
    return categories;
  }

  public Boolean deleteCategory(int id) {
    if (!categoryDao.existsById(id)) {
      log.warn("Delete failed — category not found: id={}", id);
      return false;
    }
    categoryDao.deleteById(id);
    log.info("Category deleted: id={}", id);
    return true;
  }

  public Category updateCategory(int id, String name) {
    Category category = categoryDao.findById(id).orElseThrow(() -> {
      log.warn("Update failed — category not found: id={}", id);
      return new ResourceNotFoundException("Category", id);
    });
    category.setName(name);
    Category updated = categoryDao.save(category);
    log.info("Category updated: id={}, name={}", id, name);
    return updated;
  }

  public Category getCategory(int id) {
    return categoryDao.findById(id).orElseThrow(() -> {
      log.warn("Category not found: id={}", id);
      return new ResourceNotFoundException("Category", id);
    });
  }
}
