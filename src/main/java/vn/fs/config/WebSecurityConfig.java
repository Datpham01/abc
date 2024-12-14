package vn.fs.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import vn.fs.service.UserDetailService;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailService userDetailService;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider auth = new DaoAuthenticationProvider();
        auth.setUserDetailsService(userDetailService);
        auth.setPasswordEncoder(passwordEncoder());
        return auth;
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailService).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // Tắt CSRF (nếu cần, tùy vào yêu cầu ứng dụng)
        http.csrf().disable();

        // Cấu hình phân quyền truy cập cho các trang
        http.authorizeRequests()
                .antMatchers("/css/**", "/js/**", "/images/**").permitAll()
                .antMatchers("/admin/users").hasRole("ADMIN") // Chỉ cho phép ADMIN truy cập
                .antMatchers("/admin/**").hasAnyRole("ADMIN", "EMPLOYEE") // Cho phép ADMIN và EMPLOYEE truy cập
                .antMatchers("/checkout").hasRole("USER")
                .antMatchers("/posts/**").permitAll()
                .antMatchers("/**").permitAll() // Cho phép tất cả truy cập không hạn chế
                .anyRequest().authenticated() // Bắt buộc xác thực cho mọi yêu cầu khác
                .and()

                // Cấu hình đăng nhập OAuth2 (Google, Facebook, v.v.)
                .oauth2Login()
                .loginPage("/login") // Trang đăng nhập
                .userInfoEndpoint()
                .userService(customOAuth2UserService)
                .and()
                .successHandler(new CustomSuccessHandler())
                .failureUrl("/login?error=true")
                .and()

                // Cấu hình đăng nhập thông qua form (login form-based authentication)
                .formLogin()
                .loginProcessingUrl("/doLogin") // Xử lý đăng nhập
                .loginPage("/login") // Trang đăng nhập
                .defaultSuccessUrl("/?login_success") // Đăng nhập thành công
                .successHandler(new SuccessHandler()) // Xử lý thành công tùy chỉnh
                .failureUrl("/login?error=true") // Đăng nhập thất bại
                .permitAll() // Cho phép tất cả truy cập trang login
                .and()

                // Cấu hình đăng xuất
                .logout()
                .invalidateHttpSession(true) // Hủy session khi đăng xuất
                .clearAuthentication(true) // Xóa xác thực khi đăng xuất
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout")) // Định nghĩa đường dẫn đăng xuất
                .logoutSuccessUrl("/?logout_success") // Sau khi đăng xuất thành công
                .permitAll() // Cho phép tất cả truy cập đăng xuất
                .and()

                // Cấu hình Remember Me (giữ người dùng đăng nhập lâu hơn)
                .rememberMe()
                .rememberMeParameter("remember") // Tham số "remember-me"
                .and()

                // Cấu hình xử lý lỗi truy cập (khi người dùng không có quyền truy cập)
                .exceptionHandling()
                .accessDeniedPage("/web/notFound"); // Trang lỗi khi truy cập bị từ chối
    }
}