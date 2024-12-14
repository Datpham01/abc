package vn.fs.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.fs.commom.CommomDataService;
import vn.fs.entities.Post;
import vn.fs.entities.User;
import vn.fs.repository.PostRepository;
import vn.fs.repository.UserRepository;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/posts")
public class PostDisplayController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    PostRepository postRepository;

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

    @GetMapping
    public String getPost() {
        return "admin/posts";
    }
}
