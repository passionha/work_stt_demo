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
import kr.byweb.stt.demo.rslt.service.AnalysisResultDetailService;

@Controller
public class AnalysisResultDetailController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	AnalysisResultDetailService analysisResultDetailService;
	
	/**
	 * 계약정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getContractInfo.do")
	public String getContractInfo(AnlysRsltVo anlysRsltVo, HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rslt/analysisResultDetail");
		AnlysRsltVo cttInfo = new AnlysRsltVo();
		List<AnlysRsltVo> inspcList = new ArrayList<AnlysRsltVo>();
		Map pMap = new HashMap();
		pMap.put("cls_cd", anlysRsltVo.getCls_cd());
		pMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		pMap.put("req_dt", anlysRsltVo.getReq_dt());
		pMap.put("fin_cd", anlysRsltVo.getFin_cd());
		pMap.put("scrts_no", anlysRsltVo.getScrts_no());
		
		try {
//			계약정보
			cttInfo = analysisResultDetailService.getContractInfo(pMap);
			//검수결과 리스트
			inspcList = analysisResultDetailService.getInspectionResultList(pMap);
			//필수키워드 리스트
			//금지어 리스트
			// 누락키워드 리스트
			// 관련녹취 리스트
			//텍스트변환결과
			model.addAttribute("cttInfo", cttInfo);
			model.addAttribute("inspcList", inspcList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "main";
	}
}
