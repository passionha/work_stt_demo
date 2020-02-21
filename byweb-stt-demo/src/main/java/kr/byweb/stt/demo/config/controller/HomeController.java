package kr.byweb.stt.demo.config.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.byweb.stt.demo.config.mapper.AccountMapper;
import kr.byweb.stt.demo.config.model.Account;
import kr.byweb.stt.demo.config.model.UserDetailsImpl;
//import kr.byweb.stt.demo.config.service.HomeService;

@Controller
public class HomeController {
	@Autowired 
	AccountMapper accountMapper;
	
//	@Autowired
//	PasswordEncoder passwordEncoder;
	
//	@Autowired
//	HomeService homeService;
	
	@RequestMapping(value = "/")
	public String index() {
		System.out.println("**************@RequestMapping index()");
		return "index";
	}
	
	@RequestMapping("/admin")
	public String admin() {
		System.out.println("**************@RequestMapping admin()");
		return "admin";
	}
	
	@RequestMapping("/user")
	public void user() {
		System.out.println("**************@RequestMapping user()");
	}
	
	@RequestMapping("/login")
	public void login(Account account) {
		System.out.println("**************@RequestMapping login()");
		// SecurityContextHolder에서 Context를 받아 인증 설정
		if(account != null) {
			System.out.println("SecurityContextHolder.getContext() : "+SecurityContextHolder.getContext());
//			UserDetailsImpl userDetails = new UserDetailsImpl(account);
//			Authentication authentication = 
//					new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
//			SecurityContextHolder.getContext().setAuthentication(authentication);
//			System.out.println("**************HomeController_authentication: "+authentication);
//			System.out.println("**************SecurityContextHolder 인증 설정 완료");
		}
	}
	
	@RequestMapping("/loginProc")
	public String loginProc(Account account) {
		System.out.println("**************@RequestMapping loginProc()");
		System.out.println("**************@RequestMapping loginProc() account : "+ account);
		
		return "/login";
	}
	
	@RequestMapping("/registerForm")
	public void registerForm() {}
	/*
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String register(Account account){
		// 회원정보 데이터베이스에 저장
//		account.setAcnt_pw(passwordEncoder.encode(account.getAcnt_pw()));
		account.setAcnt_pw(account.getAcnt_pw());
		System.out.println("**************homeCntl account.getAcnt_pw() : "+account.getAcnt_pw());
//		System.out.println("**************homeCntl encode.getAcnt_pw() : "+passwordEncoder.encode(account.getAcnt_pw()));
		try {
			accountMapper.saveAccount(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// SecurityContextHolder에서 Context를 받아 인증 설정
		UserDetailsImpl userDetails = new UserDetailsImpl(account);
		Authentication authentication = 
				new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);
        System.out.println("**************HomeController_authentication: "+authentication);
        System.out.println("**************SecurityContextHolder 인증 설정 완료");
		return "redirect:/";
	}*/
	/*
	@RequestMapping("/getPrivateMessage")
	@PreAuthorize("(#account.userid == principal.Username) or hasRole('ROLE_BW')")
	public String authstring(Account account, Model model) {
		model.addAttribute("msg", "당신은 관리자거나 요청 파라미터랑 아이디가 같습니까?");
		return "authorizedMessage";
	}

	@RequestMapping("/getUserMessage")
	@PreAuthorize("hasRole('ROLE_USER')")
	public String userMesasge(Account account, Model model){
		model.addAttribute("msg", "당신은 한낱 유저입니다. ㅠ");
		return "authorizedMessage";
	}

	@RequestMapping("/403")
	public void accessdeniedPage(){}

	@RequestMapping("/userinformation")
	public void userinformation(Model model){
		try {
			Account account = accountMapper.findMe();
			model.addAttribute("user", account);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/message")
	@ResponseBody
	public String  getMessage(){
		return homeService.getMessage();
	}
	*/
}
