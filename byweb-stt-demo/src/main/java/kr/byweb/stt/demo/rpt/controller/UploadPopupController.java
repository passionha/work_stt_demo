package kr.byweb.stt.demo.rpt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.byweb.stt.demo.rpt.service.UploadPopupService;

@Controller
public class UploadPopupController {
	
	@Autowired
	UploadPopupService uploadPopupService;
	
	/**
	 * 녹취파일 업로드 기본정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getDefInfo")
	public String getDefInfo(HttpSession session, HttpServletRequest request, Model model) {
		
		
		return "rpt/recordingUploadPopup";
	}
}
