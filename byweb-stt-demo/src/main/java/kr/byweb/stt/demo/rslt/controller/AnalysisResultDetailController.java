package kr.byweb.stt.demo.rslt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.rslt.service.AnalysisResultDetailService;

@Controller
public class AnalysisResultDetailController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	AnalysisResultDetailService analysisResultDetailService;
	
	/**
	 * 계약정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getContractInfo.do")
	public String getContractInfo(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rslt/analysisResultDetail");
		
		return "main";
	}
}
