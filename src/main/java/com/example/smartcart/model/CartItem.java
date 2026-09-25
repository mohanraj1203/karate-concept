package com.example.smartcart.model;

public class CartItem {
    private Long productId;
    private String productName;
    private Double price;
    private Integer quantity;
    private Double subtotal;

    public CartItem() {}

    public CartItem(Long productId, String productName, Double price, Integer quantity) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.subtotal = price * quantity;
    }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        if (this.price != null && quantity != null) {
            this.subtotal = this.price * quantity;
        }
    }
    public Double getSubtotal() { return subtotal; }
    public void setSubtotal(Double subtotal) { this.subtotal = subtotal; }
}
