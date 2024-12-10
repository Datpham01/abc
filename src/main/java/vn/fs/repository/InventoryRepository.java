package vn.fs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.fs.entities.Inventory;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory, Integer> {
}
