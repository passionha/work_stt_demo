package kr.byweb.stt.demo.cm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.byweb.stt.demo.cm.model.LoginForm;

@Controller
public class MemberController {
	
	@GetMapping("/login")
	public String login(@ModelAttribute("loginForm") LoginForm loginForm, Model model) {
		return "common/loginForm";
	}
	
	@GetMapping("/login?error")
	public String loginError() {
		return "common/loginFail";
	}
}
