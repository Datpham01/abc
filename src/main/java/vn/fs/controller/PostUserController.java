package vn.fs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import vn.fs.entities.Post;
import vn.fs.entities.User;
import vn.fs.repository.PostRepository;
import vn.fs.repository.UserRepository;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class PostUserController {
    @Autowired
    PostRepository postRepository;

    @Autowired
    UserRepository userRepository;

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

    @GetMapping("/getpost")
    public String getAllPosts(Model model, User user) {
        List<Post> posts = postRepository.findAll();
        model.addAttribute("posts", posts);
        return "web/postList";
    }

    @GetMapping("/posts-detail/{id}")
    public String getPostById(@PathVariable Long id, Model model,  User user) {
        Post post = postRepository.findById(id).orElse(null);
        model.addAttribute("post", post);
        return "web/detail";
    }
}
