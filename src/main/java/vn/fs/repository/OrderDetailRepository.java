package vn.fs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import vn.fs.dto.ProductStatistics;
import vn.fs.entities.OrderDetail;


@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

	@Query(value = "select * from order_details where order_id = ?;", nativeQuery = true)
	List<OrderDetail> findByOrderId(Long id);
	
	// Statistics by product sold
	@Query(value = "SELECT p.product_name ,\n" +
			"    \t\tSUM(o.quantity) as quantity ,\n" +
			"            pi.base_price as giagoc,\n" +
			"            p.price as giaban,\n" +
			"    \t\t((o.quantity *  p.price) - ((o.quantity *  p.price)*p.discount /100) ) - (pi.base_price * o.quantity) as doanhthu\n" +
			"    \t\tFROM order_details o\n" +
			"    \t\tINNER JOIN products p ON o.product_id = p.product_id\n" +
			"            INNER JOIN product_inventories pi on pi.product_id = p.product_id\n" +
			"    \tGROUP BY p.product_name", nativeQuery = true)
	public List<Object[]> repo();
    
    // Statistics by category sold
	@Query(value = "SELECT \n" +
			"    c.category_name, \n" +
			"    SUM(o.quantity) AS total_quantity,\n" +
			"    SUM(pi.base_price) AS total_base_price,\n" +
			"    SUM(p.price) AS total_revenue,\n" +
			"    SUM(((o.quantity * p.price) - ((o.quantity * p.price) * p.discount / 100)) - (pi.base_price * o.quantity)) AS total_profit\n" +
			"FROM \n" +
			"    order_details o\n" +
			"INNER JOIN \n" +
			"    products p ON o.product_id = p.product_id\n" +
			"INNER JOIN \n" +
			"    categories c ON p.category_id = c.category_id\n" +
			"INNER JOIN \n" +
			"    product_inventories pi ON pi.product_id = p.product_id " +
			"INNER JOIN orders od ON od.order_id = o.order_id WHERE od.status = '2'\n" +
			"GROUP BY \n" +
			"    c.category_name;\n", nativeQuery = true)
	public List<Object[]> repoWhereCategory();

    // Statistics of products sold by year
    @Query(value = "Select YEAR(od.order_date) ,\n" +
			"    \t\tSUM(o.quantity) AS total_quantity,\n" +
			"\t\t\tSUM(pi.base_price) AS total_base_price,\n" +
			"\t\t\tSUM(p.price) AS total_revenue,\n" +
			"\t\t\tSUM(((o.quantity * p.price) - ((o.quantity * p.price) * p.discount / 100)) - (pi.base_price * o.quantity)) AS total_profit\n" +
			"    \t\tFROM order_details o\n" +
			"    \t\tINNER JOIN orders od ON o.order_id = od.order_id\n" +
			"            JOIN products p on p.product_id = o.product_id\n" +
			"            INNER JOIN product_inventories pi ON pi.product_id = p.product_id WHERE od.status = '2'\n" +
			"    \t\tGROUP BY YEAR(od.order_date)", nativeQuery = true)
    public List<Object[]> repoWhereYear();
    
    // Statistics of products sold by month
    @Query(value = "Select month(od.order_date) ,\n" +
			"    \t\tSUM(o.quantity) AS total_quantity,\n" +
			"\t\t\tSUM(pi.base_price) AS total_base_price,\n" +
			"\t\t\tSUM(p.price) AS total_revenue,\n" +
			"\t\t\tSUM(((o.quantity * p.price) - ((o.quantity * p.price) * p.discount / 100)) - (pi.base_price * o.quantity)) AS total_profit\n" +
			"    \t\tFROM order_details o\n" +
			"    \t\tINNER JOIN orders od ON o.order_id = od.order_id\n" +
			"            JOIN products p on p.product_id = o.product_id\n" +
			"            INNER JOIN product_inventories pi ON pi.product_id = p.product_id\n" +
			"    \t\tWHERE od.status = '2'\n" +
			"    \t\tGROUP BY month(od.order_date)", nativeQuery = true)
    public List<Object[]> repoWhereMonth();
    
    // Statistics of products sold by quarter
    @Query(value = "Select QUARTER(od.order_date),\n" +
			"    \t\tSUM(o.quantity) AS total_quantity,\n" +
			"\t\t\tSUM(pi.base_price) AS total_base_price,\n" +
			"\t\t\tSUM(p.price) AS total_revenue,\n" +
			"\t\t\tSUM(((o.quantity * p.price) - ((o.quantity * p.price) * p.discount / 100)) - (pi.base_price * o.quantity)) AS total_profit\n" +
			"    \t\tFROM order_details o\n" +
			"    \t\tINNER JOIN orders od ON o.order_id = od.order_id\n" +
			"            JOIN products p on p.product_id = o.product_id\n" +
			"            INNER JOIN product_inventories pi ON pi.product_id = p.product_id\n" +
			"    \t\tWHERE od.status = '2'\n" +
			"    \t\tGROUP By QUARTER(od.order_date);", nativeQuery = true)
    public List<Object[]> repoWhereQUARTER();
    
    // Statistics by user
    @Query(value = " SELECT c.name,\n" +
			"    \t\tSUM(o.quantity) AS total_quantity,\n" +
			"\t\t\tSUM(pi.base_price) AS total_base_price,\n" +
			"\t\t\tSUM(pr.price) AS total_revenue,\n" +
			"\t\t\tSUM(((o.quantity * pr.price) - ((o.quantity * pr.price) * pr.discount / 100)) - (pi.base_price * o.quantity)) AS total_profit\n" +
			"    \t\tFROM order_details o\n" +
			"    \t\tINNER JOIN orders p ON o.order_id = p.order_id\n" +
			"    \t\tINNER JOIN user c ON p.user_id = c.user_id\n" +
			"            JOIN products pr on pr.product_id = o.product_id\n" +
			"            INNER JOIN product_inventories pi ON pi.product_id = pr.product_id\n" +
			"            WHERE p.status = '2'\n" +
			"    \t\tGROUP BY c.user_id;", nativeQuery = true)
    public List<Object[]> reportCustommer();

	@Query("SELECT new vn.fs.dto.ProductStatistics(p.productId, p.productName, COUNT(od.product.productId)) " +
			"FROM OrderDetail od " +
			"JOIN od.order o " +
			"JOIN od.product p " +
			"GROUP BY p.productId, p.productName " +
			"ORDER BY COUNT(od.product.productId) DESC")
	List<ProductStatistics> getProductMostPurchased();

	void deleteAllByOrder_OrderId(Long orderId);

}
