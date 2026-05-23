package com.jtspringproject.dao;

import com.jtspringproject.models.Product;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductDao extends JpaRepository<Product, Integer> {
    Optional<Product> findByName(String name);
}
