package vn.fs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.fs.entities.ProductInventory;

import java.util.List;

@Repository
public interface ProductInventoryRepository extends JpaRepository<ProductInventory, Integer> {
    List<ProductInventory> findProductInventoryByInventory_InventoryId(Integer inventoryId);
    boolean existsByProduct_ProductId(Long productId);
    ProductInventory findProductInventoryByProduct_ProductId(Long productId);
}
