package com.example.smartcart.controller;

import com.example.smartcart.model.Cart;
import com.example.smartcart.model.Order;
import com.example.smartcart.service.AuthService;
import com.example.smartcart.service.CartService;
import com.example.smartcart.service.OrderService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orders;
    private final CartService carts;
    private final AuthService auth;

    public OrderController(OrderService orders, CartService carts, AuthService auth) {
        this.orders = orders;
        this.carts = carts;
        this.auth = auth;
    }

    private ResponseEntity<Map<String, Object>> unauthorized() {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("error", "Unauthorized");
        m.put("message", "Missing or invalid token");
        m.put("status", 401);
        return ResponseEntity.status(401).body(m);
    }

    @GetMapping
    public ResponseEntity<?> list(@RequestHeader(value = "Authorization", required = false) String authHeader) {
        if (auth.validateAndGetUsername(authHeader) == null) return unauthorized();
        List<Order> all = orders.findAll();
        return ResponseEntity.ok(all);
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                    @RequestBody Map<String, Object> body) {
        String username = auth.validateAndGetUsername(authHeader);
        if (username == null) return unauthorized();
        Object cartIdObj = body.get("cartId");
        if (cartIdObj == null) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", "cartId is required", "status", 400));
        }
        Long cartId;
        try {
            cartId = Long.valueOf(String.valueOf(cartIdObj));
        } catch (NumberFormatException e) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", "cartId must be a number", "status", 400));
        }
        Cart cart = carts.findById(cartId);
        if (cart == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Cart not found with id " + cartId, "status", 404));
        }
        if (cart.getItems() == null || cart.getItems().isEmpty()) {
            return ResponseEntity.status(400).body(Map.of(
                    "error", "Bad Request", "message", "Cannot create order from empty cart", "status", 400));
        }
        Order o = orders.createFromCart(cartId, username);
        return ResponseEntity.status(201).body(o);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> get(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                 @PathVariable Long id) {
        if (auth.validateAndGetUsername(authHeader) == null) return unauthorized();
        Order o = orders.findById(id);
        if (o == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Order not found with id " + id, "status", 404));
        }
        return ResponseEntity.ok(o);
    }

    @DeleteMapping("/{id}/cancel")
    public ResponseEntity<?> cancel(@RequestHeader(value = "Authorization", required = false) String authHeader,
                                    @PathVariable Long id) {
        if (auth.validateAndGetUsername(authHeader) == null) return unauthorized();
        Order o = orders.findById(id);
        if (o == null) {
            return ResponseEntity.status(404).body(Map.of(
                    "error", "Not Found", "message", "Order not found with id " + id, "status", 404));
        }
        return ResponseEntity.ok(orders.cancel(id));
    }
}
