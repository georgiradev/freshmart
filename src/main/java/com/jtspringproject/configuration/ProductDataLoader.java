package com.jtspringproject.configuration;

import com.jtspringproject.configuration.CatalogProperties.ProductEntry;
import com.jtspringproject.dao.CategoryDao;
import com.jtspringproject.dao.ProductDao;
import com.jtspringproject.models.Category;
import com.jtspringproject.models.Product;
import java.util.Optional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Syncs the product catalog from products.yml into the database on every startup.
 * Products are matched by name:
 *   - Existing product → price, description, weight and image are updated from config.
 *   - New product (not in DB) → inserted with a default stock quantity of 100.
 *
 * To change a price or add a product, edit the catalog section in products.yml and restart.
 */
@Component
@Slf4j
public class ProductDataLoader implements ApplicationRunner {

    private final ProductDao productDao;
    private final CategoryDao categoryDao;
    private final CatalogProperties catalog;

    @Autowired
    public ProductDataLoader(ProductDao productDao, CategoryDao categoryDao,
                             CatalogProperties catalog) {
        this.productDao = productDao;
        this.categoryDao = categoryDao;
        this.catalog = catalog;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        int updated = 0, inserted = 0;

        for (ProductEntry entry : catalog.getProducts()) {
            Optional<Category> categoryOpt = categoryDao.findByName(entry.getCategory());
            if (categoryOpt.isEmpty()) {
                log.warn("Catalog loader: category '{}' not found — skipping '{}'",
                         entry.getCategory(), entry.getName());
                continue;
            }

            Optional<Product> existing = productDao.findByName(entry.getName());
            Product product = existing.orElseGet(Product::new);
            boolean isNew = existing.isEmpty();

            product.setName(entry.getName());
            product.setDescription(entry.getDescription());
            product.setPrice(entry.getPrice());
            product.setWeight(entry.getWeight());
            product.setImage(entry.getImage());
            product.setCategory(categoryOpt.get());

            if (isNew) {
                product.setQuantity(100);
                inserted++;
            } else {
                updated++;
            }

            productDao.save(product);
        }

        log.info("Catalog loader: {} products updated, {} products inserted from products.yml",
                 updated, inserted);
    }
}
