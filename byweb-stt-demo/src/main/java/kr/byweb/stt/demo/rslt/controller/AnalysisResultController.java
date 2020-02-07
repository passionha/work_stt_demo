package kr.byweb.stt.demo.rslt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.boot.json.JsonParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonValue;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.conf.model.AnlysStdVo;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;
import kr.byweb.stt.demo.rslt.service.AnalysisResultService;

@Controller
public class AnalysisResultController {
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	AnalysisResultService analysisResultService;
	
	/**
	 * 업로드파일 회사목록 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/getAnlysRsltList.do")
	public String getAnlysRsltList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rslt/analysisResult");
		Map finPMap = new HashMap();
		List<TmCmCdVo> finList = new ArrayList<TmCmCdVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		
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
		
		model.addAttribute("finList", finList);
		
		return "main";
	}
	
	/**
	 * 선택한 회사의 업로드파일 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getUplFileList.do")
	@ResponseBody
	public List<AnlysRsltVo> getKeywordDuplicationList(HttpSession session, HttpServletRequest request, Model model) {
		Map uplPMap = new HashMap();
		List<AnlysRsltVo> uplList = new ArrayList<AnlysRsltVo>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("sel_fin_cd") == null ? "" : request.getParameter("sel_fin_cd");
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
		return uplList;
	}
	
	/**
	 * 전체 분석 진행상태 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getAnlySttsList.do")
	@ResponseBody
	public List<AnlysRsltVo> getAnlySttsList(@RequestBody AnlysRsltVo[] arrChkFiles, HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<AnlysRsltVo> sttsList = new ArrayList<AnlysRsltVo>();
		
		List<Map<String, String>> paramList = new ArrayList<Map<String,String>>();
		for(AnlysRsltVo chkFile : arrChkFiles) {
			Map<String, String> map = new HashMap<String, String>();
				map.put("cls_cd", chkFile.getCls_cd());
				map.put("req_dept_cd", chkFile.getReq_dept_cd());
				map.put("fin_cd", chkFile.getFin_cd());
				map.put("save_file_nm", chkFile.getSave_file_nm());
				paramList.add(map);
//				키워드 json정보 호출 추가 필요
//				변환파일 저장 추가 필요
		}
		pMap.put("fileList", paramList);
		try {
			sttsList = analysisResultService.getAnlySttsList(pMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sttsList;
	}
	
	/**
	 * 종합결과 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getTotalInspectoinList.do")
	@ResponseBody
	public List<AnlysRsltVo> getTotalInspectoinList(@RequestBody AnlysRsltVo[] arrChkFiles, HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<AnlysRsltVo> totRsltList = new ArrayList<AnlysRsltVo>();
		List<Map<String, String>> paramList = new ArrayList<Map<String,String>>();
		for(AnlysRsltVo chkFile : arrChkFiles) {
			Map<String, String> map = new HashMap<String, String>();
				map.put("cls_cd", chkFile.getCls_cd());
				map.put("req_dept_cd", chkFile.getReq_dept_cd());
				map.put("req_dt", chkFile.getReq_dt());
				map.put("fin_cd", chkFile.getFin_cd());
				map.put("save_file_nm", chkFile.getSave_file_nm());
				paramList.add(map);
//				키워드 json정보 호출 추가 필요
//				변환파일 저장 추가 필요
		}
		pMap.put("fileList", paramList);
		try {
			totRsltList = analysisResultService.getTotalInspectoinList(pMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return totRsltList;
	}
	
	/**
	 * 텍스트 변환결과 및 계약별 결과 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getSttResultList.do")
	@ResponseBody
	public List<AnlysRsltVo> getSttResultList(@RequestBody AnlysRsltVo totRslt, HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<AnlysRsltVo> sttRsltList = new ArrayList<AnlysRsltVo>();
		pMap.put("cls_cd", totRslt.getCls_cd());
		pMap.put("req_dept_cd", totRslt.getReq_dept_cd());
		pMap.put("fin_cd", totRslt.getFin_cd());
		pMap.put("req_dt", totRslt.getReq_dt());
		pMap.put("prdln_cd", totRslt.getPrdln_cd());
		pMap.put("scrts_no", totRslt.getScrts_no() == null ? "" : totRslt.getScrts_no());
		
		
		List<Map<String, String>> fileList = new ArrayList<Map<String,String>>();
		for(String save_file_nm : totRslt.getArr_save_file_nm()) {
			Map<String, String> fMap = new HashMap<String, String>();
			fMap.put("save_file_nm", save_file_nm);
				fileList.add(fMap);
		}
		pMap.put("flUplList", fileList);
		
		try {
			sttRsltList = analysisResultService.getSttResultList(pMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sttRsltList;
	}
	
	/**
	 * 종합결과 엑셀 다운로드
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getTotalInspectoinList_exl.do")
	public String getTotalInspectoinList_exl(AnlysRsltVo anlysRsltVo, HttpServletResponse response, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<AnlysRsltVo> totRsltList = new ArrayList<AnlysRsltVo>();
		List<Map<String, String>> paramList = new ArrayList<Map<String,String>>();
		for(AnlysRsltVo chkFlList : anlysRsltVo.getAnlysRsltVos()) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("cls_cd", chkFlList.getCls_cd());
			map.put("req_dept_cd", chkFlList.getReq_dept_cd());
			map.put("req_dt", chkFlList.getReq_dt());
			map.put("fin_cd", chkFlList.getFin_cd());
			map.put("save_file_nm", chkFlList.getSave_file_nm());
			paramList.add(map);
		}
		pMap.put("fileList", paramList);
		
		try {
			totRsltList = analysisResultService.getTotalInspectoinList(pMap);
			model.addAttribute("totRsltList", totRsltList);
			model.addAttribute("filename", "종합결과.xls");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "rslt/analysisResult_totRslt_exl";
	}
	
	/**
	 * 계약별 결과 엑셀 다운로드
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getSttResultList_exl.do")
	public String getSttResultList_exl(AnlysRsltVo anlysRsltVo, HttpServletResponse response, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		List<AnlysRsltVo> cttRsltList = new ArrayList<AnlysRsltVo>();
		List<Map<String, String>> fileList = new ArrayList<Map<String,String>>();
		
		pMap.put("cls_cd", anlysRsltVo.getCls_cd());
		pMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		pMap.put("fin_cd", anlysRsltVo.getFin_cd());
		pMap.put("req_dt", anlysRsltVo.getReq_dt());
		pMap.put("prdln_cd", anlysRsltVo.getPrdln_cd());
		pMap.put("scrts_no", anlysRsltVo.getScrts_no() == null ? "" : anlysRsltVo.getScrts_no());
		
		String arrSaveFileNm[] = anlysRsltVo.getArr_save_file_nm();
		for(int i=0; i<arrSaveFileNm.length; i++) {
			Map<String, String> fMap = new HashMap<String, String>();
			fMap.put("save_file_nm", arrSaveFileNm[i]);
			fileList.add(fMap);
		}
		pMap.put("flUplList", fileList);
		
		try {
			cttRsltList = analysisResultService.getSttResultList(pMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("cttRsltList", cttRsltList);
		model.addAttribute("filename", "계약별결과.xls");
		return "rslt/analysisResult_cttRslt_exl";
	}
}
