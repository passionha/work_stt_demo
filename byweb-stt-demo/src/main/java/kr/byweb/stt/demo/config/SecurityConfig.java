/*package kr.byweb.stt.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled=true)
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	UserDetailsService userDetailsService;
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		System.out.println("****************SecurityConfig_configure_auth : "+auth);
//		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
		auth.userDetailsService(userDetailsService).passwordEncoder(NoOpPasswordEncoder.getInstance());;
	}

	// 1.2. http 설정
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("****************SecurityConfig_configure_http : "+http);
		http.authorizeRequests()
				.antMatchers("/admin/**").hasRole("BW")
				.antMatchers("/user/**").hasAnyRole("TM", "BW")
				.antMatchers("/**").permitAll();
				// .anyRequest().authenticated()
		
		http.formLogin()
			.usernameParameter("acnt_id")
			.passwordParameter("acnt_pw")
			.loginPage("/login").permitAll()
//			.loginProcessingUrl("/authenticate")
//			.defaultSuccessUrl("/admin")
//			.successHandler(successHandler)
//			.loginProcessingUrl("/loginProc")
			;
	}
}
*/
