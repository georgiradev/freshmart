package com.jtspringproject.services;

import com.jtspringproject.dao.UserDao;
import com.jtspringproject.exception.DuplicateUsernameException;
import com.jtspringproject.models.User;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class UserService {

  private final UserDao userDao;
  private final PasswordEncoder passwordEncoder;

  @Autowired
  public UserService(UserDao userDao, PasswordEncoder passwordEncoder) {
    this.userDao = userDao;
    this.passwordEncoder = passwordEncoder;
  }

  public List<User> getUsers() {
    List<User> users = userDao.findAll();
    log.debug("Fetched {} users", users.size());
    return users;
  }

  public User addUser(User user) {
    if (userDao.existsByUsername(user.getUsername())) {
      log.warn("Registration failed — username already taken: {}", user.getUsername());
      throw new DuplicateUsernameException(user.getUsername());
    }
    try {
      user.setPassword(passwordEncoder.encode(user.getPassword()));
      User saved = userDao.save(user);
      log.info("User registered: id={}, username={}", saved.getId(), saved.getUsername());
      return saved;
    } catch (DataIntegrityViolationException e) {
      log.error("DB error while adding user '{}': {}", user.getUsername(), e.getMessage());
      throw new DuplicateUsernameException(user.getUsername());
    }
  }

  public User updateUser(User user) {
    User updated = userDao.save(user);
    log.info("User updated: id={}, username={}", updated.getId(), updated.getUsername());
    return updated;
  }

  public User getUserById(int id) {
    User user = userDao.findById(id).orElse(null);
    if (user == null) {
      log.warn("User not found: id={}", id);
    }
    return user;
  }

  /** Authenticate a user manually (Spring Security handles login via UserDetailsService). */
  public User checkLogin(String username, String password) {
    return userDao.findByUsername(username)
        .filter(u -> passwordEncoder.matches(password, u.getPassword()))
        .orElse(null);
  }

  public boolean checkUserExists(String username) {
    return userDao.existsByUsername(username);
  }

  public User getUserByUsername(String username) {
    User user = userDao.findByUsername(username).orElse(null);
    if (user == null) {
      log.warn("User not found by username: {}", username);
    }
    return user;
  }
}
