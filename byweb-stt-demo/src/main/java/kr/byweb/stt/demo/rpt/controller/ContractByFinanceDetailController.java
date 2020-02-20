package kr.byweb.stt.demo.rpt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.rpt.model.ContractVo;
import kr.byweb.stt.demo.rpt.service.ContractByFinanceDetailService;

@Controller
public class ContractByFinanceDetailController {
	private static final Logger LOGGER = LogManager.getLogger(ContractByFinanceDetailController.class);
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	ContractByFinanceDetailService contractByFinanceDetailService;
	
	/**
	 * 녹취파일 계약정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getContractDetailList.do")
	public String getContractDetailList(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		model.addAttribute("contentPage", "rpt/contractByFinanceDetail");
		Map conPMap = new HashMap();
		Map finPMap = new HashMap();
		Map prdPMap = new HashMap();
		List<TmCmCdVo> finList = new ArrayList<TmCmCdVo>();
		List<TmCmCdVo> prdList = new ArrayList<TmCmCdVo>();
		List<ContractVo> conList = new ArrayList<ContractVo>();
		String cls_cd = request.getParameter("cls_cd") == null ? "" : request.getParameter("cls_cd");	//회사별 제출현황에서 선택한 회사의 CLS_CD(1자리)
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("fin_cd") == null ? "" : request.getParameter("fin_cd");
		String req_dt = request.getParameter("req_dt") == null ? "" : request.getParameter("req_dt");
		String scrts_no = request.getParameter("scrts_no") == null ? "" : request.getParameter("scrts_no");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd");
		String ctt_sdate = request.getParameter("ctt_sdate") == null ? "" : request.getParameter("ctt_sdate");
		String ctt_edate = request.getParameter("ctt_edate") == null ? "" : request.getParameter("ctt_edate");
		
		//녹취파일변환요청 후 녹취파일 계약정보 재조회를 위한 조회조건 유지
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if(inputFlashMap != null) {
			cls_cd = (String) inputFlashMap.get("cls_cd");
			req_dept_cd = (String) inputFlashMap.get("req_dept_cd");
			fin_cd = (String) inputFlashMap.get("fin_cd");
			req_dt = (String) inputFlashMap.get("req_dt");
			prdln_cd = (String) inputFlashMap.get("prdln_cd");
			scrts_no = (String) inputFlashMap.get("scrts_no");
			ctt_sdate = (String) inputFlashMap.get("ctt_sdate");
			ctt_edate = (String) inputFlashMap.get("ctt_edate");
			cls_cd = (String) inputFlashMap.get("cls_cd");
		}
		conPMap.put("cls_cd", cls_cd);
		conPMap.put("req_dept_cd", req_dept_cd);
		conPMap.put("fin_cd", fin_cd);
		conPMap.put("req_dt", req_dt);
		conPMap.put("scrts_no", scrts_no);
		conPMap.put("prdln_cd", prdln_cd);
		conPMap.put("ctt_sdate", ctt_sdate);
		conPMap.put("ctt_edate", ctt_edate);
		
		String det_cls_cd = "";
		if(request.getParameter("det_class_cd") != null) {	//녹취파일 계약정보에서 조회한 회사명(조회조건)의 CLASS_CD(6자리)
			switch(request.getParameter("det_class_cd").substring(0, 4)) {
			case "0501" :
				det_cls_cd = "1";
				break;
			case "0502" :
				det_cls_cd = "2";
				break;
			case "0307" :
				//금융감독원관리자
				det_cls_cd = "1";
				break;
			}
			conPMap.put("cls_cd", det_cls_cd);
		}
		
		String class_cd = "";
		switch(req_dept_cd) {
		case "1" :
			class_cd = "050100";
			break;
		case "2" :
			class_cd = "050200";
			break;
		case "3" :
			class_cd = "ALL";
			break;
		}
		finPMap.put("cls_cd", class_cd);
		finPMap.put("sdate", "");
		
		prdPMap.put("req_dept_cd", req_dept_cd);
		prdPMap.put("use_yn", "Y");
		
		try {
			finList = tmCommonCodeService.getReqDeptList(finPMap);
			prdList = tmCommonCodeService.getPrdlnList(prdPMap);
			conList = contractByFinanceDetailService.getContractDetailList(conPMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		
		String org_cls_cd = "";
		if(cls_cd.equals("")) {
			org_cls_cd = det_cls_cd;
		}else{
			org_cls_cd = cls_cd;
		}
		model.addAttribute("org_cls_cd", org_cls_cd);
		model.addAttribute("finList", finList);
		model.addAttribute("prdList", prdList);
		model.addAttribute("conList", conList);
		model.addAttribute("req_dt", req_dt);
		model.addAttribute("fin_cd", fin_cd);
		if(!prdln_cd.equals("")) {model.addAttribute("prdln_cd", prdln_cd);}
		if(!scrts_no.equals("")) {model.addAttribute("scrts_no", scrts_no);}
		if(!ctt_sdate.equals("")) {model.addAttribute("ctt_sdate", ctt_sdate);}
		if(!ctt_edate.equals("")) {model.addAttribute("ctt_edate", ctt_edate);}
		return "main";
	}
	
	/**
	 * 녹취파일 계약정보 엑셀 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getContractDetail_exl.do")
	public String getContract_exl(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) {
		Map conPMap = new HashMap();
		List<ContractVo> conList = new ArrayList<ContractVo>();
		String cls_cd = request.getParameter("org_cls_cd") == null ? "" : request.getParameter("org_cls_cd");	//회사별 제출현황에서 조회한 회사의 CLS_CD
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("org_fin_cd") == null ? "" : request.getParameter("org_fin_cd");
		String req_dt = request.getParameter("org_req_dt") == null ? "" : request.getParameter("org_req_dt");
		String scrts_no = request.getParameter("org_scrts_no") == null ? "" : request.getParameter("org_scrts_no");
		String prdln_cd = request.getParameter("org_prdln_cd") == null ? "" : request.getParameter("org_prdln_cd");
		String ctt_sdate = request.getParameter("org_ctt_sdate") == null ? "" : request.getParameter("org_ctt_sdate");
		String ctt_edate = request.getParameter("org_ctt_edate") == null ? "" : request.getParameter("org_ctt_edate");
		String fin_nm = request.getParameter("org_fin_nm") == null ? "" : request.getParameter("org_fin_nm")+"_";
		
		conPMap.put("cls_cd", cls_cd);
		conPMap.put("req_dept_cd", req_dept_cd);
		conPMap.put("fin_cd", fin_cd);
		conPMap.put("req_dt", req_dt);
		conPMap.put("scrts_no", scrts_no);
		conPMap.put("prdln_cd", prdln_cd);
		conPMap.put("ctt_sdate", ctt_sdate);
		conPMap.put("ctt_edate", ctt_edate);
		
		try {
			conList = contractByFinanceDetailService.getContractDetailList(conPMap);
			String fileNm = fin_nm + (req_dt.equals("") ? "" : req_dt+"_") + "계약정보.xls";
			model.addAttribute("conList", conList);
			model.addAttribute("filename", fileNm);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		return "rpt/contractByFinanceDetail_exl";
	}
	
	/**
	 * 계약정보의 녹취파일들 STT분석진행 위해 요청여부 갱신
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/setAnalysisAll.do")
	public String setAnalysisAll(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		List<ContractVo> conList = new ArrayList<ContractVo>();
		String cls_cd = request.getParameter("org_cls_cd") == null ? "" : request.getParameter("org_cls_cd");
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("org_fin_cd") == null ? "" : request.getParameter("org_fin_cd");
		String req_dt = request.getParameter("org_req_dt") == null ? "" : request.getParameter("org_req_dt");
		//입력한 조회조건
		String scrts_no = request.getParameter("org_scrts_no") == null ? "" : request.getParameter("org_scrts_no");
		String prdln_cd = request.getParameter("org_prdln_cd") == null ? "" : request.getParameter("org_prdln_cd");
		String ctt_sdate = request.getParameter("org_ctt_sdate") == null ? "" : request.getParameter("org_ctt_sdate");
		String ctt_edate = request.getParameter("org_ctt_edate") == null ? "" : request.getParameter("org_ctt_edate");
		
		pMap.put("cls_cd", cls_cd);
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("fin_cd", fin_cd);
		pMap.put("req_dt", req_dt);
		
		//녹취파일변환요청 후 녹취파일 계약정보 재조회를 위한 조회조건 저장
		redirectAttributes.addFlashAttribute("cls_cd", cls_cd);
		redirectAttributes.addFlashAttribute("req_dept_cd", req_dept_cd);
		redirectAttributes.addFlashAttribute("fin_cd", fin_cd);
		redirectAttributes.addFlashAttribute("req_dt", req_dt);
		redirectAttributes.addFlashAttribute("prdln_cd", prdln_cd);
		redirectAttributes.addFlashAttribute("scrts_no", scrts_no);
		redirectAttributes.addFlashAttribute("ctt_sdate", ctt_sdate);
		redirectAttributes.addFlashAttribute("ctt_edate", ctt_edate);
	
		try {
			contractByFinanceDetailService.setAnalysisAll(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		
		return "redirect:/getContractDetailList.do";
	}
	
	/**
	 * 대본파일 다운로드 팝업 조회
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/tm/getScriptFileInfo.do")
	public String getScriptFileInfo(ContractVo pScrInfo, HttpSession session, HttpServletRequest request, Model model) {
		ContractVo scrFileInfo = new ContractVo();
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		
		pMap.put("cls_cd", pScrInfo.getCls_cd());
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("fin_cd", pScrInfo.getFin_cd());
		pMap.put("req_dt", pScrInfo.getReq_dt());
		pMap.put("scrts_no", pScrInfo.getScrts_no());
		
		if(pScrInfo.getScr_spr().equals("1")) {
			pMap.put("pdesc_scpt_file_nm", pScrInfo.getPdesc_scpt_file_nm() == null ? "" : pScrInfo.getPdesc_scpt_file_nm());
			pMap.put("hpycl_scpt_file_nm", "");
			model.addAttribute("file_nm", pScrInfo.getPdesc_scpt_file_nm() == null ? "" : pScrInfo.getPdesc_scpt_file_nm());
		}else if(pScrInfo.getScr_spr().equals("2")) {
			pMap.put("pdesc_scpt_file_nm", "");
			pMap.put("hpycl_scpt_file_nm", pScrInfo.getHpycl_scpt_file_nm() == null ? "" : pScrInfo.getHpycl_scpt_file_nm());
			model.addAttribute("file_nm", pScrInfo.getHpycl_scpt_file_nm() == null ? "" : pScrInfo.getHpycl_scpt_file_nm());
		}
		try {
			scrFileInfo = contractByFinanceDetailService.getScriptFileInfo(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		
		model.addAttribute("fin_nm", pScrInfo.getFin_nm());
		model.addAttribute("scrFileInfo", scrFileInfo);
		return "rpt/scriptDownloadPopup";
	}
}
