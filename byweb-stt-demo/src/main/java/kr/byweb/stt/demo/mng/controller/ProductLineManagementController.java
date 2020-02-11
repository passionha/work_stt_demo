package kr.byweb.stt.demo.mng.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.mng.model.PrdlnMngVo;
import kr.byweb.stt.demo.mng.service.ProductLineManagementService;
import kr.byweb.stt.demo.rpt.model.ContractVo;

@Controller
public class ProductLineManagementController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	ProductLineManagementService productLineManagementService;
	
	/**
	 * 상품군 관리 목록 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getProductList.do")
	public String getProductList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "mng/productLineManagement");
		Map pMap = new HashMap();
		List<PrdlnMngVo> prdlnList = new ArrayList<PrdlnMngVo>();
		List<TmCmCdVo> clsCdList = new ArrayList<TmCmCdVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String s_PRDLN = "";
		String org_s_PRDLN = "";
		String ins_s_PRDLN = "";
		
		//저장 후 redirect 시 입력했던 파라미터 추출
		Map<String, ?> inputFlashMap =  RequestContextUtils.getInputFlashMap(request);
		if(inputFlashMap != null) {
			ins_s_PRDLN = (String) inputFlashMap.get("ins_s_PRDLN");
			org_s_PRDLN = (String) inputFlashMap.get("org_s_PRDLN");
		}else {
			s_PRDLN = request.getParameter("s_PRDLN") == null ? "" : request.getParameter("s_PRDLN");
		}
		s_PRDLN = org_s_PRDLN.equals("") ? s_PRDLN : org_s_PRDLN;
		System.out.println(s_PRDLN);
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("s_PRDLN", s_PRDLN);
		try {
			prdlnList = productLineManagementService.getProductList(pMap);
			clsCdList = tmCommonCodeService.getClsCdList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("s_PRDLN", ins_s_PRDLN.equals("") ? s_PRDLN : ins_s_PRDLN);
		model.addAttribute("org_s_PRDLN", s_PRDLN);
		model.addAttribute("prdlnList", prdlnList);
		model.addAttribute("clsCdList", clsCdList);
		return "main";
	}
	
	/**
	 * 상품군 관리 목록 저장
	 * @param model
	 * @return
	 */
	@RequestMapping("/saveProductList.do")
	public String saveProductList(PrdlnMngVo pList, HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		String s_PRDLN = request.getParameter("s_PRDLN") == null ? "" : request.getParameter("s_PRDLN");
		String org_s_PRDLN = request.getParameter("org_s_PRDLN") == null ? "" : request.getParameter("org_s_PRDLN");
		Map pMap = new HashMap();
		Iterator<PrdlnMngVo> iter = pList.getPrdlnList().iterator();
		while(iter.hasNext()) {
			PrdlnMngVo nextIter = iter.next();
			if(nextIter.getPrdln_cd() != null) {
				pMap.clear();
				pMap.put("cls_cd", nextIter.getCls_cd());
				pMap.put("req_dept_cd", nextIter.getReq_dept_cd());
				pMap.put("prdln_cd", nextIter.getPrdln_cd());
				pMap.put("prdln_nm", nextIter.getPrdln_nm());
				pMap.put("use_yn", nextIter.getUse_yn());
				pMap.put("emp_no", "A219090"); //로그인 구현 후 수정 필요*****************************
				try {
					productLineManagementService.saveProductList(pMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		//redirect경로로 전달할 파라미터 저장
		redirectAttributes.addFlashAttribute("ins_s_PRDLN", s_PRDLN);
		redirectAttributes.addFlashAttribute("org_s_PRDLN", org_s_PRDLN);
		return "redirect:/getProductList.do";
	}
	
	/**
	 * 상품군 관리 엑셀 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/getProduct_exl.do")
	public String getProduct_exl(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<PrdlnMngVo> prdlnList = new ArrayList<PrdlnMngVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String s_PRDLN = request.getParameter("org_s_PRDLN") == null ? "" : request.getParameter("org_s_PRDLN");
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("s_PRDLN", s_PRDLN);
		
		try {
			prdlnList = productLineManagementService.getProductList(pMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("prdlnList", prdlnList);
		model.addAttribute("filename", "상품군관리.xls");
		return "mng/productLineManagement_exl";
	}
}
