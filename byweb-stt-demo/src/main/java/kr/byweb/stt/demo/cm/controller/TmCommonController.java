package kr.byweb.stt.demo.cm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TmCommonController {

	@RequestMapping("/")
	public String goMain(Model model) {
		return "main";
	}
	
	@RequestMapping("/selHeader")
	public String selHeader(HttpSession session, HttpServletRequest request, Model model) {
		String req_dept_cd = request.getParameter("req_dept_cd") == null ? "" : request.getParameter("req_dept_cd");
		session.setAttribute("req_dept_cd", req_dept_cd);
		return "main";
	}
}
