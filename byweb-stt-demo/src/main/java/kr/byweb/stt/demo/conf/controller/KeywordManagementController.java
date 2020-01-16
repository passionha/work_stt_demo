package kr.byweb.stt.demo.conf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.byweb.stt.demo.cm.model.PrdlnMngVo;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.conf.model.AnlysStdVo;
import kr.byweb.stt.demo.conf.service.KeywordManagementService;

@Controller
public class KeywordManagementController {
	
	@Autowired
	KeywordManagementService kwdMngService;
	
	@Autowired
	TmCommonCodeService tmCmCdService;
	
	/**
	 * 분석기준 설정 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getAnlysStdList")
	public String getAnlysStdList(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String use_yn = request.getParameter("use_yn") == null ? "Y" : request.getParameter("use_yn");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd");
		model.addAttribute("prdln_cd", prdln_cd);
		String kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		model.addAttribute("kwd_spr", kwd_spr);
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("use_yn", use_yn);
		
		try {
			List<TmCmCdVo> tmCmCdVos = tmCmCdService.getKwdKndCd();
			List<PrdlnMngVo> prdlnMngVos = tmCmCdService.getPrdlnList(pMap);
			
			model.addAttribute("prdlnMngVos", prdlnMngVos);
			model.addAttribute("tmCmCdVos", tmCmCdVos);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "conf/keywordManagement";
	}
	
	/**
	 * 키워드 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getAnalysisStandardList")
	public String getAnalysisStandardList(HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		
		String req_dept_cd = request.getParameter("req_dept_cd") == null ? "" : request.getParameter("req_dept_cd"); 
		String use_yn = request.getParameter("use_yn") == null ? "" : request.getParameter("use_yn");
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("use_yn", use_yn);
		
		List<TmCmCdVo> tmCmCdVos;
		try {
			tmCmCdVos = tmCmCdService.getKwdKndCd();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		List<PrdlnMngVo> prdlnMngVos;
		try {
			prdlnMngVos = tmCmCdService.getPrdlnList(pMap);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
//		model.addAttribute("prdlnMngVos", prdlnMngVos);
//		model.addAttribute("tmCmCdVos", tmCmCdVos);
		
		req_dept_cd = request.getParameter("req_dept_cd") == null ? "" : request.getParameter("req_dept_cd"); 
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr"); 
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("prdln_cd", prdln_cd);
		pMap.put("kwd_spr", kwd_spr);
		
		List<AnlysStdVo> anlysStdVos;
		try {
			anlysStdVos = kwdMngService.getAnalysisStandardList(pMap);
			model.addAttribute("AnlysStdVo", anlysStdVos);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "conf/keywordManagement";
	}	
	
	/**
	 * 동의어 관리 팝업
	 * @param model
	 * @return
	 */
	@RequestMapping("/synPopup")
	public String synPopup(Model model) {
		return "conf/synonymPopup";
	}
	
}
