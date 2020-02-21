package kr.byweb.stt.demo.cm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;
import javax.servlet.http.HttpSessionListener;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.byweb.stt.demo.cm.model.LoginForm;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;

@Controller
public class TmCommonController {
	private static final Logger LOGGER = LogManager.getLogger(TmCommonController.class);
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@RequestMapping("/cm/main.do")
	public String goMain(HttpSession session, HttpServletRequest request) {
		//AuthProvider에서 세팅한 값 로드
//		MemberVo memberVo = (MemberVo)SecurityContextHolder.getContext().getAuthentication().getDetails();
//		
//		session.setAttribute("user_id", memberVo.getAcnt_id());
//		session.setAttribute("user_pw", memberVo.getAcnt_pw());
//		LOGGER.debug("******************main memberVo : "+memberVo);
		try {
			List<TmCmCdVo> headerTitles = tmCommonCodeService.getTitleList();
			session.setAttribute("headerTitles", headerTitles);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		return "main";
	}
	
	@RequestMapping("/cm/selHeader.do")
	public String selHeader(HttpSession session, HttpServletRequest request) {
		String req_cd = request.getParameter("req_dept_cd") == null ? "" : request.getParameter("req_dept_cd");
		String req_dept_cd = "";
		switch(req_cd) {
		case "TM-01" :
			req_dept_cd = "1";
			break;
		case "TM-02" :
			req_dept_cd = "2";
			break;
		case "TM-03" :
			req_dept_cd = "3";
			break;
		}
		session.setAttribute("sel_req_cd", req_cd);
		session.setAttribute("req_dept_cd", req_dept_cd);
		try {
			List<TmCmCdVo> navTitles = tmCommonCodeService.getNavTitleList(req_cd);
			session.setAttribute("navTitles", navTitles);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		
		return "redirect:/cm/main.do";
	}
}
