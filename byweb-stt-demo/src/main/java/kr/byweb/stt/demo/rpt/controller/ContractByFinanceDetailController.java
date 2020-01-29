package kr.byweb.stt.demo.rpt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.rpt.model.ContractVo;
import kr.byweb.stt.demo.rpt.service.ContractByFinanceDetailService;

@Controller
public class ContractByFinanceDetailController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	ContractByFinanceDetailService contractByFinanceDetailService;
	
	/**
	 * 녹취파일 계약정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getContractDetailList.do")
	public String getContractDetailList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rpt/contractByFinanceDetail");
		Map conPMap = new HashMap();
		Map finPMap = new HashMap();
		Map prdPMap = new HashMap();
		List<TmCmCdVo> finList = new ArrayList<TmCmCdVo>();
		List<TmCmCdVo> prdList = new ArrayList<TmCmCdVo>();
		List<ContractVo> conList = new ArrayList<ContractVo>();
		String cls_cd = request.getParameter("cls_cd") == null ? "" : request.getParameter("cls_cd");
		String req_dept_cd = request.getParameter("req_dept_cd") == null ? (String) session.getAttribute("req_dept_cd") : request.getParameter("req_dept_cd");
		String fin_cd = request.getParameter("fin_cd") == null ? "" : request.getParameter("fin_cd");
		String req_dt = request.getParameter("req_dt") == null ? "" : request.getParameter("req_dt");
		String scrts_no = request.getParameter("scrts_no") == null ? "" : request.getParameter("scrts_no");
		String prdln_cd = request.getParameter("prdln_cd") == null ? "" : request.getParameter("prdln_cd");
		String ctt_sdate = request.getParameter("ctt_sdate") == null ? "" : request.getParameter("ctt_sdate");
		String ctt_edate = request.getParameter("ctt_edate") == null ? "" : request.getParameter("ctt_edate");
		
		conPMap.put("cls_cd", cls_cd);
		conPMap.put("req_dept_cd", req_dept_cd);
		conPMap.put("fin_cd", fin_cd);
		conPMap.put("req_dt", req_dt);
		conPMap.put("scrts_no", scrts_no);
		conPMap.put("prdln_cd", prdln_cd);
		conPMap.put("ctt_sdate", ctt_sdate);
		conPMap.put("ctt_edate", ctt_edate);
		
		String det_cls_cd = "";
		if(request.getParameter("det_cls_cd") != null) {
			String strCls = request.getParameter("det_cls_cd").substring(0, 4);
			switch(strCls) {
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
		
		String sel_req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String class_cd = "";
		switch(sel_req_dept_cd) {
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
		System.out.println(conPMap.toString());
		try {
			finList = tmCommonCodeService.getReqDeptList(finPMap);
			prdList = tmCommonCodeService.getPrdlnList(prdPMap);
			conList = contractByFinanceDetailService.getContractDetailList(conPMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
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
}
