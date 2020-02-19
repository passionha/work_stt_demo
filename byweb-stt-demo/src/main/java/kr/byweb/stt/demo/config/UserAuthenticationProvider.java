package kr.byweb.stt.demo.config;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.AsyncContext;
import javax.servlet.DispatcherType;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpUpgradeHandler;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import kr.byweb.stt.demo.cm.model.MemberVo;
import kr.byweb.stt.demo.cm.service.MemberService;

@Component
public class UserAuthenticationProvider implements AuthenticationProvider{
	
	private static final Logger LOGGER = LogManager.getLogger(TmCommonController.class);
	
	//인증 로직 구현 서비스 객체
	@Autowired
	MemberService memberService;
	
	/**
	 * SPRING SECURITY가 인증 수행 시 호출 메소드
	 * @param authentication 사용자 입력값 보유
	 * @return 인증 성공 시  Authentication 구현 객체 반환, 실패 시 예외 발생
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		System.out.println("*******************************authenticate");
		MemberVo memVo = new MemberVo();
		Map pMap = new HashMap();
		
		String acnt_id = authentication.getName();					//로그인 페이지에서 전송한 username 파라미터
		String anct_pw = (String) authentication.getCredentials();  //로그인 페이지에서 전송한 password 파라미터
		
		System.out.println("***************** id pw ");
		System.out.println(acnt_id);
		System.out.println(anct_pw);
		
		pMap.put("acnt_id", acnt_id);
		pMap.put("anct_pw", anct_pw);
		
		try {
			//authenticate()에서 인증 성공 시 VO, 실패 시 null 반환
			memVo = memberService.authenticate(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}	
		
		//인증 실패 시 AuthenticationException(을 상속하는 BadCredentialsException) 발생
		if(memVo == null) {
			throw new BadCredentialsException("BadCredentialsException : Login Error");
		}
		memVo.setAcnt_pw(null);
		
		//사용자 권한정보 설정(DB연계 로직 필요)
		ArrayList<SimpleGrantedAuthority> authorities = new ArrayList<>();
		
		authorities.add(new SimpleGrantedAuthority("ROLE_"+memVo.getAuth_cd()));
		
		//UsernamePasswordAuthenticationToken : Authentication 구현 클래스 (principal, credential, authority list)
		return new UsernamePasswordAuthenticationToken(memVo, null, authorities);
	}
	
	//이 AuthenticationProvider가 지원하는 클래스인지 판단
	@SuppressWarnings("rawtypes")
	@Override
    public boolean supports(Class authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }


}
