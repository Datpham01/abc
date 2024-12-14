package vn.fs.controller.admin;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.fs.entities.Post;
import vn.fs.repository.PostRepository;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/posts")
public class PostController {
    private final PostRepository postRepository;

    public PostController(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    @PostMapping
    public ResponseEntity<Post> savePost(@RequestBody Post post) {
        post.setCreatedAt(LocalDateTime.now());
        Post savedPost = postRepository.save(post);
        return ResponseEntity.ok(savedPost);
    }
}
