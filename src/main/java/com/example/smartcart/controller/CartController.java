package com.example.smartcart.controller;

import com.example.smartcart.model.Cart;
import com.example.smartcart.service.AuthService;
import com.example.smartcart.service.CartService;
import com.example.smartcart.service.ProductService;
import com.example.smartcart.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/carts")
public class CartController {

    private final CartService carts;
    private final ProductService products;
    private final AuthService auth;
    private final UserService users;

    public CartController(CartService carts, ProductService products, AuthService auth, UserService users) {
        this.carts = carts;
        this.products = products;
        this.auth = auth;
        this.users = users;
    }

    private String requireAuth(String h) {
        return auth.validateAndGetUsername(h);
    }

    private ResponseEntity<Map<String, Object>> unauthorized() {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("error", "Unauthorized");
        m.put("message", "Missing or invalid token");
        m.put("status", 401);
        return ResponseEntity.status(401).body(m);
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                    @RequestBody(required = false) Map<String, Object> body) {
        String username = requireAuth(authHeader);
        if (username == null) return unauthorized();
        var u = users.findByUsername(username);
        Cart c = carts.createCart(u != null ? u.getId() : null);
        return ResponseEntity.status(201).body(c);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> get(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                 @PathVariable Long id) {
        String username = requireAuth(authHeader);
        if (username == null) return unauthorized();
        Cart c = carts.findById(id);
        if (c == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Cart not found with id " + id, "status", 404));
        }
        return ResponseEntity.ok(c);
    }

    @PostMapping("/{id}/items")
    public ResponseEntity<?> addItem(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                     @PathVariable Long id,
                                     @RequestBody Map<String, Object> body) {
        String username = requireAuth(authHeader);
        if (username == null) return unauthorized();
        Cart c = carts.findById(id);
        if (c == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Cart not found with id " + id, "status", 404));
        }
        Object pidObj = body.get("productId");
        Object qtyObj = body.get("quantity");
        if (pidObj == null || qtyObj == null) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", "productId and quantity are required", "status", 400));
        }
        Long productId;
        Integer qty;
        try {
            productId = Long.valueOf(String.valueOf(pidObj));
            qty = Integer.valueOf(String.valueOf(qtyObj));
        } catch (NumberFormatException e) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", "productId and quantity must be numbers", "status", 400));
        }
        if (qty <= 0) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", "quantity must be greater than 0", "status", 400));
        }
        if (products.findById(productId) == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Product not found with id " + productId, "status", 404));
        }
        return ResponseEntity.ok(carts.addItem(id, productId, qty));
    }

    @DeleteMapping("/{id}/items/{productId}")
    public ResponseEntity<?> removeItem(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                        @PathVariable Long id, @PathVariable Long productId) {
        String username = requireAuth(authHeader);
        if (username == null) return unauthorized();
        Cart c = carts.findById(id);
        if (c == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Cart not found with id " + id, "status", 404));
        }
        boolean removed = carts.removeItem(id, productId);
        if (!removed) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Product " + productId + " not in cart", "status", 404));
        }
        return ResponseEntity.ok(carts.findById(id));
    }

    @GetMapping("/{id}/total")
    public ResponseEntity<?> total(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                   @PathVariable Long id) {
        String username = requireAuth(authHeader);
        if (username == null) return unauthorized();
        Cart c = carts.findById(id);
        if (c == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Cart not found with id " + id, "status", 404));
        }
        Map<String, Object> resp = new LinkedHashMap<>();
        resp.put("cartId", c.getId());
        resp.put("total", c.getTotal());
        resp.put("itemCount", c.getItemCount());
        resp.put("items", c.getItems());
        return ResponseEntity.ok(resp);
    }
}
