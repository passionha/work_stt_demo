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
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;
import kr.byweb.stt.demo.rslt.service.AnalysisResultService;

@Controller
public class AnalysisResultController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	AnalysisResultService analysisResultService;
	
	/**
	 * 회사 업로드파일 목록 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getAnlysRsltList.do")
	public String getAnlysRsltList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rslt/analysisResult");
		Map finPMap = new HashMap();
		Map uplPMap = new HashMap();
		List<TmCmCdVo> finList = new ArrayList<TmCmCdVo>();
		List<AnlysRsltVo> uplList = new ArrayList<AnlysRsltVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("sel_fin_cd") == null ? "" : request.getParameter("sel_fin_cd");
		
		//조회조건 회사목록 조회 시 사용될 CLASS_CD를 요청부서에 따라 부여
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
		
		try {
			finList = tmCommonCodeService.getReqDeptList(finPMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//선택 회사의 업로드파일 조회 시 사용될 권역코드를 CLASS_CD에 따라 부여
		String sel_cls_cd = "";
		if(request.getParameter("upl_class_cd") != null) {
			switch(request.getParameter("upl_class_cd").substring(0, 4)) {
			case "0501" :
				sel_cls_cd = "1";
				break;
			case "0502" :
				sel_cls_cd = "2";
				break;
			case "0307" :
				//금융감독원관리자
				sel_cls_cd = "1";
				break;
			}
			uplPMap.put("cls_cd", sel_cls_cd);
			uplPMap.put("req_dept_cd", req_dept_cd);
			uplPMap.put("fin_cd", fin_cd);
			try {
				uplList = analysisResultService.getUplFileList(uplPMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("fin_cd", fin_cd);
		model.addAttribute("finList", finList);
		model.addAttribute("uplList", uplList);
		return "main";
	}
}
