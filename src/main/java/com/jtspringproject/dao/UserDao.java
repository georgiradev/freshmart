package com.jtspringproject.dao;

import com.jtspringproject.models.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao extends JpaRepository<User, Integer> {

  Optional<User> findByUsername(String username);

  boolean existsByUsername(String username);
}
