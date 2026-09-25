package com.example.smartcart.service;

import com.example.smartcart.model.Cart;
import com.example.smartcart.model.CartItem;
import com.example.smartcart.model.Product;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class CartService {
    private final Map<Long, Cart> store = new ConcurrentHashMap<>();
    private final AtomicLong seq = new AtomicLong(1000);
    private final ProductService products;

    public CartService(ProductService products) {
        this.products = products;
    }

    public Cart createCart(Long userId) {
        Cart c = new Cart(seq.incrementAndGet());
        c.setUserId(userId);
        c.recalculate();
        store.put(c.getId(), c);
        return c;
    }

    public Cart findById(Long id) {
        return store.get(id);
    }

    public Cart addItem(Long cartId, Long productId, Integer quantity) {
        Cart cart = store.get(cartId);
        if (cart == null) return null;
        Product p = products.findById(productId);
        if (p == null) return null;
        if (quantity == null || quantity <= 0) return cart; // caller validates
        CartItem existing = cart.getItems().stream()
                .filter(i -> i.getProductId().equals(productId))
                .findFirst().orElse(null);
        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + quantity);
            existing.setPrice(p.getPrice());
            existing.setProductName(p.getName());
            existing.setSubtotal(existing.getPrice() * existing.getQuantity());
        } else {
            cart.getItems().add(new CartItem(productId, p.getName(), p.getPrice(), quantity));
        }
        cart.recalculate();
        return cart;
    }

    public boolean removeItem(Long cartId, Long productId) {
        Cart cart = store.get(cartId);
        if (cart == null) return false;
        boolean removed = cart.getItems().removeIf(i -> i.getProductId().equals(productId));
        cart.recalculate();
        return removed;
    }
}
