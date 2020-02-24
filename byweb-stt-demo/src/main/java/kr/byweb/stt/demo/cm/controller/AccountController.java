package kr.byweb.stt.demo.cm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.byweb.stt.demo.cm.model.Account;
import kr.byweb.stt.demo.cm.service.AccountService;

@Controller
public class AccountController {

	@Autowired
	AccountService accountService;
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/cm/main.do";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		return "common/login";
	}
	
//	@RequestMapping(value="/logout", method=RequestMethod.POST)
//	public void logout() {
//	}
	
	@RequestMapping("/registerForm")
	public String registerForm() {
		System.out.println("**************@RequestMapping registerForm()");
		return "common/registerForm";
	}
	
	/**
	 * 회원가입
	 * @param 사용자 입력 회원정보
	 */
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String register(Account account, Model model){
		model.addAttribute("contentPage", "common/registerResult");
		// 회원정보 데이터베이스에 저장
		try {
			accountService.register(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("emp_nm", account.getEmp_nm());
		return "main";
	}
	
	
}
