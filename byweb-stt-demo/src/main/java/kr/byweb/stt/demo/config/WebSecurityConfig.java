/*package kr.byweb.stt.demo.config;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@EnableGlobalAuthentication
//@RequiredArgsConstructor
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	
	private static final Logger LOGGER = LogManager.getLogger(TmCommonController.class);

	@Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	//커스텀 인증 구현 클래스
	@Autowired
	private AuthProvider authenticationProvider;
	
//	@Autowired
//    AuthFailureHandler authFailureHandler;
// 
//    @Autowired
//    AuthSuccessHandler authSuccessHandler;

	//권한 상관없이 허용할 리소스 위치 지정
	@Override
    public void configure(WebSecurity web) throws Exception{
        // static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
        web.ignoring().antMatchers("/css/**", "/js/**", "/images/**");
    }
	
	//SPRING SECURITY 설정 구현 메소드
	@Override
	protected void configure(HttpSecurity http) throws Exception{
		LOGGER.debug("**********************configure(2) : " + http);
		//인증 필요 경로 설정
		http.csrf().disable()
			.authorizeRequests()
			.antMatchers("/ec/**").hasAnyRole("BW", "EC")
			.antMatchers("/tm/**").hasAnyRole("BW", "TM")
			.antMatchers("/cm/**").hasAnyRole("BW", "TM", "EC")
//			.antMatchers("/", "/login", "/error**").permitAll()
//			.antMatchers("/**").access("ROLE_ADMIN")
//			.antMatchers("/css/**", "/js/**", "/images/**").permitAll()	//정적자원 인증없이 접근 허용
//	        .antMatchers("/ddd").hasRole("ADMIN") 						//"ROLE_ADMIN"권한이 있어야 해당 경로 접근 가능(내부적으로 접두어 "ROLE_"가 붙는다)
//	        .antMatchers("/auth/admin/**").hasRole("ADMIN") 		//"ROLE_ADMIN"권한이 있어야 해당 경로 접근 가능(내부적으로 접두어 "ROLE_"가 붙는다)
//	        .antMatchers("/**").hasAnyRole("ADMIN", "USER") 	//"ROLE_ADMIN, ROLE_USER" 중 하나라도 권한이 있어야 해당 경로 접근 가능(내부적으로 접두어 "ROLE_"가 붙는다)
	        .anyRequest().authenticated()					//나머지 요청에 대해서는 인증된 사용자만 접근 가능
			
//	        .and()
//			.csrf()
//			.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
	        ;
		//로그인 폼 설정
		http.formLogin()
			.loginPage("/login")	 					//로그인 UI 페이지 경로 설정(Controller에 GET요청으로 유입)
			.loginProcessingUrl("/authenticate")		//인증처리 경로 설정(로그인폼 action URL / Controller 대신 SpringSecurity가 인증 루틴 요청 처리)
			.failureUrl("/loginError")			//인증 실패 페이지 경로 설정 (default : /login?error)
			.defaultSuccessUrl("/cm/main.do")			//인증 성공 시 default 전환 페이지 URL 설정
//			.failureHandler(authFailureHandler)
//            .successHandler(authSuccessHandler)
			.usernameParameter("acnt_id")				//로그인 페이지의 username 파라미터 이름 지정
			.passwordParameter("acnt_pw")				//로그인 페이지의 password 파라미터 이름 지정
			.permitAll()								//로그인 페이지 접근 전체 허용
//			.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
			;
		
		//로그아웃 설정
		http.logout()
			.logoutUrl("/logout")			//로그아웃 경로 설정(default 로그아웃 URL : /logout)
			.logoutSuccessUrl("/login")		//로그아웃 후 이동 경로 설정
			.permitAll()					//로그아웃 경로 접근 전체 허용
			.invalidateHttpSession(true);	//브라우저를 종료하지 않을 때, 로그아웃을 행해서 자신이 로그인 했던 모든 정보를 삭제
	}
	
	//커스텀 인증 구현 객체를 AuthenticatoinManagerBuilder에 추가
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception{
//		auth.authenticationProvider(authenticationProvider);
	}
}
*/