package kr.byweb.stt.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
	
	//권한 상관없이 허용할 리소스 위치 지정
	@Override
    public void configure(WebSecurity web) throws Exception{
        // static 디렉토리의 하위 파일 목록은 인증여부 무시
        web.ignoring().antMatchers("/css/**", "/js/**", "/images/**");
    }
	
	//SPRING SECURITY 설정 구현 메소드
	@Override
	protected void configure(HttpSecurity http) throws Exception{
		//인증 필요 경로 설정
		http.authorizeRequests()
//				.antMatchers("/cm/**").hasAuthority("BW")
				.antMatchers("/ec/**").hasAnyAuthority("BW", "EC")
				.antMatchers("/tm/**").hasAnyAuthority("BW", "TM")
				.antMatchers("/cm/**").hasAnyAuthority("BW", "TM", "EC")
				.antMatchers("/", "/registerForm", "/register").permitAll()
				.anyRequest().authenticated()					//나머지 요청에 대해서는 인증된 사용자만 접근 가능
	//			.antMatchers("/css/**", "/js/**", "/images/**").permitAll()	//정적자원 인증없이 접근 허용
		        .and().csrf().disable()
	//			.csrf()
	//			.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
		//로그인 폼 설정
		    .formLogin()
			    .usernameParameter("acnt_id")				//로그인 페이지의 username 파라미터 이름 지정
			    .passwordParameter("acnt_pw")				//로그인 페이지의 password 파라미터 이름 지정
		    	.loginPage("/login").permitAll()			//로그인 UI 페이지 경로 설정(Controller에 GET요청으로 유입)
		    	.defaultSuccessUrl("/cm/main.do")				//인증 성공 시 default 전환 페이지 URL 설정
	//			.loginProcessingUrl("/authenticate")		//인증처리 경로 설정(로그인폼 action URL / Controller 대신 SpringSecurity가 인증 루틴 요청 처리)
	//			.failureUrl("/loginError")					//인증 실패 페이지 경로 설정 (default : /login?error)
	//			.failureHandler(authFailureHandler)
	//          .successHandler(authSuccessHandler)
				.and()
		
		//로그아웃 설정
			.logout()
//				.logoutUrl("/logout")			//로그아웃 경로 설정(default 로그아웃 URL : /logout)
				.logoutSuccessUrl("/login?logout")			//로그아웃 후 이동 경로 설정
				.permitAll()					//로그아웃 경로 접근 전체 허용
				.invalidateHttpSession(true);	//브라우저를 종료하지 않을 때, 로그아웃을 행해서 자신이 로그인 했던 모든 정보를 삭제
	}
}
