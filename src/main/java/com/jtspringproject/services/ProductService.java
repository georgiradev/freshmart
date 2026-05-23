package com.jtspringproject.services;

import com.jtspringproject.dao.ProductDao;
import com.jtspringproject.exception.ResourceNotFoundException;
import com.jtspringproject.models.Product;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class ProductService {

  private final ProductDao productDao;

  @Autowired
  public ProductService(ProductDao productDao) {
    this.productDao = productDao;
  }

  public List<Product> getProducts() {
    List<Product> products = productDao.findAll();
    log.debug("Fetched {} products", products.size());
    return products;
  }

  public Product addProduct(Product product) {
    Product saved = productDao.save(product);
    log.info("Product added: id={}, name={}", saved.getId(), saved.getName());
    return saved;
  }

  public Product getProduct(int id) {
    return productDao.findById(id).orElseThrow(() -> {
      log.warn("Product not found: id={}", id);
      return new ResourceNotFoundException("Product", id);
    });
  }

  public Product updateProduct(int id, Product product) {
    if (!productDao.existsById(id)) {
      log.warn("Update failed — product not found: id={}", id);
      throw new ResourceNotFoundException("Product", id);
    }
    product.setId(id);
    Product updated = productDao.save(product);
    log.info("Product updated: id={}, name={}", id, updated.getName());
    return updated;
  }

  public boolean deleteProduct(int id) {
    if (!productDao.existsById(id)) {
      log.warn("Delete failed — product not found: id={}", id);
      return false;
    }
    productDao.deleteById(id);
    log.info("Product deleted: id={}", id);
    return true;
  }
}
