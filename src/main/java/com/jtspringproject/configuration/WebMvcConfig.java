package com.jtspringproject.configuration;

import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
    registry.addResourceHandler("/uploads/**")
        .addResourceLocations("file:uploads/");
  }

  /**
   * Forces Tomcat to use UTF-8 for all JSP responses so that non-ASCII characters
   * (e.g. the Euro sign €) are encoded correctly.
   */
  @Bean
  public TomcatServletWebServerFactory tomcatFactory() {
    TomcatServletWebServerFactory factory = new TomcatServletWebServerFactory();
    factory.addContextCustomizers(context -> {
      context.setRequestCharacterEncoding("UTF-8");
      context.setResponseCharacterEncoding("UTF-8");
    });
    return factory;
  }
}
