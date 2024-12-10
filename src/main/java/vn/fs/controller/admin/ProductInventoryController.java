package vn.fs.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import vn.fs.entities.Inventory;
import vn.fs.entities.Product;
import vn.fs.entities.ProductInventory;
import vn.fs.entities.User;
import vn.fs.repository.InventoryRepository;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.ProductInventoryRepository;
import vn.fs.repository.ProductRepository;
import vn.fs.repository.UserRepository;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class ProductInventoryController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    InventoryRepository inventoryRepository;

    @Autowired
    ProductInventoryRepository productInventoryRepository;

    @ModelAttribute(value = "user")
    public User user(Model model, Principal principal) {
        if (principal != null) {
            if (principal instanceof OAuth2AuthenticationToken) {
                OAuth2AuthenticationToken oAuth2Token = (OAuth2AuthenticationToken) principal;
                Map<String, Object> attributes = oAuth2Token.getPrincipal().getAttributes();
                String email = (String) attributes.get("email");

                if (email != null) {
                    User user = userRepository.findByEmail(email);
                    if (user != null) {
                        model.addAttribute("user", user);
                        return user;
                    }
                }
            } else {
                String email = principal.getName();
                User user = userRepository.findByEmail(email);
                if (user != null) {
                    model.addAttribute("user", user);
                    return user;
                }
            }
        }

        User anonymousUser = new User();
        model.addAttribute("user", anonymousUser);
        return anonymousUser;
    }

    @ModelAttribute("productInventoryList")
    public List<ProductInventory> getListProductInventory(Model model) {
        List<ProductInventory> productInventories = productInventoryRepository.findAll();
        model.addAttribute("productInventoryList", productInventories);
        return productInventories;
    }

    @GetMapping("/productInventory")
    public String getProductInventory(Model model, Principal principal) {
        ProductInventory productInventory = new ProductInventory();
        model.addAttribute("productInventory", productInventory);
        return "admin/productInventory";
    }

    @ModelAttribute("productList")
    public List<Product> getProductList(Model model) {
        List<Product> products = productRepository.findAll();
        model.addAttribute("productList", products);
        return products;
    }

    @ModelAttribute("inventoryList")
    public List<Inventory> getInventoryList(Model model) {
        List<Inventory> inventories = inventoryRepository.findAll();
        model.addAttribute("inventoryList", inventories);
        return inventories;
    }

    @PostMapping(value = "/addProductInventory")
    public String addProductInventory(@ModelAttribute("productInventory") ProductInventory productInventory, ModelMap model,
                                      HttpServletRequest httpServletRequest) {

        try {
            if (productInventoryRepository.existsByProduct_ProductId(productInventory.getProduct().getProductId())) {
                model.addAttribute("errorMessage", "Kho đã có sản phẩm này.");
                return "admin/productInventory";
            }

            Inventory inventory = inventoryRepository.findById(productInventory.getInventory().getInventoryId()).orElse(null);

            if (inventory != null) {
                if (inventory.getMaxCapacity() < productInventory.getQuantity()) {
                    model.addAttribute("errorMessage", "Kho không đủ chỗ chứa cho sản phẩm này.");
                    return "admin/productInventory";
                }

                List<ProductInventory> listProductInventory = productInventoryRepository
                        .findProductInventoryByInventory_InventoryId(productInventory.getInventory().getInventoryId());
                double totalQuantity = listProductInventory.stream()
                        .mapToDouble(ProductInventory::getQuantity)
                        .sum();

                if (inventory.getMaxCapacity() < (totalQuantity + productInventory.getQuantity())) {
                    model.addAttribute("errorMessage", "Kho không đủ chỗ chứa cho tổng sản phẩm.");
                    return "admin/productInventory";
                }
            }

            ProductInventory p = productInventoryRepository.save(productInventory);
            if (p != null) {
                model.addAttribute("message", "Cập nhật thành công.");
            } else {
                model.addAttribute("errorMessage", "Cập nhật thất bại.");
            }

            return "redirect:/admin/productInventory";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            return "admin/productInventory"; // Trang hiện tại để nhập lại
        }
    }

    @GetMapping("/editProductInventory/{id}")
    public String getProductInventory(@PathVariable("id") Integer id, Model model) {
        ProductInventory productInventory = productInventoryRepository.findById(id).orElse(null);
        model.addAttribute("productInventory", productInventory);
        return "admin/editProductInventory";
    }

    @PostMapping(value = "/updateProductInventory")
    public String updateProductInventory(@ModelAttribute("productInventory") ProductInventory productInventory, ModelMap model,
                                         HttpServletRequest httpServletRequest) {

        try {
            Inventory inventory = inventoryRepository.findById(productInventory.getInventory().getInventoryId()).orElse(null);

            if (inventory == null) {
                model.addAttribute("errorMessage", "Kho không đủ chỗ chứa cho sản phẩm này.");
                return "admin/editProductInventory";
            }

            if (inventory.getMaxCapacity() < productInventory.getQuantity()) {
                model.addAttribute("errorMessage", "Kho không đủ chỗ chứa cho sản phẩm này.");
                return "admin/editProductInventory";
            }

            List<ProductInventory> listProductInventory = productInventoryRepository
                    .findProductInventoryByInventory_InventoryId(productInventory.getInventory().getInventoryId());

            List<ProductInventory> productInventoryList = listProductInventory.stream().filter(item -> item.getProduct().getProductId() != productInventory.getProduct().getProductId()).collect(Collectors.toList());

            double totalQuantity = productInventoryList.stream()
                    .mapToDouble(ProductInventory::getQuantity)
                    .sum();

            if (inventory.getMaxCapacity() < (totalQuantity + productInventory.getQuantity())) {
                model.addAttribute("errorMessage", "Kho không đủ chỗ chứa cho tổng sản phẩm.");
                return "admin/editProductInventory";
            }

            ProductInventory p = productInventoryRepository.save(productInventory);
            if (p != null) {
                model.addAttribute("message", "Cập nhật thành công.");
            } else {
                model.addAttribute("errorMessage", "Cập nhật thất bại.");
            }

            return "redirect:/admin/productInventory";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            return "admin/editProductInventory";
        }
    }

    @GetMapping("/deleteProductInventory/{id}")
    public String delProductInventory(@PathVariable("id") Integer id, Model model) {
        productInventoryRepository.deleteById(id);
        model.addAttribute("message", "Delete successful!");

        return "redirect:/admin/productInventory";
    }

}
