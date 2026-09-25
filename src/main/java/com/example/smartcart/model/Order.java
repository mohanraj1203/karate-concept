package com.example.smartcart.model;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private Long id;
    private Long cartId;
    private Long userId;
    private String username;
    private String status;
    private Double total;
    private Integer itemCount;
    private List<CartItem> items = new ArrayList<>();
    private String createdAt;

    public Order() {
        this.createdAt = Instant.now().toString();
        this.status = "CREATED";
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getCartId() { return cartId; }
    public void setCartId(Long cartId) { this.cartId = cartId; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
    public Integer getItemCount() { return itemCount; }
    public void setItemCount(Integer itemCount) { this.itemCount = itemCount; }
    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
