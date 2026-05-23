package com.jtspringproject.exception;

public class ResourceNotFoundException extends RuntimeException {

  public ResourceNotFoundException(String message) {
    super(message);
  }

  public ResourceNotFoundException(String resourceType, int id) {
    super(resourceType + " not found with id: " + id);
  }
}
