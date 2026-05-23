package com.jtspringproject.services;

import com.jtspringproject.dao.CartDao;
import com.jtspringproject.dao.CartProductDao;
import com.jtspringproject.models.Cart;
import com.jtspringproject.models.CartProduct;
import com.jtspringproject.models.Product;
import com.jtspringproject.models.User;
import java.util.List;
import java.util.Optional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
public class CartService {

  private final CartDao cartDao;
  private final CartProductDao cartProductDao;

  @Autowired
  public CartService(CartDao cartDao, CartProductDao cartProductDao) {
    this.cartDao = cartDao;
    this.cartProductDao = cartProductDao;
  }

  /** Returns the user's cart, creating one if it doesn't exist yet. */
  @Transactional
  public Cart getOrCreateCart(User user) {
    List<Cart> carts = cartDao.findByCustomer_Id(user.getId());
    if (!carts.isEmpty()) {
      return carts.get(0);
    }
    Cart cart = new Cart();
    cart.setCustomer(user);
    Cart saved = cartDao.save(cart);
    log.info("Created new cart for user: {}", user.getUsername());
    return saved;
  }

  /** Adds a product to the user's cart, adding the given quantity to any existing quantity. */
  @Transactional
  public CartProduct addProduct(User user, Product product, int quantityToAdd) {
    Cart cart = getOrCreateCart(user);
    Optional<CartProduct> existing = cartProductDao.findByCart_IdAndProduct_Id(cart.getId(), product.getId());
    CartProduct item;
    if (existing.isPresent()) {
      item = existing.get();
      item.setQuantity(item.getQuantity() + quantityToAdd);
    } else {
      item = new CartProduct(cart, product);
      item.setQuantity(quantityToAdd);
    }
    CartProduct saved = cartProductDao.save(item);
    log.info("Added product '{}' (+{} → qty={}) to cart for user: {}",
        product.getName(), quantityToAdd, saved.getQuantity(), user.getUsername());
    return saved;
  }

  /** Increases the quantity of a cart item by 1. */
  @Transactional
  public void increaseQuantity(int cartProductId) {
    cartProductDao.findById(cartProductId).ifPresent(item -> {
      item.setQuantity(item.getQuantity() + 1);
      cartProductDao.save(item);
      log.debug("Increased qty for cart item id={} to {}", cartProductId, item.getQuantity());
    });
  }

  /** Decreases the quantity of a cart item by 1, removing it if quantity reaches 0. */
  @Transactional
  public void decreaseQuantity(int cartProductId) {
    cartProductDao.findById(cartProductId).ifPresent(item -> {
      if (item.getQuantity() > 1) {
        item.setQuantity(item.getQuantity() - 1);
        cartProductDao.save(item);
        log.debug("Decreased qty for cart item id={} to {}", cartProductId, item.getQuantity());
      } else {
        cartProductDao.delete(item);
        log.debug("Removed cart item id={} (qty reached 0)", cartProductId);
      }
    });
  }

  /** Returns all items in the user's cart. */
  @Transactional(readOnly = true)
  public List<CartProduct> getCartItems(User user) {
    Cart cart = getOrCreateCart(user);
    return cartProductDao.findByCart_Id(cart.getId());
  }

  /** Removes a single cart item by its CartProduct id. */
  @Transactional
  public void removeItem(int cartProductId) {
    cartProductDao.deleteById(cartProductId);
    log.info("Removed cart item: id={}", cartProductId);
  }

  /** Clears all items from the user's cart. */
  @Transactional
  public void clearCart(User user) {
    Cart cart = getOrCreateCart(user);
    List<CartProduct> items = cartProductDao.findByCart_Id(cart.getId());
    cartProductDao.deleteAll(items);
    log.info("Cleared cart for user: {}", user.getUsername());
  }
}
