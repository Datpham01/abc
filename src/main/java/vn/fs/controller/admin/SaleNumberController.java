package vn.fs.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.fs.dto.ProductStatistics;
import vn.fs.entities.Order;
import vn.fs.entities.User;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.UserRepository;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class SaleNumberController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @ModelAttribute(value = "user")
    public User user(Model model, Principal principal, User user) {

        if (principal != null) {
            model.addAttribute("user", new User());
            user = userRepository.findByEmail(principal.getName());
            model.addAttribute("user", user);
        }

        return user;
    }

    @GetMapping(value = "/sale-number")
    public String orders(Model model, Principal principal) {
        List<String> labels = new ArrayList<String>();
        // Data for the chart
        List<Long> data = new ArrayList<>();

        // Add data to the model
         List<ProductStatistics> productStatistics = orderDetailRepository.getProductMostPurchased();
         if(productStatistics.size() > 0) {
             for (ProductStatistics productStatistics1 : productStatistics) {
                 labels.add(productStatistics1.getProductName());
                 data.add(productStatistics1.getQuantity());
             }
         }
        model.addAttribute("labels", labels);
        model.addAttribute("data", data);

        return "admin/salesNumber";
    }
}
