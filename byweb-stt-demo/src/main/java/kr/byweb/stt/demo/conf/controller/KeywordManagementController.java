package kr.byweb.stt.demo.conf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.byweb.stt.demo.conf.model.AnlysStd;
import kr.byweb.stt.demo.conf.service.KeywordManagementService;

@Controller
public class KeywordManagementController {
	
	@Autowired
	KeywordManagementService keywordManagementService;
	
	@RequestMapping("/")
	public String goMain(Model model) {
//		model.addAttribute("name", "홍길동");
		return "main";
	}
	
	@RequestMapping("/getAnlysStdList")
	public String getAnlysStdList(Model model) {
//		model.addAttribute("name", "홍길동");
		return "conf/keywordManagement";
	}
	
	@RequestMapping("/selectTime")
	public @ResponseBody String selectTime() {
		
		String strTime = "";
		try {
			strTime = keywordManagementService.selectTime();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strTime;
	}
	
	@RequestMapping("/goSynPopup")
	public String goSynPopup(Model model) {
		return "conf/synonymPopup";
	}
	
	/*
	@RequestMapping("/getAnlysStdList")
	public AnlysStd getAnlysStdList() {
		return anlysStdService.getAnlysStdList();
	}*/
}
