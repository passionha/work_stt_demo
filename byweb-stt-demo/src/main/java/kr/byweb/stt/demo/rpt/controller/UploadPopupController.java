package kr.byweb.stt.demo.rpt.controller;

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
import kr.byweb.stt.demo.rpt.model.ContractVo;
import kr.byweb.stt.demo.rpt.service.UploadPopupService;

@Controller
public class UploadPopupController {
	private static final Logger LOGGER = LogManager.getLogger(UploadPopupController.class);
	
	@Autowired
	UploadPopupService uploadPopupService;
	
	/**
	 * 녹취파일 업로드 기본정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getDefInfo.do")
	public String getDefInfo(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap1 = new HashMap();
		Map pMap2 = new HashMap();
		Map pMap3 = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		
		String fin_cd = request.getParameter("fin_cd") == null ? "" : (String) request.getParameter("fin_cd");
		String req_dt = request.getParameter("req_dt") == null ? "" : (String) request.getParameter("req_dt");
		
		pMap1.put("fin_cd", fin_cd);
		pMap1.put("req_dt", req_dt);
		
		pMap2.put("req_dept_cd", req_dept_cd);
		pMap2.put("fin_cd", fin_cd);
		pMap2.put("req_dt", req_dt);
		pMap2.put("upl_spr", "1");
		
		pMap3.put("req_dept_cd", req_dept_cd);
		pMap3.put("fin_cd", fin_cd);
		pMap3.put("req_dt", req_dt);
		pMap3.put("upl_spr", "1");
		
		try {
			ContractVo contractVo = uploadPopupService.getDefInfo(pMap1);
			List<ContractVo> hisList = uploadPopupService.getHisList(pMap2);
			List<ContractVo> mismatchList = uploadPopupService.getMismatchList(pMap3);
			
			model.addAttribute("contractVo", contractVo);			//회사 기본 정보
			model.addAttribute("hisList", hisList);					//업로드 조회 결과
			model.addAttribute("mismatchList", mismatchList);		//비매칭 녹취파일 목록
			
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		return "rpt/recordingUploadPopup";
	}
}
