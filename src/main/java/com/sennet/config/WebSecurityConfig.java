package com.sennet.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.sennet.common.SennetProperty;
import com.sennet.security.CustomFailureHandler;
import com.sennet.security.CustomLogoutSuccessHandler;
import com.sennet.security.CustomSuccessHandler;
import com.sennet.security.PermissionDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	

	@Autowired
	SennetProperty prop;	

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	UserDetailsService userDetailsService;
	
	@Autowired
	CustomFailureHandler customFailureHandler;
	
	@Autowired
	CustomSuccessHandler customSuccessHandler;
	
	@Autowired
	PermissionDeniedHandler permissionDeniedHandler;
	
	@Autowired
	CustomLogoutSuccessHandler customLogoutSuccessHandler;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.csrf().disable();
		http.authorizeRequests()
		       .antMatchers("/admin/**").hasRole("ADMIN")
		       .antMatchers("/expired/**").hasAnyRole("ADMIN","USER","JIJUM","EXPIRED")
		       .antMatchers("/rest/**").hasAnyRole("ADMIN","USER","JIJUM","EXPIRED");
		//http.authorizeRequests().antMatchers("/**").permitAll();
		
		http.formLogin().loginPage("/login").successHandler(customSuccessHandler).failureHandler(customFailureHandler).permitAll();
		http.logout().logoutUrl("/logout").logoutSuccessHandler(customLogoutSuccessHandler);
		http.exceptionHandling().accessDeniedHandler(permissionDeniedHandler);
		
		//http.logout().logoutUrl("/logout").deleteCookies("JSESSIONID").logoutSuccessUrl("/login").invalidateHttpSession(true);
		
		if (prop.getSessiontimeoutblock().equals("true")) {
			log.info("Concurrentsession option is true. value is {}", prop.getConcurrentsession());
		http.sessionManagement().maximumSessions(prop.getConcurrentsession()).expiredUrl("/error/sessionexpired");	
		}		
		
		//TODO Client의 쿠키 정보가 우효간 Session이 아닐 때 처리되는 로직, 고민 중
		//http.sessionManagement().invalidSessionUrl("/error/sessioninvalid").;		
		
	}
}
