package kr.byweb.stt.demo.cm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.byweb.stt.demo.cm.model.LoginForm;

@Controller
public class MemberController {
	
	@GetMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		System.out.println(request.getParameter("auth"));
		return "common/loginForm";
	}
	
	@GetMapping("/loginError")
	public String loginError() {
		return "common/loginFail";
	}
}
