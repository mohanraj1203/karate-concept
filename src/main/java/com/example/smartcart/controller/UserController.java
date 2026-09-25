package com.example.smartcart.controller;

import com.example.smartcart.model.User;
import com.example.smartcart.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService users;

    public UserController(UserService users) {
        this.users = users;
    }

    @GetMapping
    public List<User> list() {
        return users.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> get(@PathVariable Long id) {
        User u = users.findById(id);
        if (u == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "User not found with id " + id, "status", 404));
        }
        return ResponseEntity.ok(u);
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestBody User body) {
        String err = users.validate(body);
        if (err != null) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", err, "status", 400));
        }
        return ResponseEntity.status(201).body(users.create(body));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody User body) {
        User updated = users.update(id, body);
        if (updated == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "User not found with id " + id, "status", 404));
        }
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        boolean ok = users.delete(id);
        if (!ok) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "User not found with id " + id, "status", 404));
        }
        return ResponseEntity.ok(Map.of("message", "User deleted", "id", id));
    }
}
