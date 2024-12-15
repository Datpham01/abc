package vn.fs.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import vn.fs.entities.Category;
import vn.fs.entities.User;
import vn.fs.repository.CategoryRepository;
import vn.fs.repository.UserRepository;


@Controller
@RequestMapping("/admin")
public class CategoryController {

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    UserRepository userRepository;

    @Value("${upload.path}")
    private String pathUploadImage;

    @ModelAttribute(value = "user")
    public User user(Model model, Principal principal, User user) {

        if (principal != null) {
            model.addAttribute("user", new User());
            user = userRepository.findByEmail(principal.getName());
            model.addAttribute("user", user);
        }

        return user;
    }

    // show list category - table list
    @ModelAttribute("categories")
    public List<Category> showCategory(Model model) {
        List<Category> categories = categoryRepository.findAll();
        model.addAttribute("categories", categories);

        return categories;
    }

    @GetMapping(value = "/categories")
    public String categories(Model model, Principal principal) {
        Category category = new Category();
        model.addAttribute("category", category);

        return "admin/categories";
    }

    // add category
    @PostMapping(value = "/addCategory")
    public String addCategory(@Validated @ModelAttribute("category") Category category, ModelMap model, @RequestParam("file") MultipartFile file,
                              BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("error", "failure");
            return "admin/categories";
        }

        String fileName = "default.jpg";
        if (!file.isEmpty()) {
            try {
                File convFile = new File(pathUploadImage + "/" + file.getOriginalFilename());
                FileOutputStream fos = new FileOutputStream(convFile);
                fos.write(file.getBytes());
                fos.close();
            } catch (IOException e) {
                System.out.println(e);
            }

            fileName = file.getOriginalFilename();
        }

        category.setCategoryImage(fileName);
        categoryRepository.save(category);
        model.addAttribute("message", "successful!");

        return "redirect:/admin/categories";
    }

    // get Edit category
    @GetMapping(value = "/editCategory/{id}")
    public String editCategory(@PathVariable("id") Long id, ModelMap model) {
        Category category = categoryRepository.findById(id).orElse(null);

        model.addAttribute("category", category);

        return "admin/editCategory";
    }

	@PostMapping(value = "/updateCategory")
	public String updateCategory(@Validated @ModelAttribute("category") Category category, ModelMap model, @RequestParam("file") MultipartFile file,
							  BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			model.addAttribute("error", "failure");
			return "admin/categories";
		}

		String fileName = category.getCategoryImage();
		if (!file.isEmpty()) {
			if(!file.getOriginalFilename().equals(fileName)) {
				try {
					File convFile = new File(pathUploadImage + "/" + file.getOriginalFilename());
					FileOutputStream fos = new FileOutputStream(convFile);
					fos.write(file.getBytes());
					fos.close();
				} catch (IOException e) {
					System.out.println(e);
				}
				fileName = file.getOriginalFilename();
			}
		}

		category.setCategoryImage(fileName);
		categoryRepository.save(category);
		model.addAttribute("message", "successful!");

		return "redirect:/admin/categories";
	}

    // delete category
    @GetMapping("/delete/{id}")
    public String delCategory(@PathVariable("id") Long id, Model model) {
        categoryRepository.deleteById(id);

        model.addAttribute("message", "Delete successful!");

        return "redirect:/admin/categories";
    }
}
