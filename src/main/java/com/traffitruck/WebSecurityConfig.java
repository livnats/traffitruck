package com.traffitruck;

import javax.servlet.MultipartConfigElement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.embedded.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

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
        
        http
            .authorizeRequests()
                .antMatchers("/css/**", "/js/**", "/images/**", "/registerUser","/registrationConfirmation").permitAll()
                .anyRequest().authenticated();
        http
            .formLogin()
                .loginPage("/login")
                .defaultSuccessUrl("/loads")
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
