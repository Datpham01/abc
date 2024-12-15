package vn.fs.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.fs.commom.CommomDataService;
import vn.fs.entities.Comment;
import vn.fs.entities.Product;
import vn.fs.entities.ProductInventory;
import vn.fs.entities.User;
import vn.fs.repository.CommentRepository;
import vn.fs.repository.ProductInventoryRepository;
import vn.fs.repository.ProductRepository;


@Controller
public class ProductDetailController extends CommomController{
	
	@Autowired
	ProductRepository productRepository;
	
	@Autowired
	CommomDataService commomDataService;

	@Autowired
	CommentRepository commentRepository;

	@Autowired
	ProductInventoryRepository productInventoryRepository;

	@GetMapping(value = "productDetail")
	public String productDetail(@RequestParam("id") Long id, Model model, User user) {

		Product product = productRepository.findById(id).orElse(null);
		ProductInventory productInventory = productInventoryRepository.findProductInventoryByProduct_ProductId(id);
		if(product != null && productInventory != null) {
			product.setQuantity(productInventory.getQuantity());
		}
		model.addAttribute("product", product);

		List<Comment> commentList = commentRepository.findByProduct_ProductId(id).orElse(null);
		model.addAttribute("commentList", commentList);

		commomDataService.commonData(model, user);
		listProductByCategory10(model, product.getCategory().getCategoryId());

		return "web/productDetail";
	}

	@PostMapping("/addComment")
	public String addComment(@RequestParam("productId") Long productId,
							 @RequestParam("content") String content,
							 Principal principal, Model model) {
		// Kiểm tra xem user đã đăng nhập hay chưa
		if (principal == null) {
			model.addAttribute("error", "You must be logged in to comment.");
			return "redirect:/login";
		}

		// Lấy product theo productId
		Product product = productRepository.findById(productId)
				.orElseThrow(() -> new RuntimeException("Product not found"));

		String email = principal.getName();
		User user = userRepository.findByEmail(email);

		// Tạo đối tượng Comment mới
		Comment comment = new Comment();
		comment.setProduct(product);
		comment.setUser(user);
		comment.setRating(0.0);
		comment.setContent(content);
		comment.setRateDate(new Date());

		// Lưu vào database
		commentRepository.save(comment);

		// Redirect lại trang chi tiết sản phẩm
		return "redirect:/productDetail?id=" + productId;
	}
	
	// Gợi ý top 10 sản phẩm cùng loại
	public void listProductByCategory10(Model model, Long categoryId) {
		List<Product> products = productRepository.listProductByCategory10(categoryId);
		model.addAttribute("productByCategory", products);
	}
}
