package com.jtspringproject.dao;

import com.jtspringproject.models.Category;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryDao extends JpaRepository<Category, Integer> {
    Optional<Category> findByName(String name);
}
