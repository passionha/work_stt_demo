package kr.byweb.stt.demo.cm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.byweb.stt.demo.cm.model.Account;
import kr.byweb.stt.demo.cm.service.AccountService;

@Controller
public class AccountController {

	@Autowired
	AccountService accountService;
	
	@RequestMapping(value = "/")
	public String home() {
		System.out.println("**************@RequestMapping home()");
		return "index";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void login() {
		System.out.println("**************@RequestMapping login()");
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	public void logout() {
		System.out.println("**************@RequestMapping logout()");
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
	
	@RequestMapping("/registerForm")
	public void registerForm() {
		System.out.println("**************@RequestMapping registerForm()");
	}
	
	/**
	 * 회원가입
	 * @param 사용자 입력 회원정보
	 */
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String register(Account account){
		// 회원정보 데이터베이스에 저장
//		account.setAcnt_pw(passwordEncoder.encode(account.getAcnt_pw()));
		account.setAcnt_pw(account.getAcnt_pw());
		System.out.println("**************homeCntl account.getAcnt_pw() : "+account.getAcnt_pw());
//		System.out.println("**************homeCntl encode.getAcnt_pw() : "+passwordEncoder.encode(account.getAcnt_pw()));
		try {
			accountService.register(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/index";
	}
	
	
}
