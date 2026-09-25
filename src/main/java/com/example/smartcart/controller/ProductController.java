package com.example.smartcart.controller;

import com.example.smartcart.model.Product;
import com.example.smartcart.service.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService products;

    public ProductController(ProductService products) {
        this.products = products;
    }

    @GetMapping
    public List<Product> list(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String search) {
        return products.findAll(category, search);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> get(@PathVariable Long id) {
        Product p = products.findById(id);
        if (p == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found",
                    "message", "Product not found with id " + id,
                    "status", 404));
        }
        return ResponseEntity.ok(p);
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestBody Product body) {
        String err = products.validate(body);
        if (err != null) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", err, "status", 400));
        }
        return ResponseEntity.status(201).body(products.create(body));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody Product body) {
        if (products.findById(id) == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found",
                    "message", "Product not found with id " + id,
                    "status", 404));
        }
        String err = products.validate(body);
        if (err != null) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", err, "status", 400));
        }
        return ResponseEntity.ok(products.update(id, body));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        boolean ok = products.delete(id);
        if (!ok) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found",
                    "message", "Product not found with id " + id,
                    "status", 404));
        }
        return ResponseEntity.ok(Map.of("message", "Product deleted", "id", id));
    }
}
