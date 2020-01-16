package kr.byweb.stt.demo.rpt.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.model.FinanceVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;

@Controller
public class ContractByFinanceController {
	
	@Autowired
	TmCommonCodeService tmCmCdService;
	
	/**
	 * 회사별 제출현황 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getContractList")
	public String getContractList(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		
		String fin_cd = request.getParameter("fin_cd") == null ? "" : (String) session.getAttribute("fin_cd");
		model.addAttribute("fin_cd", fin_cd);
		
		String cls_cd = "";
		switch(req_dept_cd) {
		case "1" :
			cls_cd = "050100";
			break;
		case "2" :
			cls_cd = "050200";
			break;
		case "3" :
			cls_cd = "ALL";
			break;
		}
		
		//제출일자 검색조건 default : 현재일자 한 달 전
		String sdate = "";
		String edate = "";
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		
		if(request.getParameter("edate") == null) {
			edate = fmt.format(cal.getTime());
		}else {
			edate = (String)request.getParameter("edate").replaceAll("[^0-9]", "");
		}
		
		if(request.getParameter("sdate") == null) {
			cal.add(Calendar.MONTH, -1);
			sdate = fmt.format(cal.getTime());
		}else {
			sdate = (String)request.getParameter("sdate").replaceAll("[^0-9]", "");
		}
		
		model.addAttribute("sdate", sdate);
		model.addAttribute("edate", edate);
		
		pMap.put("cls_cd", cls_cd);
		pMap.put("sdate", sdate);
		
		try {
			List<FinanceVo> finList = tmCmCdService.getReqDeptList(pMap);
			model.addAttribute("finList", finList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("===========================>"+sdate);
		System.out.println("===========================>"+edate);
		return "rpt/contractByFinance";
	}
	
	/**
	 * 녹취파일 업로드 팝업
	 * @param model
	 * @return
	 */
	@RequestMapping("/recUplPopup")
	public String recUplPopup(Model model) {
		return "rpt/recordingUploadPopup";
	}
}
