package vn.fs.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fs.commom.CommomDataService;
import vn.fs.config.PaypalPaymentIntent;
import vn.fs.config.PaypalPaymentMethod;
import vn.fs.config.vnpayconfig.VNPAYService;
import vn.fs.entities.CartItem;
import vn.fs.entities.Order;
import vn.fs.entities.OrderDetail;
import vn.fs.entities.Product;
import vn.fs.entities.ProductInventory;
import vn.fs.entities.User;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.ProductInventoryRepository;
import vn.fs.service.PaypalService;
import vn.fs.service.ShoppingCartService;
import vn.fs.util.Utils;


@Controller
public class CartController extends CommomController {

    @Autowired
    HttpSession session;

    @Autowired
    CommomDataService commomDataService;

    @Autowired
    ShoppingCartService shoppingCartService;

    @Autowired
    private PaypalService paypalService;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    OrderDetailRepository orderDetailRepository;

    @Autowired
    ProductInventoryRepository productInventoryRepository;

    @Autowired
    VNPAYService vnpayService;

    public Order orderFinal = new Order();

    public static final String URL_PAYPAL_SUCCESS = "pay/success";
    public static final String URL_PAYPAL_CANCEL = "pay/cancel";
    private Logger log = LoggerFactory.getLogger(getClass());

//	@GetMapping(value = "/shoppingCart_checkout")
//	public String shoppingCart(Model model) {
//
//		Collection<CartItem> cartItems = shoppingCartService.getCartItems();
//		model.addAttribute("cartItems", cartItems);
//		model.addAttribute("total", shoppingCartService.getAmount());
//		double totalPrice = 0;
//		for (CartItem cartItem : cartItems) {
//			double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
//			totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);
//		}
//
//		model.addAttribute("totalPrice", totalPrice);
//		model.addAttribute("totalCartItems", shoppingCartService.getCount());
//
//		return "web/shoppingCart_checkout";
//	}

    // add cartItem
    @GetMapping(value = "/addToCart")
    public String add(@RequestParam("productId") Long productId, HttpServletRequest request, Model model) {

        Product product = productRepository.findById(productId).orElse(null);

        session = request.getSession();
        Collection<CartItem> cartItems = shoppingCartService.getCartItems();
        if (product != null) {
            CartItem item = new CartItem();
            BeanUtils.copyProperties(product, item);
            item.setQuantity(1);
            item.setProduct(product);
            item.setId(productId);
            shoppingCartService.add(item);
        }
        session.setAttribute("cartItems", cartItems);
        model.addAttribute("totalCartItems", shoppingCartService.getCount());

        return "redirect:/products";
    }

    // add cartItem
    @GetMapping(value = "/addToCartProductDetail")
    public String addToCartProductDetail(@RequestParam("id") Long id, HttpServletRequest request, Model model) {

        Product product = productRepository.findById(id).orElse(null);

        session = request.getSession();
        Collection<CartItem> cartItems = shoppingCartService.getCartItems();
        if (product != null) {
            CartItem item = new CartItem();
            BeanUtils.copyProperties(product, item);
            item.setQuantity(1);
            item.setProduct(product);
            item.setId(id);
            shoppingCartService.add(item);
        }
        session.setAttribute("cartItems", cartItems);
        model.addAttribute("totalCartItems", shoppingCartService.getCount());

        return "redirect:/productDetail?id=" + id;
    }


    @GetMapping(value = "/remove/{id}")
    public String remove(@PathVariable("id") Long id, HttpServletRequest request, Model model) {
        Collection<CartItem> cartItems = shoppingCartService.getCartItems();
        session = request.getSession();

        // Tìm và xóa CartItem từ id
        Optional<CartItem> optionalCartItem = cartItems.stream()
                .filter(item -> item.getId().equals(id))
                .findFirst();
        if (optionalCartItem.isPresent()) {
            CartItem itemToRemove = optionalCartItem.get();

            // Xóa CartItem khỏi giỏ hàng
            shoppingCartService.remove(itemToRemove);

            // Cập nhật danh sách cartItems trong session
            cartItems.remove(itemToRemove);
        }

        model.addAttribute("totalCartItems", shoppingCartService.getCount());
        return "redirect:/checkout";
    }


