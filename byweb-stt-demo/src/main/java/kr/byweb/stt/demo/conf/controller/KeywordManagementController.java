package kr.byweb.stt.demo.conf.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.conf.model.AnlysStdVo;
import kr.byweb.stt.demo.conf.service.KeywordManagementService;

@Controller
public class KeywordManagementController {
	
	@Autowired
	KeywordManagementService keywordManagementService;
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	/**
	 * 분석기준 설정
	 * @param model
	 * @return
	 */
	@RequestMapping("/getAnlysStdList")
	public String getAnlysStdList(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String use_yn = request.getParameter("use_yn") == null ? "" : request.getParameter("use_yn");
		String prdln_cd = "";
		String kwd_spr = "";
		String kwd_nms = "";	
		
		//키워드 목록 조회, 등록 시 입력 조건 유지
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if(inputFlashMap != null) {
			kwd_spr = (String) inputFlashMap.get("kwd_spr");
			prdln_cd = (String) inputFlashMap.get("prdln_cd");
			kwd_nms = (String) inputFlashMap.get("kwd_nms");
		}else {
			prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd");
			kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		}
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("use_yn", use_yn);
		
		try {
			List<TmCmCdVo> tmCmCdVos = tmCommonCodeService.getKwdKndCd();
			List<TmCmCdVo> prdlnMngVos = tmCommonCodeService.getPrdlnList(pMap);
			
			model.addAttribute("prdln_cd", prdln_cd);
			model.addAttribute("kwd_spr", kwd_spr);
			model.addAttribute("kwd_nms", kwd_nms);
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
	public String getAnalysisStandardList(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = "";
		String kwd_spr = "";
		String kwd_nms = "";
		
		//키워드 등록 시 입력 조건 유지
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if(inputFlashMap != null) {
			kwd_spr = (String) inputFlashMap.get("kwd_spr");
			prdln_cd = (String) inputFlashMap.get("prdln_cd");
			kwd_nms = (String) inputFlashMap.get("kwd_nms");
		}else {
			prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd");
			kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		}
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("prdln_cd", prdln_cd);
		pMap.put("kwd_spr", kwd_spr);
		List<AnlysStdVo> kwdList = null;
		try {
			kwdList = keywordManagementService.getAnalysisStandardList(pMap);
			model.addAttribute("AnlysStdVo", kwdList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("kwd_spr", kwd_spr);
		redirectAttributes.addFlashAttribute("kwd_nms", kwd_nms);
		redirectAttributes.addFlashAttribute("kwdList", kwdList);
		return "redirect:/getAnlysStdList";
	}	
	
	/**
	 * 키워드 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertAnalysisStandard")
	public String insertAnalysisStandard(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("ins_prdln_cd") == null ? "" : request.getParameter("ins_prdln_cd"); 
		String kwd_spr = request.getParameter("ins_kwd_spr") == null ? "" : request.getParameter("ins_kwd_spr"); 
		String kwd_nms = request.getParameter("kwd_nms") == null ? "" : request.getParameter("kwd_nms");
		
		ArrayList kwdNms = new ArrayList();
		String[] commaSaps = kwd_nms.split(",");
		for(int i=0; i<commaSaps.length; i++) {
			if(!commaSaps[i].replaceAll("\\p{Z}", "").equals("")) {
				kwdNms.add(commaSaps[i].replaceAll("\\p{Z}", ""));
			}
		}
		for(int k=0; k<kwdNms.size(); k++) {
			if(kwdNms.get(k).toString().contains("/")) {
				pMap.put("scrng_spr", "Y");
			}else {
				pMap.put("scrng_spr", "N");
			}
			pMap.put("kwd_nm", kwdNms.get(k).toString());
//			추후 session 통해 emp_no 추출 필요
			pMap.put("emp_no", "A219090");
			pMap.put("req_dept_cd", req_dept_cd);
			pMap.put("prdln_cd", prdln_cd);
			pMap.put("kwd_spr", kwd_spr);
			
			try {
				keywordManagementService.insertAnalysisStandard(pMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("kwd_spr", kwd_spr);
		redirectAttributes.addFlashAttribute("kwd_nms", kwd_nms);
		return "redirect:/getAnalysisStandardList";
	}
	
	/**
	 * 키워드 등록 전 중복검사
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getKeywordDuplicationList")
	@ResponseBody
	public ArrayList getKeywordDuplicationList(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		ArrayList kwdNms = new ArrayList();
		ArrayList dupKwdNms = new ArrayList();
		
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_nms = request.getParameter("kwd_nms") == null ? "" : request.getParameter("kwd_nms");
		
		String[] commaSaps = kwd_nms.split(",");
		for(int i=0; i<commaSaps.length; i++) {
			if(!commaSaps[i].replaceAll("\\p{Z}", "").equals("")) {
				kwdNms.add(commaSaps[i].replaceAll("\\p{Z}", ""));
			}
		}
		for(int k=0; k<kwdNms.size(); k++) {
			if(kwdNms.get(k).toString().contains("/")) {
				pMap.put("scrng_spr", "Y");
			}else {
				pMap.put("scrng_spr", "N");
			}
			pMap.put("kwd_nm", kwdNms.get(k).toString());
			pMap.put("req_dept_cd", req_dept_cd);
			pMap.put("prdln_cd", prdln_cd);
			String dupKwdMap = "";
			try {
				dupKwdMap = keywordManagementService.getKeywordDuplicationList(pMap);
				if(dupKwdMap != null) {
					dupKwdNms.add(dupKwdMap);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dupKwdNms;
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
