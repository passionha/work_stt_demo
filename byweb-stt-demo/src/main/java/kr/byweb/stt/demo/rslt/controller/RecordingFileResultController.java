package kr.byweb.stt.demo.rslt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.rslt.service.RecordingFileResultService;

@Controller
public class RecordingFileResultController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	RecordingFileResultService recordingFileResultService;
	
	/**
	 * 오류내역 목록 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getRecordingFileResultList.do")
	public String getRecordingFileResultList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rslt/recordingFileResult");
		
		return "main";
	}
}
