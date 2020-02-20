package kr.byweb.stt.demo.cm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.model.LoginForm;

@Controller
public class MemberController {
	
//	@GetMapping("/login")
//	public String login(HttpServletRequest request, Model model) {
//		return "common/loginForm";
//	}
	
	@GetMapping("/loginError")
	public String loginError() {
		
		return "common/loginForm";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, Model model) {
		return "common/loginForm";
	}
	
	
	@RequestMapping("/admin")
	public void admin() {}
	
	
	// 2.1 로그인 컨트롤러 연결할 jsp 경로 설정하고 jsp 페이지 만들자
	@RequestMapping("/login")
	public void login() {}
	
	@RequestMapping("/")
	public String hello() {
		return "common/hello";
	}
}
