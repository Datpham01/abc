package vn.fs.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.fs.util.RandomImageUtil;

@Controller
public class randomController {

    @GetMapping("/random-image")
    public String showRandomImage(Model model) {
        // Đường dẫn tới thư mục chứa ảnh
        String directoryPath = "/static/images/blog";

        // Lấy ảnh ngẫu nhiên
        String randomImage = RandomImageUtil.getRandomImageFromDirectory(directoryPath);

        // Gửi tên ảnh vào model để Thymeleaf xử lý
        model.addAttribute("randomImage", randomImage);

        return "imageView"; // Trả về tên view, ví dụ imageView.html
    }
}