    // show check out
    @GetMapping(value = "/checkout")
    public String checkOut(Model model, User user) {

        Order order = new Order();
        model.addAttribute("order", order);

        Collection<CartItem> cartItems = shoppingCartService.getCartItems();
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("total", shoppingCartService.getAmount());
        model.addAttribute("NoOfItems", shoppingCartService.getCount());
        double totalPrice = 0;
        for (CartItem cartItem : cartItems) {
            double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
            totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);
        }

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("totalCartItems", shoppingCartService.getCount());
        commomDataService.commonData(model, user);

        return "web/shoppingCart_checkout";
    }

    //check quantity before buy
    private List<CartItem> checkQuantity(Collection<CartItem> cartItems) {
        List<CartItem> outOfStockItems = new ArrayList<>();

        for (CartItem cartItem : cartItems) {
            ProductInventory productInventory = productInventoryRepository.findProductInventoryByProduct_ProductId(cartItem.getProduct().getProductId());
            if (productInventory == null || cartItem.getProduct().getQuantity() > productInventory.getQuantity()) {
                outOfStockItems.add(cartItem);
            }
        }

        return outOfStockItems;
    }

    // submit checkout
    @PostMapping(value = "/checkout")
    @Transactional
    public String checkedOut(Model model, Order order, HttpServletRequest request, User user, RedirectAttributes redirectAttributes)
            throws MessagingException {

        String checkOut = request.getParameter("checkOut");

        Collection<CartItem> cartItems = shoppingCartService.getCartItems();

        List<CartItem> outOfStockItems = checkQuantity(cartItems);
        if (!outOfStockItems.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Một số sản phẩm không còn đủ hàng trong kho.");
            model.addAttribute("order", order);
            return "redirect:/checkout";
        }

        double totalPrice = 0;
        for (CartItem cartItem : cartItems) {
            double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
            totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);
        }

        BeanUtils.copyProperties(order, orderFinal);
        if (StringUtils.equals(checkOut, "paypal")) {

            String cancelUrl = Utils.getBaseURL(request) + "/" + URL_PAYPAL_CANCEL;
            String successUrl = Utils.getBaseURL(request) + "/" + URL_PAYPAL_SUCCESS;
            try {
                totalPrice = totalPrice / 25456;
                Payment payment = paypalService.createPayment(totalPrice, "USD", PaypalPaymentMethod.paypal,
                        PaypalPaymentIntent.sale, "payment description", cancelUrl, successUrl);
                for (Links links : payment.getLinks()) {
                    if (links.getRel().equals("approval_url")) {
                        return "redirect:" + links.getHref();
                    }
                }
            } catch (PayPalRESTException e) {
                log.error(e.getMessage());
            }
        } else if (StringUtils.equals(checkOut, "vnpay")) {
            Date date = new Date();
            order.setStatus(0);
            order.setOrderDate(date);
            order.setUser(user);
            order.setAmount(totalPrice);
            order = orderRepository.save(order);

            for (CartItem cartItem : cartItems) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(cartItem.getQuantity());
                orderDetail.setOrder(order);
                orderDetail.setProduct(cartItem.getProduct());
                double unitPrice = cartItem.getProduct().getPrice();
                orderDetail.setPrice(unitPrice);
                ProductInventory productInventory = productInventoryRepository.findProductInventoryByProduct_ProductId(cartItem.getProduct().getProductId());
                productInventory.setQuantity(productInventory.getQuantity() - cartItem.getQuantity());
                productInventoryRepository.save(productInventory);
                orderDetailRepository.save(orderDetail);
            }

            String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
            int amount = (int) totalPrice;
            String vnpayUrl = vnpayService.createOrder(request, amount, order.getOrderId().toString(), baseUrl);
            return "redirect:" + vnpayUrl;
        }

        session = request.getSession();
        Date date = new Date();
        order.setStatus(0);
        order.setOrderDate(date);
        order.setUser(user);
        order.getOrderId();
        order.setAmount(totalPrice);

        orderRepository.save(order);

        for (CartItem cartItem : cartItems) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setQuantity(cartItem.getQuantity());
            orderDetail.setOrder(order);
            orderDetail.setProduct(cartItem.getProduct());
            double unitPrice = cartItem.getProduct().getPrice();
            orderDetail.setPrice(unitPrice);
            ProductInventory productInventory = productInventoryRepository.findProductInventoryByProduct_ProductId(cartItem.getProduct().getProductId());
            productInventory.setQuantity(productInventory.getQuantity() - cartItem.getQuantity());
            productInventoryRepository.save(productInventory);
            orderDetailRepository.save(orderDetail);
        }

        // sendMail
        commomDataService.sendSimpleEmail(user.getEmail(), "Harvert ViNa - Xác Nhận Đơn hàng", "xác nhận", cartItems,
                totalPrice, order);

        shoppingCartService.clear();
        session.removeAttribute("cartItems");
        model.addAttribute("orderId", order.getOrderId());

        return "redirect:/checkout_success";
    }

    // paypal
    @GetMapping(URL_PAYPAL_SUCCESS)
    public String successPay(@RequestParam("" + "" + "") String paymentId, @RequestParam("PayerID") String payerId,
                             HttpServletRequest request, User user, Model model) throws MessagingException {
        Collection<CartItem> cartItems = shoppingCartService.getCartItems();
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("total", shoppingCartService.getAmount());

        double totalPrice = 0;
        for (CartItem cartItem : cartItems) {
            double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
            totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("totalCartItems", shoppingCartService.getCount());

        try {
            Payment payment = paypalService.executePayment(paymentId, payerId);
            if (payment.getState().equals("approved")) {

                session = request.getSession();
                Date date = new Date();
                orderFinal.setOrderDate(date);
                orderFinal.setStatus(0);
                orderFinal.getOrderId();
                orderFinal.setUser(user);
                orderFinal.setAmount(totalPrice);
                orderRepository.save(orderFinal);

                for (CartItem cartItem : cartItems) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setQuantity(cartItem.getQuantity());
                    orderDetail.setOrder(orderFinal);
                    orderDetail.setProduct(cartItem.getProduct());
                    double unitPrice = cartItem.getProduct().getPrice();
                    orderDetail.setPrice(unitPrice);
                    orderDetailRepository.save(orderDetail);
                }

                // sendMail
                commomDataService.sendSimpleEmail(user.getEmail(), "Harvert ViNa-Xác Nhận Đơn hàng", "xác nhận", cartItems,
                        totalPrice, orderFinal);

                shoppingCartService.clear();
                session.removeAttribute("cartItems");
                model.addAttribute("orderId", orderFinal.getOrderId());
                orderFinal = new Order();
                return "redirect:/checkout_paypal_success";
            }
        } catch (PayPalRESTException e) {
            log.error(e.getMessage());
        }
        return "redirect:/";
    }

    // done checkout ship cod
    @GetMapping(value = "/checkout_success")
    public String checkoutSuccess(Model model, User user) {
        commomDataService.commonData(model, user);

        return "web/checkout_success";

    }

    // done checkout paypal
    @GetMapping(value = "/checkout_paypal_success")
    public String paypalSuccess(Model model, User user) {
        commomDataService.commonData(model, user);

        return "web/checkout_paypal_success";

    }


    @PutMapping(value = "/updateQuantity", params = {"productId", "quantity"})
    public String updateQ(ModelMap model, HttpSession session, @RequestParam("productId") Long id,
                          @RequestParam("quantity") int qty) {
        shoppingCartService.updateQuantity(id, qty);
        ;

        return "web/shoppingCart_checkout";
    }


}