package vn.fs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import vn.fs.config.vnpayconfig.VNPAYService;
import vn.fs.entities.Order;
import vn.fs.entities.OrderDetail;
import vn.fs.entities.ProductInventory;
import vn.fs.entities.User;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.ProductInventoryRepository;
import vn.fs.repository.UserRepository;
import vn.fs.service.ShoppingCartService;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class PaymentVNPayController {

    @Autowired
    private VNPAYService vnPayService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    ShoppingCartService shoppingCartService;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductInventoryRepository productInventoryRepository;

    @Autowired
    OrderDetailRepository orderDetailRepository;

    @GetMapping({"/create-order"})
    public String home(){
        return "createOrder";
    }

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

//    // Chuyển hướng người dùng đến cổng thanh toán VNPAY
//    @PostMapping("/submitOrder")
//    public String submidOrder(@RequestParam("amount") int orderTotal,
//                              @RequestParam("orderInfo") String orderInfo,
//                              HttpServletRequest request){
//        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
//        String vnpayUrl = vnPayService.createOrder(request, orderTotal, orderInfo, baseUrl);
//        return "redirect:" + vnpayUrl;
//    }

    // Sau khi hoàn tất thanh toán, VNPAY sẽ chuyển hướng trình duyệt về URL này
    @GetMapping("/vnpay-payment-return")
    public String paymentCompleted(HttpServletRequest request, Model model){
        int paymentStatus =vnPayService.orderReturn(request);

        String orderInfo = request.getParameter("vnp_OrderInfo");
        String paymentTime = request.getParameter("vnp_PayDate");
        String transactionId = request.getParameter("vnp_TransactionNo");
        String totalPrice = request.getParameter("vnp_Amount");

        int amount = (Integer.parseInt(totalPrice)) / 100;
        Long orderId = Long.parseLong(orderInfo);
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order == null) {
            return "orderfail";
        }

        if (paymentStatus == 1) {
            order.setStatus(2);
            shoppingCartService.clear();
            orderRepository.save(order);
        } else {
            if(order.getStatus() == 0){
                List<OrderDetail> orderDetailList  = orderDetailRepository.findByOrderId(order.getOrderId());
                for(OrderDetail item : orderDetailList) {
                    ProductInventory productInventory = productInventoryRepository.findProductInventoryByProduct_ProductId(item.getProduct().getProductId());
                    productInventory.setQuantity(productInventory.getQuantity() - item.getQuantity());
                    productInventoryRepository.save(productInventory);
                }
                orderDetailRepository.deleteAllByOrder_OrderId(orderId);
                orderRepository.deleteById(orderId);
            }
        }

        model.addAttribute("orderId", orderInfo);
        model.addAttribute("totalPrice", amount);
        model.addAttribute("paymentTime", paymentTime);
        model.addAttribute("transactionId", transactionId);

        return paymentStatus == 1 ? "ordersuccess" : "orderfail";
    }
}
