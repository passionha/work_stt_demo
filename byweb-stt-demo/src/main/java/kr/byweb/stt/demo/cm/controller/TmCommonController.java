package kr.byweb.stt.demo.cm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;

@Controller
public class TmCommonController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@RequestMapping("/")
	public String goMain(Model model) {
		try {
			List<TmCmCdVo> headerTitles = tmCommonCodeService.getTitleList();
			model.addAttribute("headerTitles", headerTitles);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "main";
	}
	
	@RequestMapping("/selHeader")
	public String selHeader(HttpSession session, HttpServletRequest request, Model model) {
		String reqCd = request.getParameter("req_dept_cd") == null ? "" : request.getParameter("req_dept_cd");
		String req_dept_cd = "";
		switch(reqCd) {
		case "050100" :
			req_dept_cd = "1";
			break;
		case "050200" :
			req_dept_cd = "2";
			break;
		case "050300" :
			req_dept_cd = "3";
			break;
		}
		session.setAttribute("req_dept_cd", req_dept_cd);
		return "redirect:/";
	}
}
