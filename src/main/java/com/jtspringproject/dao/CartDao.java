package com.jtspringproject.dao;

import com.jtspringproject.models.Cart;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartDao extends JpaRepository<Cart, Integer> {

  List<Cart> findByCustomer_Id(int customerId);
}
