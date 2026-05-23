package com.jtspringproject.services;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import com.jtspringproject.exception.DuplicateUsernameException;

import com.jtspringproject.dao.UserDao;
import com.jtspringproject.models.User;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

  @Mock private UserDao userDao;
  @Mock private PasswordEncoder passwordEncoder;
  @InjectMocks private UserService userService;

  private User user;

  @BeforeEach
  void setUp() {
    user = new User();
    user.setId(1);
    user.setUsername("testuser");
    user.setPassword("plaintext");
    user.setEmail("test@test.com");
    user.setRole("ROLE_NORMAL");
  }

  @Test
  void addUser_hashesPasswordBeforeSaving() {
    when(passwordEncoder.encode("plaintext")).thenReturn("{bcrypt}hashedpw");
    when(userDao.save(any(User.class))).thenReturn(user);

    User result = userService.addUser(user);

    verify(passwordEncoder).encode("plaintext");
    verify(userDao).save(user);
    assertEquals("{bcrypt}hashedpw", user.getPassword());
    assertNotNull(result);
  }

  @Test
  void addUser_duplicateUsername_throwsDuplicateUsernameException() {
    when(userDao.existsByUsername("testuser")).thenReturn(true);

    assertThrows(DuplicateUsernameException.class, () -> userService.addUser(user));
  }

  @Test
  void getUsers_returnsList() {
    when(userDao.findAll()).thenReturn(List.of(user));

    List<User> result = userService.getUsers();

    assertEquals(1, result.size());
    assertEquals("testuser", result.get(0).getUsername());
  }

  @Test
  void getUserByUsername_returnsUser() {
    when(userDao.findByUsername("testuser")).thenReturn(Optional.of(user));

    User result = userService.getUserByUsername("testuser");

    assertNotNull(result);
    assertEquals("testuser", result.getUsername());
  }

  @Test
  void getUserByUsername_notFound_returnsNull() {
    when(userDao.findByUsername("ghost")).thenReturn(Optional.empty());

    assertNull(userService.getUserByUsername("ghost"));
  }

  @Test
  void getUserById_returnsUser() {
    when(userDao.findById(1)).thenReturn(Optional.of(user));

    User result = userService.getUserById(1);

    assertNotNull(result);
    assertEquals(1, result.getId());
  }

  @Test
  void getUserById_notFound_returnsNull() {
    when(userDao.findById(99)).thenReturn(Optional.empty());

    assertNull(userService.getUserById(99));
  }

  @Test
  void checkUserExists_returnsTrue() {
    when(userDao.existsByUsername("testuser")).thenReturn(true);

    assertTrue(userService.checkUserExists("testuser"));
  }

  @Test
  void checkUserExists_returnsFalse() {
    when(userDao.existsByUsername("nobody")).thenReturn(false);

    assertFalse(userService.checkUserExists("nobody"));
  }

  @Test
  void updateUser_delegatesToDao() {
    when(userDao.save(user)).thenReturn(user);

    User result = userService.updateUser(user);

    verify(userDao).save(user);
    assertEquals(user, result);
  }

  @Test
  void checkLogin_correctPassword_returnsUser() {
    user.setPassword("{bcrypt}hashed");
    when(userDao.findByUsername("testuser")).thenReturn(Optional.of(user));
    when(passwordEncoder.matches("plaintext", "{bcrypt}hashed")).thenReturn(true);

    User result = userService.checkLogin("testuser", "plaintext");

    assertNotNull(result);
  }

  @Test
  void checkLogin_wrongPassword_returnsNull() {
    user.setPassword("{bcrypt}hashed");
    when(userDao.findByUsername("testuser")).thenReturn(Optional.of(user));
    when(passwordEncoder.matches("wrong", "{bcrypt}hashed")).thenReturn(false);

    assertNull(userService.checkLogin("testuser", "wrong"));
  }
}
