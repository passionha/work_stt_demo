/*package kr.byweb.stt.demo.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import kr.byweb.stt.demo.cm.mapper.MemberMapper;
import kr.byweb.stt.demo.cm.model.MemberVo;
import kr.byweb.stt.demo.cm.service.MemberService;
*/
/**
 * 인증 provider
 * 로그인 시 사용자 입력 아이디, 비밀번호 확인하고 해당 권한을 부여하는 클래스
 */
/*
@Component()
public class AuthProvider implements AuthenticationProvider{
	
	private static final Logger LOGGER = LogManager.getLogger(TmCommonController.class);
	
	@Autowired
	MemberService memberService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		MemberVo memVo = new MemberVo();
		Map pMap = new HashMap();
		
		// Form에서 전달 된, name 태그 설정이 username-parameter, password-parameter로 되있는 값을 읽어온다
		String acnt_id = authentication.getName();
		String acnt_pw = (String) authentication.getCredentials();
		
		pMap.put("acnt_id", acnt_id);
		pMap.put("acnt_pw", acnt_pw);
		
		
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
		
		ArrayList<SimpleGrantedAuthority> roles = new ArrayList<>();
		
		roles.add(new SimpleGrantedAuthority("ROLE_"+memVo.getAuth_cd()));
		LOGGER.debug("**********************memVo(4) : " + memVo);
		
		UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(acnt_id, acnt_pw, roles);
		result.setDetails(memVo);
		
		LOGGER.debug("**********************result.getCredentials()(4) : " + result.getCredentials());
		LOGGER.debug("**********************result(4) : " + result);
		
//		return new UsernamePasswordAuthenticationToken(memVo, null, roles);
		return result;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		LOGGER.debug("**********************UserAuthToken(3) : " + UsernamePasswordAuthenticationToken.class);
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
*/