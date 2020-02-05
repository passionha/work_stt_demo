package kr.byweb.stt.demo.mng.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.mng.service.ProductLineManagementService;

@Controller
public class ProductLineManagementController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	ProductLineManagementService productLineManagementService;
	
	/**
	 * 상품군 목록 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getProductList.do")
	public String getProductList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "mng/productLineManagement");
		
		return "main";
	}
}
