package com.jtspringproject.exception;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

  @ExceptionHandler(ResourceNotFoundException.class)
  public ModelAndView handleResourceNotFound(ResourceNotFoundException ex) {
    log.warn("Resource not found: {}", ex.getMessage());
    ModelAndView mv = new ModelAndView("error");
    mv.addObject("errorCode", "404");
    mv.addObject("errorMessage", ex.getMessage());
    return mv;
  }

  @ExceptionHandler(DuplicateUsernameException.class)
  public ModelAndView handleDuplicateUsername(DuplicateUsernameException ex) {
    log.warn("Duplicate username attempt: {}", ex.getMessage());
    ModelAndView mv = new ModelAndView("register");
    mv.addObject("msg", ex.getMessage());
    return mv;
  }

  @ExceptionHandler(DataIntegrityViolationException.class)
  public ModelAndView handleDataIntegrityViolation(DataIntegrityViolationException ex) {
    log.error("Database integrity violation: {}", ex.getMessage());
    ModelAndView mv = new ModelAndView("error");
    mv.addObject("errorCode", "409");
    mv.addObject("errorMessage", "A database conflict occurred. The record may already exist.");
    return mv;
  }

  @ExceptionHandler(NoResourceFoundException.class)
  public void handleNoResourceFound(NoResourceFoundException ex, HttpServletResponse response)
      throws IOException {
    log.debug("Static resource not found: {}", ex.getMessage());
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
  }

  @ExceptionHandler(Exception.class)
  public ModelAndView handleGenericException(Exception ex) {
    log.error("Unhandled exception: {}", ex.getMessage(), ex);
    ModelAndView mv = new ModelAndView("error");
    mv.addObject("errorCode", "500");
    mv.addObject("errorMessage", "An unexpected error occurred. Please try again later.");
    return mv;
  }
}
