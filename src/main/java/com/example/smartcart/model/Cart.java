package com.example.smartcart.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private Long id;
    private Long userId;
    private List<CartItem> items = new ArrayList<>();
    private Double total = 0.0;
    private Integer itemCount = 0;

    public Cart() {}

    public Cart(Long id) {
        this.id = id;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }
    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
    public Integer getItemCount() { return itemCount; }
    public void setItemCount(Integer itemCount) { this.itemCount = itemCount; }

    public void recalculate() {
        double t = 0.0;
        int c = 0;
        for (CartItem i : items) {
            t += i.getSubtotal() != null ? i.getSubtotal() : 0.0;
            c += i.getQuantity() != null ? i.getQuantity() : 0;
        }
        this.total = Math.round(t * 100.0) / 100.0;
        this.itemCount = c;
    }
}
