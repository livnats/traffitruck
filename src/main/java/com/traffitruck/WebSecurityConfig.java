package com.traffitruck;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.embedded.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.traffitruck.domain.Role;
import com.traffitruck.service.UserDetailsServiceImpl;

@Configuration
@EnableWebMvcSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Bean
	MultipartConfigElement multipartConfigElement() {
		MultipartConfigFactory factory = new MultipartConfigFactory();
		factory.setMaxFileSize("5MB");
		factory.setMaxRequestSize("10MB");
		return factory.createMultipartConfig();
	}
	
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	// handle content encoding
    	CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        http.addFilterBefore(filter,CsrfFilter.class);
        
        SimpleUrlAuthenticationSuccessHandler handler = new SimpleUrlAuthenticationSuccessHandler() {
        	@Override
        	protected void handle(HttpServletRequest request,
        			HttpServletResponse response, Authentication authentication)
        					throws IOException, ServletException {
        		authentication.getAuthorities().forEach( auth -> {
        			String url;
        			switch(Role.valueOf(auth.getAuthority())) {
        			case ADMIN:
        				url = "/adminMenu";
        				break;
        			case LOAD_OWNER:
        				url = "/loadMenu";
        				break;
        			case TRUCK_OWNER:
        				url = "/truckMenu";
        				break;
        			default:
        				url = "/login";
        				break;
        			}
        			try {
						getRedirectStrategy().sendRedirect(request, response, url);
					} catch (Exception e) {
						throw new RuntimeException(e);
					}
        		});
        	}
        };
        
        http
            .authorizeRequests()
                .antMatchers("/css/**", "/js/**", "/images/**", "/registerUser","/registrationConfirmation").permitAll()
                .anyRequest().authenticated();
        http
            .formLogin()
                .loginPage("/login")
                .successHandler(handler)
                .permitAll()
                .and()
            .logout()
                .permitAll();
    }

    @Configuration
    protected static class AuthenticationConfiguration extends
            GlobalAuthenticationConfigurerAdapter {
    	
    	@Autowired
    	private UserDetailsServiceImpl userDetails;
    	
        @Override
        public void init(AuthenticationManagerBuilder auth) throws Exception {
            //auth.inMemoryAuthentication().withUser("david").password("1234").roles("USER");
            //auth.inMemoryAuthentication().withUser("avi").password("1234").roles("USER");
        	auth.authenticationProvider(userDetails);
        }
        
    }

}
