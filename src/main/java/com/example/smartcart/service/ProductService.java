package com.example.smartcart.service;

import com.example.smartcart.model.Product;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
public class ProductService {
    private final Map<Long, Product> store = new ConcurrentHashMap<>();
    private final AtomicLong seq = new AtomicLong(100);

    public ProductService() {
        saveSeed(new Product(1L, "MacBook Pro 14", "Apple laptop with M3 chip", 1999.99, "laptop", 10));
        saveSeed(new Product(2L, "Dell XPS 13", "Compact developer laptop", 1299.49, "laptop", 15));
        saveSeed(new Product(3L, "iPhone 15", "Apple smartphone", 999.00, "mobile", 25));
        saveSeed(new Product(4L, "Samsung Galaxy S24", "Android flagship phone", 899.99, "mobile", 30));
        saveSeed(new Product(5L, "iPad Air", "Lightweight tablet", 649.00, "tablet", 20));
        saveSeed(new Product(6L, "Samsung Tab S9", "Android tablet", 749.99, "tablet", 12));
        saveSeed(new Product(7L, "Sony WH-1000XM5", "Noise cancelling headphones", 349.99, "audio", 40));
        saveSeed(new Product(8L, "Logitech MX Master 3S", "Wireless mouse", 99.99, "accessories", 100));
    }

    private void saveSeed(Product p) {
        store.put(p.getId(), p);
    }

    public List<Product> findAll(String category, String search) {
        return store.values().stream()
                .filter(p -> category == null || category.isBlank()
                        || p.getCategory().equalsIgnoreCase(category))
                .filter(p -> search == null || search.isBlank()
                        || p.getName().toLowerCase().contains(search.toLowerCase())
                        || (p.getDescription() != null && p.getDescription().toLowerCase().contains(search.toLowerCase())))
                .sorted((a, b) -> a.getId().compareTo(b.getId()))
                .collect(Collectors.toList());
    }

    public List<Product> findAll() {
        return new ArrayList<>(store.values()).stream()
                .sorted((a, b) -> a.getId().compareTo(b.getId()))
                .collect(Collectors.toList());
    }

    public Product findById(Long id) {
        return store.get(id);
    }

    public Product create(Product p) {
        long id = seq.incrementAndGet();
        // keep deterministic small ids for tests if not colliding: use max+1
        if (store.isEmpty()) {
            id = 1;
        } else {
            long max = store.keySet().stream().mapToLong(Long::longValue).max().orElse(0);
            id = max + 1;
        }
        p.setId(id);
        store.put(id, p);
        return p;
    }

    public Product update(Long id, Product p) {
        Product existing = store.get(id);
        if (existing == null) return null;
        existing.setName(p.getName());
        existing.setDescription(p.getDescription());
        existing.setPrice(p.getPrice());
        existing.setCategory(p.getCategory());
        existing.setStock(p.getStock());
        return existing;
    }

    public boolean delete(Long id) {
        return store.remove(id) != null;
    }

    public String validate(Product p) {
        if (p.getName() == null || p.getName().isBlank()) return "Product name is required";
        if (p.getPrice() == null) return "Product price is required";
        if (p.getPrice() <= 0) return "Product price must be greater than 0";
        if (p.getCategory() == null || p.getCategory().isBlank()) return "Product category is required";
        return null;
    }
}
