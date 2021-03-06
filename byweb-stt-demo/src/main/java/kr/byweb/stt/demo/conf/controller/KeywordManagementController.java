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

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.conf.model.AnlysStdVo;
import kr.byweb.stt.demo.conf.service.KeywordManagementService;

@Controller
public class KeywordManagementController {
	private static final Logger LOGGER = LogManager.getLogger(KeywordManagementController.class);
	
	@Autowired
	KeywordManagementService keywordManagementService;
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	/**
	 * 분석기준 설정
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getAnlysStdList.do")
	public String getAnlysStdList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "conf/keywordManagement");
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
			LOGGER.debug("Exception : " + e.toString());
		}
		
		return "main";
	}
	
	/**
	 * 키워드 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getAnalysisStandardList.do")
	public String getAnalysisStandardList(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		System.out.println("********************getAnalysisStandardList");
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = "";
		String kwd_spr = "";
		String kwd_nms = request.getParameter("srch_kwd_nms") == null ? "" : request.getParameter("srch_kwd_nms");	//동의어 저장 시 입력키워드 유지
		
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
			LOGGER.debug("Exception : " + e.toString());
		}
		
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("kwd_spr", kwd_spr);
		redirectAttributes.addFlashAttribute("kwd_nms", kwd_nms);
		redirectAttributes.addFlashAttribute("kwdList", kwdList);
		return "redirect:/tm/getAnlysStdList.do";
	}	
	
	/**
	 * 키워드 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/insertAnalysisStandard.do")
	public String insertAnalysisStandard(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("ins_prdln_cd") == null ? "" : request.getParameter("ins_prdln_cd"); 
		String kwd_spr = request.getParameter("ins_kwd_spr") == null ? "" : request.getParameter("ins_kwd_spr"); 
		String kwd_nms = request.getParameter("kwd_nms") == null ? "" : request.getParameter("kwd_nms");
		String ins_kwd_nms = request.getParameter("ins_kwd_nms") == null ? "" : request.getParameter("ins_kwd_nms");
		
		ArrayList kwdNms = new ArrayList();
		String[] commaSaps = ins_kwd_nms.split(",");
		for(int k=0; k<commaSaps.length; k++) {
			if(commaSaps[k].toString().contains("/")) {
				pMap.put("scrng_spr", "Y");
			}else {
				pMap.put("scrng_spr", "N");
			}
			pMap.put("kwd_nm", commaSaps[k].toString());
//			추후 session 통해 emp_no 추출 필요
			pMap.put("emp_no", "A219090");
			pMap.put("req_dept_cd", req_dept_cd);
			pMap.put("prdln_cd", prdln_cd);
			pMap.put("kwd_spr", kwd_spr);
			
			try {
				keywordManagementService.insertAnalysisStandard(pMap);
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
		}
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("kwd_spr", kwd_spr);
		redirectAttributes.addFlashAttribute("kwd_nms", kwd_nms);
		return "redirect:/tm/getAnalysisStandardList.do";
	}
	
	/**
	 * 키워드 등록 전 중복검사
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getKeywordDuplicationList.do")
	@ResponseBody
	public ArrayList getKeywordDuplicationList(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		ArrayList kwdNms = new ArrayList();
		ArrayList dupKwdNms = new ArrayList();
		
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_nms = request.getParameter("kwd_nms") == null ? "" : request.getParameter("kwd_nms");
		
		String[] commaSaps = kwd_nms.split(",");
		for(int k=0; k<commaSaps.length; k++) {
			if(commaSaps[k].toString().contains("/")) {
				pMap.put("scrng_spr", "Y");
			}else {
				pMap.put("scrng_spr", "N");
			}
			pMap.put("kwd_nm", commaSaps[k].toString());
			pMap.put("req_dept_cd", req_dept_cd);
			pMap.put("prdln_cd", prdln_cd);
			String dupKwdMap = "";
			try {
				dupKwdMap = keywordManagementService.getKeywordDuplicationList(pMap);
				if(dupKwdMap != null) {
					dupKwdNms.add(dupKwdMap);
				}
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
		}
		return dupKwdNms;
	}
	
	/**
	 * 동의어 관리 팝업
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getSynonymKeywordList.do")
	public String getSynonymKeywordList(HttpServletRequest request, HttpSession session, Model model) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		String scrng_spr = request.getParameter("scrng_spr") == null ? "" : request.getParameter("scrng_spr");
		String kwd_nm = request.getParameter("kwd_nm") == null ? "" : request.getParameter("kwd_nm");
		String syn_nm = request.getParameter("syn_nm") == null ? "" : request.getParameter("syn_nm");
		String scr = request.getParameter("scr") == null ? "" : request.getParameter("scr");
		List<AnlysStdVo> synList = null;
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("prdln_cd", prdln_cd);
		pMap.put("kwd_spr", kwd_spr);
		pMap.put("kwd_nm", kwd_nm);
		pMap.put("syn_nm", syn_nm);
		try {
			synList = keywordManagementService.getSynonymKeywordList(pMap);
			model.addAttribute("prdln_cd", prdln_cd);
			model.addAttribute("kwd_spr", kwd_spr);
			model.addAttribute("kwd_nm", kwd_nm);
			model.addAttribute("syn_nm", syn_nm);
			model.addAttribute("scr", scr);
			model.addAttribute("synList", synList);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		return "conf/synonymPopup";
	}
	
	/**
	 * 동의어 갱신
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/updateSynonym.do")
	@ResponseBody
	public Object updateSynonym(@RequestParam(value="chkKwds[]") List<String> chkKwds, @RequestParam(value="unchkKwds[]") List<String> unchkKwds, HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		String syn_nm = request.getParameter("syn_nm") == null ? "" : request.getParameter("syn_nm");
		String kwd_nm = request.getParameter("kwd_nm") == null ? "" : request.getParameter("kwd_nm");
		String org_syn_nm = request.getParameter("org_syn_nm") == null ? "" : request.getParameter("org_syn_nm");
		//체크된 키워드 및 기준키워드 동의어 설정
		chkKwds.add(kwd_nm);
        for(String kwdNm : chkKwds) {
        	if(kwdNm.equals("")) continue;	//분석기준 설정에서 동의어 삭제 시 kwd_nm ""으로 전송
            pMap.put("chk_sel", "1");
            pMap.put("req_dept_cd", req_dept_cd);
            pMap.put("prdln_cd", prdln_cd);
            pMap.put("kwd_spr", kwd_spr);
            pMap.put("org_syn_nm", org_syn_nm);
            pMap.put("syn_nm", syn_nm);
            pMap.put("kwd_nm", kwdNm);
            pMap.put("emp_no", "A219090");	//EMP_NO 로그인 개발 후 수정 필요
            if(kwdNm.toString().contains("/")) {
            	pMap.put("scrng_spr", "Y");
            }else {
            	pMap.put("scrng_spr", "N");
            }
            
            try {
				keywordManagementService.updateSynonym(pMap);
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
        }
        pMap = new HashMap();
        //체크해제 키워드 동의어 초기화
        for(String kwdNm : unchkKwds) {
        	pMap.put("chk_sel", "0");
        	pMap.put("req_dept_cd", req_dept_cd);
            pMap.put("prdln_cd", prdln_cd);
            pMap.put("kwd_spr", kwd_spr);
            pMap.put("org_syn_nm", org_syn_nm);
            pMap.put("syn_nm", syn_nm);
            pMap.put("kwd_nm", kwdNm);
            pMap.put("emp_no", "A219090");	//EMP_NO 로그인 개발 후 수정 필요
            if(kwdNm.toString().contains("/")) {
            	pMap.put("scrng_spr", "Y");
            }else {
            	pMap.put("scrng_spr", "N");
            }
            
            try {
				keywordManagementService.updateSynonym(pMap);
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
        }
        
        //리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        //성공결과 처리
        retVal.put("code", "OK");
        retVal.put("message", "등록에 성공 하였습니다.");
        
        return retVal;
	}
	
	/**
	 * 동의어명 중복검사
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getSynonymDup.do")
	@ResponseBody
	public Integer getSynonymDup(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		String syn_nm = request.getParameter("syn_nm") == null ? "" : request.getParameter("syn_nm");
		String org_syn_nm = request.getParameter("org_syn_nm") == null ? "" : request.getParameter("org_syn_nm");
		//체크된 키워드 및 기준키워드 동의어 설정
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("prdln_cd", prdln_cd);
		pMap.put("kwd_spr", kwd_spr);
		pMap.put("syn_nm", syn_nm);
		pMap.put("org_syn_nm", org_syn_nm);
		
		int dup_cnt = 0;
		try {
			dup_cnt = keywordManagementService.getSynonymDup(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		System.out.println("**************************dup_cnt : "+dup_cnt);
		return dup_cnt;
	}
	
	/**
	 * 동의어 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/updateDelSynonym.do")
	@ResponseBody
	public Object updateDelSynonym(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd"); 
		String kwd_spr = request.getParameter("kwd_spr") == null ? "" : request.getParameter("kwd_spr");
		String syn_nm = request.getParameter("syn_nm") == null ? "" : request.getParameter("syn_nm");
		//체크된 키워드 및 기준키워드 동의어 설정
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("prdln_cd", prdln_cd);
		pMap.put("kwd_spr", kwd_spr);
		pMap.put("syn_nm", syn_nm);
		pMap.put("emp_no", "A219090");	//EMP_NO 로그인 개발 후 수정 필요
		
		try {
			keywordManagementService.updateDelSynonym(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		
		//리턴값
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		//성공결과 처리
		retVal.put("code", "OK");
		retVal.put("message", "등록에 성공 하였습니다.");
		
		return retVal;
	}
	
	/**
	 * 키워드목록 수정사항 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/updateAnalysisStandard.do")
	public String updateAnalysisStandard(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("mod_prdln_cd") == null ? "" : request.getParameter("mod_prdln_cd"); 
		String kwd_spr = request.getParameter("mod_kwd_spr") == null ? "" : request.getParameter("mod_kwd_spr");
		String kwd_nms = request.getParameter("mod_kwd_nms") == null ? "" : request.getParameter("mod_kwd_nms");
		String[] mod_kwd_nm = request.getParameterValues("mod_kwd_nm");
		String[] mod_rng = request.getParameterValues("mod_rng");
		String[] mod_use_yn = request.getParameterValues("mod_use_yn");
		String[] mod_scr = request.getParameterValues("mod_scr");
		String[] org_scrng_spr = request.getParameterValues("org_scrng_spr");
		String[] org_kwd_nm = request.getParameterValues("org_kwd_nm");
		for(int i=0; i<mod_kwd_nm.length; i++) {
			pMap.put("req_dept_cd", req_dept_cd);
			pMap.put("prdln_cd", prdln_cd);
			pMap.put("kwd_spr", kwd_spr);
			pMap.put("kwd_nm", mod_kwd_nm[i]);
			pMap.put("rng", mod_rng[i]);
			pMap.put("use_yn", mod_use_yn[i]);
			pMap.put("scr", mod_scr[i]);
			pMap.put("org_scrng_spr", org_scrng_spr[i]);
			pMap.put("org_kwd_nm", org_kwd_nm[i]);
			pMap.put("emp_no", "A219090");		//로그인 후 수정 필요
			if(mod_kwd_nm[i].toString().contains("/")) {
				pMap.put("scrng_spr", "Y");
			}else {
				pMap.put("scrng_spr", "N");
			}
			try {
				keywordManagementService.updateAnalysisStandard(pMap);
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
		}
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("kwd_spr", kwd_spr);
		redirectAttributes.addFlashAttribute("kwd_nms", kwd_nms);
		return "redirect:/tm/getAnalysisStandardList.do";
	}
	
	/**
	 * 키워드목록 수정사항 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/deleteAnalysisStandard.do")
	public String deleteAnalysisStandard(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String prdln_cd = request.getParameter("mod_prdln_cd") == null ? "" : request.getParameter("mod_prdln_cd"); 
		String kwd_spr = request.getParameter("mod_kwd_spr") == null ? "" : request.getParameter("mod_kwd_spr");
		String kwd_nms = request.getParameter("mod_kwd_nms") == null ? "" : request.getParameter("mod_kwd_nms");
		String[] org_scrng_spr = request.getParameterValues("org_scrng_spr");
		String[] org_kwd_nm = request.getParameterValues("org_kwd_nm");
		for(int i=0; i<org_kwd_nm.length; i++) {
			pMap.put("req_dept_cd", req_dept_cd);
			pMap.put("prdln_cd", prdln_cd);
			pMap.put("kwd_spr", kwd_spr);
			pMap.put("scrng_spr", org_scrng_spr[i]);
			pMap.put("kwd_nm", org_kwd_nm[i]);
			try {
				keywordManagementService.deleteAnalysisStandard(pMap);
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
		}
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("kwd_spr", kwd_spr);
		redirectAttributes.addFlashAttribute("kwd_nms", kwd_nms);
		return "redirect:/tm/getAnalysisStandardList.do";
	}
}
