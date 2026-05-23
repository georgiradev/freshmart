package com.jtspringproject.configuration;

import com.jtspringproject.models.User;
import com.jtspringproject.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import jakarta.servlet.DispatcherType;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {

  private final UserService userService;

  @Autowired
  public SecurityConfiguration(UserService userService) {
    this.userService = userService;
  }

  @Bean
  UserDetailsService userDetailsService() {
    return username -> {
      User user = userService.getUserByUsername(username);
      if (user == null) {
        throw new UsernameNotFoundException("User not found: " + username);
      }
      String role = "ROLE_ADMIN".equals(user.getRole()) ? "ADMIN" : "USER";

      // Support both BCrypt-hashed passwords ({bcrypt}... or $2a$/$2b$) and
      // legacy plain-text passwords in the database (wrapped with {noop} for DelegatingPasswordEncoder).
      String storedPassword = user.getPassword();
      if (!storedPassword.startsWith("{") && !storedPassword.startsWith("$2")) {
        storedPassword = "{noop}" + storedPassword;
      }

      return org.springframework.security.core.userdetails.User.withUsername(username)
          .password(storedPassword)
          .roles(role)
          .build();
    };
  }

  /** Admin security chain — handles /admin/** routes, requires ROLE_ADMIN. */
  @Configuration
  @Order(1)
  public static class AdminConfigurationAdapter {

    @Bean
    SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
      http
          .securityMatcher("/admin/**")
          .authorizeHttpRequests(auth -> auth
              .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
              .requestMatchers("/admin/login").permitAll()
              .requestMatchers("/admin/**").hasRole("ADMIN"))
          .formLogin(login -> login
              .loginPage("/admin/login")
              .loginProcessingUrl("/admin/loginvalidate")
              .successHandler((req, res, auth) -> res.sendRedirect("/admin/"))
              .failureHandler((req, res, ex) -> res.sendRedirect("/admin/login?error=true")))
          .logout(logout -> logout
              .logoutUrl("/admin/logout")
              .logoutSuccessUrl("/admin/login")
              .deleteCookies("JSESSIONID"))
          .exceptionHandling(ex -> ex.accessDeniedPage("/403"))
          .csrf(AbstractHttpConfigurer::disable);
      return http.build();
    }
  }

  /** User security chain — handles all other routes, requires ROLE_USER. */
  @Configuration
  @Order(2)
  public static class UserConfigurationAdapter {

    @Bean
    SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
      http
          .authorizeHttpRequests(auth -> auth
              .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
              .requestMatchers("/login", "/register", "/newuserregister", "/403", "/error",
                  "/images/**", "/css/**", "/js/**", "/uploads/**", "/h2-console/**", "/test", "/test2")
              .permitAll()
              .requestMatchers("/**").hasRole("USER"))
          .formLogin(login -> login
              .loginPage("/login")
              .loginProcessingUrl("/userloginvalidate")
              .successHandler((req, res, auth) -> {
                boolean isAdmin = auth.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
                res.sendRedirect(isAdmin ? "/admin/" : "/");
              })
              .failureHandler((req, res, ex) -> res.sendRedirect("/login?error=true")))
          .logout(logout -> logout
              .logoutUrl("/logout")
              .logoutSuccessUrl("/login")
              .deleteCookies("JSESSIONID"))
          .exceptionHandling(ex -> ex.accessDeniedPage("/403"))
          .csrf(AbstractHttpConfigurer::disable);
      return http.build();
    }
  }
}
