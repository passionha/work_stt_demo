package kr.byweb.stt.demo.rslt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.mng.model.PrdlnMngVo;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;
import kr.byweb.stt.demo.rslt.service.RecordingFileResultService;

@Controller
public class RecordingFileResultController {
	private static final Logger LOGGER = LogManager.getLogger(RecordingFileResultController.class);
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	RecordingFileResultService recordingFileResultService;
	
	/**
	 * 오류내역 목록 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getRecordingFileResultList.do")
	public String getRecordingFileResultList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rslt/recordingFileResult");
		Map pMap = new HashMap();
		Map finPMap = new HashMap();
		List<TmCmCdVo> finList = new ArrayList<TmCmCdVo>();
		List<TmCmCdVo> errList = new ArrayList<TmCmCdVo>();
		List<AnlysRsltVo> rcdRsltList = new ArrayList<AnlysRsltVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("sel_fin_cd") == null ? "ALL" : request.getParameter("sel_fin_cd");
		String req_dt = request.getParameter("req_dt") == null ? "" : request.getParameter("req_dt").replaceAll("[^0-9]", "");
		String err_cd = request.getParameter("err_cd") == null ? "ALL" : request.getParameter("err_cd");
		System.out.println(req_dt);
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
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("fin_cd", fin_cd);
		pMap.put("req_dt", req_dt);
		pMap.put("err_cd", err_cd);
		try {
			finList = tmCommonCodeService.getReqDeptList(finPMap);
			errList = tmCommonCodeService.getErrorCdList();
			rcdRsltList = recordingFileResultService.getRecordingFileResultList(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
//		System.out.println(rcdRsltList);
		model.addAttribute("fin_cd", fin_cd);
		model.addAttribute("req_dt", req_dt);
		model.addAttribute("err_cd", err_cd);
		model.addAttribute("finList", finList);
		model.addAttribute("errList", errList);
		model.addAttribute("rcdRsltList", rcdRsltList);
		return "main";
	}
	
	/**
	 * 녹취파일 오류내역 엑셀 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getRecordingFileResult_exl.do")
	public String getRecordingFileResult_exl(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<AnlysRsltVo> rcdRsltList = new ArrayList<AnlysRsltVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("org_fin_cd") == null ? "ALL" : request.getParameter("org_fin_cd");
		String req_dt = request.getParameter("org_req_dt") == null ? "" : request.getParameter("org_req_dt");
		String err_cd = request.getParameter("org_err_cd") == null ? "ALL" : request.getParameter("org_err_cd");
		String fin_nm = request.getParameter("org_fin_nm") == null ? "전체" : request.getParameter("org_fin_nm");
		
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("fin_cd", fin_cd);
		pMap.put("req_dt", req_dt);
		pMap.put("err_cd", err_cd);
		try {
			rcdRsltList = recordingFileResultService.getRecordingFileResultList(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		String fileNm = fin_nm+"_" + (req_dt.equals("") ? "" : req_dt+"_") + "오류내역.xls";
		model.addAttribute("rcdRsltList", rcdRsltList);
		model.addAttribute("filename", fileNm);
		return "rslt/recordingFileResult_exl";
	}
}
