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
import vn.fs.entities.Category;
import vn.fs.entities.Inventory;
import vn.fs.entities.Product;
import vn.fs.entities.User;
import vn.fs.repository.InventoryRepository;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.UserRepository;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class InventoryController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    InventoryRepository inventoryRepository;

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

    @ModelAttribute("inventories")
    public List<Inventory> showProduct(Model model) {
        List<Inventory> inventories = inventoryRepository.findAll();
        model.addAttribute("inventories", inventories);
        return inventories;
    }

    @GetMapping(value = "/inventories")
    public String inventories(Model model, Principal principal) {
        Inventory inventory = new Inventory();
        model.addAttribute("inventory", inventory);

        return "admin/inventories";
    }

    // add product
    @PostMapping(value = "/addInventory")
    public String addProduct(@ModelAttribute("inventory") Inventory inventory, ModelMap model,
                             HttpServletRequest httpServletRequest) throws Exception {

        if(inventory.getMaxCapacity() < 0) {
            throw new Exception("Sức chứa tối đa");
        }

        Inventory inventory1 = inventoryRepository.save(inventory);
        if (null != inventory1) {
            model.addAttribute("message", "Update success");
            model.addAttribute("inventory", inventory1);
        } else {
            model.addAttribute("message", "Update failure");
            model.addAttribute("inventory", inventory1);
        }
        return "redirect:/admin/inventories";
    }

    @GetMapping(value = "/editInventory/{id}")
    public String editInventory(@PathVariable("id") Integer id, ModelMap model) {
        Inventory inventory = inventoryRepository.findById(id).orElse(null);

        model.addAttribute("inventory", inventory);

        return "admin/editInventory";
    }

    // delete category
    @GetMapping("/delete-inventory/{id}")
    public String delInventory(@PathVariable("id") Integer id, Model model) {
        inventoryRepository.deleteById(id);

        model.addAttribute("message", "Delete successful!");

        return "redirect:/admin/inventories";
    }
}
