package com.example.smartcart.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * Records the request start time. Headers themselves are added by
 * {@link HeaderAdvice} in {@code beforeBodyWrite}, which runs BEFORE the
 * response is committed (setting headers after the chain returns is too
 * late - Spring already flushed the body).
 */
@Component
public class HeaderFilter implements Filter {

    public static final String START_TIME_ATTR = "smartcart.startTime";

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        if (req instanceof HttpServletRequest httpReq) {
            String path = httpReq.getRequestURI();
            if (path != null && path.startsWith("/api/")) {
                req.setAttribute(START_TIME_ATTR, System.currentTimeMillis());
            }
        }
        chain.doFilter(req, res);
    }
}
