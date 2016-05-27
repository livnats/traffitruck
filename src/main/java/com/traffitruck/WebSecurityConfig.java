package com.traffitruck;

import java.io.IOException;

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
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
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
        			String url = Role.valueOf(auth.getAuthority()).getLandingUrl();
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
            .antMatchers("/newload", "/myLoads", "/deleteLoad", "/load_details/**").hasAuthority(Role.LOAD_OWNER.name())
            .antMatchers("/truckerMenu", "/findTrucksForLoad", "/addAvailability", "/myTrucks", "/newTruck", "/load_details_for_trucker/**", "/load_for_truck_by_radius").hasAuthority(Role.TRUCK_OWNER.name())
            .antMatchers("/loads", "/trucks", "/truckApproval", "/nonApprovedTrucks", "/approval/licenseimage/**",
            		"/truckApproval").hasAuthority(Role.ADMIN.name())
            .anyRequest().authenticated();
        http
            .formLogin()
                .loginPage("/login")
                .successHandler(handler)
                .permitAll()
                .and()
            .logout()
                .permitAll()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout")).logoutSuccessUrl("/login?logout");
        
        http.sessionManagement()
        .maximumSessions(9999)
        .expiredUrl("/login?logout")
        .maxSessionsPreventsLogin(false)
        .and()
        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
        .invalidSessionUrl("/login");
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
