package com.example.smartcart.controller;

import jakarta.servlet.Filter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Explicitly registers servlet filters so header injection
 * cannot be lost by component-scan edge cases.
 */
@Configuration
public class WebConfig {

    @Bean
    public FilterRegistrationBean<Filter> headerFilterRegistration(HeaderFilter filter) {
        FilterRegistrationBean<Filter> registration = new FilterRegistrationBean<>(filter);
        registration.addUrlPatterns("/api/*");
        registration.setOrder(1);
        return registration;
    }
}
