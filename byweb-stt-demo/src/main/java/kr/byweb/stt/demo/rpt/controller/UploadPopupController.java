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
	 * 업로드 팝업 기본정보 조회
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/tm/getDefInfo.do")
	public String getDefInfo(HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		Map hisPMap = new HashMap();
		Map msmcPMap = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("fin_cd") == null ? "" : (String) request.getParameter("fin_cd");
		String req_dt = request.getParameter("req_dt") == null ? "" : (String) request.getParameter("req_dt");
		String upl_spr = request.getParameter("upl_spr") == null ? "" : (String) request.getParameter("upl_spr");
		
		pMap.put("fin_cd", fin_cd);
		pMap.put("req_dt", req_dt);
		
		hisPMap.put("req_dept_cd", req_dept_cd);
		hisPMap.put("fin_cd", fin_cd);
		hisPMap.put("req_dt", req_dt);
		hisPMap.put("upl_spr", upl_spr);
		
		try {
			ContractVo contractVo = uploadPopupService.getDefInfo(pMap);
			List<ContractVo> hisList = uploadPopupService.getHisList(hisPMap);
			
			model.addAttribute("contractVo", contractVo);			//회사 기본 정보
			model.addAttribute("hisList", hisList);					//업로드 조회 결과
			
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		
		if(upl_spr.equals("1")) {
			try {
				msmcPMap.put("req_dept_cd", req_dept_cd);
				msmcPMap.put("fin_cd", fin_cd);
				msmcPMap.put("req_dt", req_dt);
				msmcPMap.put("upl_spr", upl_spr);
				
				List<ContractVo> mismatchList = uploadPopupService.getMismatchList(msmcPMap);
				model.addAttribute("mismatchList", mismatchList);		//비매칭 녹취파일 목록
				
			} catch (Exception e) {
				LOGGER.debug("Exception : " + e.toString());
			}
			return "rpt/recordingUploadPopup";
		}else {
			return "rpt/scriptUploadPopup";
		}
	}
}
