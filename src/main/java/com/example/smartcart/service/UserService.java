package com.example.smartcart.service;

import com.example.smartcart.model.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class UserService {
    private final Map<Long, User> store = new ConcurrentHashMap<>();

    public UserService() {
        store.put(1L, new User(1L, "student", "student@example.com", "password123", "Test Student"));
        store.put(2L, new User(2L, "admin", "admin@example.com", "admin123", "Shop Admin"));
    }

    public List<User> findAll() {
        return new ArrayList<>(store.values()).stream()
                .sorted((a, b) -> a.getId().compareTo(b.getId()))
                .toList();
    }

    public User findById(Long id) {
        return store.get(id);
    }

    public User findByUsername(String username) {
        return store.values().stream()
                .filter(u -> u.getUsername().equalsIgnoreCase(username))
                .findFirst().orElse(null);
    }

    public User create(User u) {
        long max = store.keySet().stream().mapToLong(Long::longValue).max().orElse(0);
        u.setId(max + 1);
        store.put(u.getId(), u);
        return u;
    }

    public User update(Long id, User u) {
        User existing = store.get(id);
        if (existing == null) return null;
        if (u.getEmail() != null) existing.setEmail(u.getEmail());
        if (u.getFullName() != null) existing.setFullName(u.getFullName());
        if (u.getPassword() != null && !u.getPassword().isBlank()) existing.setPassword(u.getPassword());
        return existing;
    }

    public boolean delete(Long id) {
        return store.remove(id) != null;
    }

    public String validate(User u) {
        if (u.getUsername() == null || u.getUsername().isBlank()) return "Username is required";
        if (u.getEmail() == null || u.getEmail().isBlank()) return "Email is required";
        if (!u.getEmail().contains("@")) return "Email must be valid";
        if (u.getPassword() == null || u.getPassword().isBlank()) return "Password is required";
        if (u.getPassword().length() < 6) return "Password must be at least 6 characters";
        if (findByUsername(u.getUsername()) != null) return "Username already exists";
        return null;
    }
}
