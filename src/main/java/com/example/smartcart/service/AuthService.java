package com.example.smartcart.service;

import com.example.smartcart.model.User;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Service
public class AuthService {

    private static final String SECRET = "smartcart";

    private final UserService users;

    public AuthService(UserService users) {
        this.users = users;
    }

    public User authenticate(String username, String password) {
        User u = users.findByUsername(username);
        if (u != null && u.getPassword().equals(password)) {
            return u;
        }
        return null;
    }

    public String generateToken(User user) {
        String raw = user.getUsername() + ":" + SECRET;
        return Base64.getEncoder().encodeToString(raw.getBytes(StandardCharsets.UTF_8));
    }

    /** Returns username if token valid, else null. */
    public String validateAndGetUsername(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) return null;
        String token = authHeader.substring(7).trim();
        if (token.isEmpty()) return null;
        try {
            String decoded = new String(Base64.getDecoder().decode(token), StandardCharsets.UTF_8);
            String[] parts = decoded.split(":");
            if (parts.length != 2) return null;
            if (!SECRET.equals(parts[1])) return null;
            User u = users.findByUsername(parts[0]);
            if (u == null) return null;
            return u.getUsername();
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}
