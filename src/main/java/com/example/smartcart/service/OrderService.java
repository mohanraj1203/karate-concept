package com.example.smartcart.service;

import com.example.smartcart.model.Cart;
import com.example.smartcart.model.Order;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class OrderService {
    private final Map<Long, Order> store = new ConcurrentHashMap<>();
    private final AtomicLong seq = new AtomicLong(5000);
    private final CartService carts;
    private final UserService users;

    public OrderService(CartService carts, UserService users) {
        this.carts = carts;
        this.users = users;
    }

    public Order createFromCart(Long cartId, String username) {
        Cart cart = carts.findById(cartId);
        if (cart == null) return null;
        Order o = new Order();
        o.setId(seq.incrementAndGet());
        o.setCartId(cartId);
        o.setItems(new ArrayList<>(cart.getItems()));
        o.setTotal(cart.getTotal());
        o.setItemCount(cart.getItemCount());
        o.setStatus("CREATED");
        o.setUsername(username);
        if (username != null) {
            var u = users.findByUsername(username);
            if (u != null) o.setUserId(u.getId());
        }
        store.put(o.getId(), o);
        return o;
    }

    public Order findById(Long id) {
        return store.get(id);
    }

    public List<Order> findAll() {
        return new ArrayList<>(store.values()).stream()
                .sorted((a, b) -> a.getId().compareTo(b.getId()))
                .toList();
    }

    public Order cancel(Long id) {
        Order o = store.get(id);
        if (o == null) return null;
        o.setStatus("CANCELLED");
        return o;
    }
}
