package com.jtspringproject.dao;

import com.jtspringproject.models.CartProduct;
import com.jtspringproject.models.Product;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface CartProductDao extends JpaRepository<CartProduct, Integer> {

  List<CartProduct> findByCart_Id(int cartId);

  Optional<CartProduct> findByCart_IdAndProduct_Id(int cartId, int productId);

  @Query("SELECT cp.product FROM CART_PRODUCT cp WHERE cp.cart.id = :cartId")
  List<Product> findProductsByCartId(int cartId);
}
