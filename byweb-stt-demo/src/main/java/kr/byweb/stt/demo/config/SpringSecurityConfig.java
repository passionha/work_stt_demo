package kr.byweb.stt.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableGlobalAuthentication
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter{
	
	private CustomAuthProvider customAuthProvider;
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		System.out.println("configure web");
		web.ignoring().antMatchers("/css/**", "/js/**", "/images/**");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		System.out.println("configure auth");
		auth.authenticationProvider(customAuthProvider);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("configure http");
		http.authorizeRequests()
			.antMatchers("/admin/**").hasRole("BW")
			.antMatchers("/user/**").hasAnyRole("TM", "BW")
			.antMatchers("/**").permitAll();
			// .anyRequest().authenticated()
		
		http.formLogin()
			.usernameParameter("acnt_id")
			.passwordParameter("acnt_pw")
			.loginPage("/login").permitAll()
			;
	}
	
	
}
