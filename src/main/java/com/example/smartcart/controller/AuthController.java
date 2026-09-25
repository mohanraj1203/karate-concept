package com.example.smartcart.controller;

import com.example.smartcart.model.User;
import com.example.smartcart.service.AuthService;
import com.example.smartcart.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService auth;
    private final UserService users;

    public AuthController(AuthService auth, UserService users) {
        this.auth = auth;
        this.users = users;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> body) {
        String username = body.get("username");
        String password = body.get("password");
        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request",
                    "message", "username and password are required",
                    "status", 400));
        }
        User u = auth.authenticate(username, password);
        if (u == null) {
            return ResponseEntity.status(401).body(Map.of(
                    "error", "Unauthorized",
                    "message", "Invalid username or password",
                    "status", 401));
        }
        Map<String, Object> resp = new LinkedHashMap<>();
        resp.put("token", auth.generateToken(u));
        resp.put("tokenType", "Bearer");
        resp.put("username", u.getUsername());
        resp.put("userId", u.getId());
        return ResponseEntity.ok(resp);
    }

    @GetMapping("/me")
    public ResponseEntity<?> me(@RequestHeader(value = "Authorization", required = false) String authHeader) {
        String username = auth.validateAndGetUsername(authHeader);
        if (username == null) {
            return ResponseEntity.status(401).body(Map.of(
                    "error", "Unauthorized",
                    "message", "Missing or invalid token",
                    "status", 401));
        }
        User u = users.findByUsername(username);
        Map<String, Object> resp = new LinkedHashMap<>();
        resp.put("id", u.getId());
        resp.put("username", u.getUsername());
        resp.put("email", u.getEmail());
        resp.put("fullName", u.getFullName());
        return ResponseEntity.ok(resp);
    }
}
