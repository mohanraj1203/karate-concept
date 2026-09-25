package com.example.smartcart.controller;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * Adds SmartCart headers to every API response. {@code beforeBodyWrite} runs
 * before the message converter writes (and commits) the response, so headers
 * reliably reach the client.
 */
@ControllerAdvice(basePackages = "com.example.smartcart.controller")
public class HeaderAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType,
                            Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType,
                                  MediaType selectedContentType,
                                  Class<? extends HttpMessageConverter<?>> selectedConverterType,
                                  ServerHttpRequest request, ServerHttpResponse response) {
        response.getHeaders().set("X-SmartCart-Version", "1.0");
        if (request instanceof ServletServerHttpRequest servletRequest) {
            Object start = servletRequest.getServletRequest()
                    .getAttribute(HeaderFilter.START_TIME_ATTR);
            if (start instanceof Long startTime) {
                response.getHeaders().set("X-Response-Time-ms",
                        String.valueOf(System.currentTimeMillis() - startTime));
            }
        }
        return body;
    }
}
