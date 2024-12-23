package vn.fs.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.fs.entities.Category;
import vn.fs.entities.User;
import vn.fs.repository.CategoryRepository;
import vn.fs.repository.ProductRepository;
import vn.fs.repository.UserRepository;

/**
 * @author DongTHD
 *
 */
@Controller
public class CommomController {

	@Autowired
	CategoryRepository categoryRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	ProductRepository productRepository;

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

	@ModelAttribute("categoryList")
	public List<Category> showCategory(Model model) {
		List<Category> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList", categoryList);

		return categoryList;
	}

}
