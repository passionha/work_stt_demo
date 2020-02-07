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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		int esnKwdTmCnt = 0;
		int banKwdTmCnt = 0;
		AnlysRsltVo cttInfo = new AnlysRsltVo();
		Map pMap = new HashMap();
		Map esnKwdPMap = new HashMap();
		Map banKwdPMap = new HashMap();
		Map omsnKwdPMap = new HashMap();
		Map rcdFlPMap = new HashMap();
		ArrayList<Map> esnKwdTmList = new ArrayList<Map>();
		ArrayList<Map> banKwdTmList = new ArrayList<Map>();
		List<AnlysRsltVo> inspcList = new ArrayList<AnlysRsltVo>();
		List<AnlysRsltVo> esnKwdList = new ArrayList<AnlysRsltVo>();
		List<AnlysRsltVo> banKwdList = new ArrayList<AnlysRsltVo>();
		List<AnlysRsltVo> omsnKwdList = new ArrayList<AnlysRsltVo>();
		List<AnlysRsltVo> rcdFlList = new ArrayList<AnlysRsltVo>();
		
		pMap.put("cls_cd", anlysRsltVo.getCls_cd());
		pMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		pMap.put("req_dt", anlysRsltVo.getReq_dt());
		pMap.put("fin_cd", anlysRsltVo.getFin_cd());
		pMap.put("scrts_no", anlysRsltVo.getScrts_no());
		
		esnKwdPMap.put("cls_cd", anlysRsltVo.getCls_cd());
		esnKwdPMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		esnKwdPMap.put("req_dt", anlysRsltVo.getReq_dt());
		esnKwdPMap.put("fin_cd", anlysRsltVo.getFin_cd());
		esnKwdPMap.put("prdln_cd", anlysRsltVo.getPrdln_cd());
		esnKwdPMap.put("scrts_no", anlysRsltVo.getScrts_no());
		esnKwdPMap.put("kwd_spr", "1");
		
		banKwdPMap.put("cls_cd", anlysRsltVo.getCls_cd());
		banKwdPMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		banKwdPMap.put("req_dt", anlysRsltVo.getReq_dt());
		banKwdPMap.put("fin_cd", anlysRsltVo.getFin_cd());
		banKwdPMap.put("prdln_cd", anlysRsltVo.getPrdln_cd());
		banKwdPMap.put("scrts_no", anlysRsltVo.getScrts_no());
		banKwdPMap.put("kwd_spr", "2");
		
		omsnKwdPMap.put("cls_cd", anlysRsltVo.getCls_cd());
		omsnKwdPMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		omsnKwdPMap.put("req_dt", anlysRsltVo.getReq_dt());
		omsnKwdPMap.put("fin_cd", anlysRsltVo.getFin_cd());
		omsnKwdPMap.put("prdln_cd", anlysRsltVo.getPrdln_cd());
		omsnKwdPMap.put("scrts_no", anlysRsltVo.getScrts_no());
		
		rcdFlPMap.put("cls_cd", anlysRsltVo.getCls_cd());
		rcdFlPMap.put("req_dept_cd", anlysRsltVo.getReq_dept_cd());
		rcdFlPMap.put("req_dt", anlysRsltVo.getReq_dt());
		rcdFlPMap.put("fin_cd", anlysRsltVo.getFin_cd());
		rcdFlPMap.put("prdln_cd", anlysRsltVo.getPrdln_cd());
		rcdFlPMap.put("scrts_no", anlysRsltVo.getScrts_no());
		
		try {
			//출현키워드 중 동일키워드 총 출현 개수
			Integer esnKwdRsltCnt = analysisResultDetailService.getKwdRsltCnt(esnKwdPMap);
			esnKwdTmCnt = esnKwdRsltCnt == null ? 0 : esnKwdRsltCnt;
			Integer banKwdRsltCnt = analysisResultDetailService.getKwdRsltCnt(banKwdPMap);
			banKwdTmCnt = banKwdRsltCnt == null ? 0 : banKwdRsltCnt;
			for(int i=0; i<esnKwdTmCnt; i++) {
				Map map = new HashMap();
				map.put("tm", Integer.toString(i+1));
				map.put("col", "T"+(i+1));
				
				esnKwdTmList.add(map);
			}
			for(int i=0; i<banKwdTmCnt; i++) {
				Map map = new HashMap();
				map.put("tm", Integer.toString(i+1));
				map.put("col", "T"+(i+1));
				
				banKwdTmList.add(map);
			}
			esnKwdPMap.put("kwdTmList", esnKwdTmList);
			banKwdPMap.put("kwdTmList", banKwdTmList);
			
			//계약정보
			cttInfo = analysisResultDetailService.getContractInfo(pMap);
			//검수결과 목록
			inspcList = analysisResultDetailService.getInspectionResultList(pMap);
			//필수키워드 목록
			esnKwdTmList = analysisResultDetailService.getKwdRsltList(esnKwdPMap);
			//금지어 목록
			banKwdTmList = analysisResultDetailService.getKwdRsltList(banKwdPMap);
			//누락키워드 목록
			omsnKwdList = analysisResultDetailService.getOmissionKeywordList(omsnKwdPMap);
			//관련녹취파일 목록
			rcdFlList = analysisResultDetailService.getRecordingFileList(rcdFlPMap);
			//텍스트변환결과
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("cttInfo", cttInfo);
		model.addAttribute("inspcList", inspcList);
		model.addAttribute("esnKwdTmCnt", esnKwdTmCnt);
		model.addAttribute("banKwdTmCnt", banKwdTmCnt);
		model.addAttribute("esnKwdList", esnKwdTmList);
		model.addAttribute("banKwdList", banKwdTmList);
		model.addAttribute("omsnKwdList", omsnKwdList);
		model.addAttribute("rcdFlList", rcdFlList);
		
		return "main";
	}
	
	/**
	 * 수동 검수결과 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertInspectionResult.do")
	@ResponseBody
	public int insertInspectionResult(@RequestBody AnlysRsltVo manualInspcRslt, HttpSession session, HttpServletRequest request, Model model) {
		Map pMap = new HashMap();
		pMap.put("cls_cd", manualInspcRslt.getCls_cd());
		pMap.put("req_dept_cd", manualInspcRslt.getReq_dept_cd());
		pMap.put("fin_cd", manualInspcRslt.getFin_cd());
		pMap.put("req_dt", manualInspcRslt.getReq_dt());
		pMap.put("prdln_cd", manualInspcRslt.getPrdln_cd());
		pMap.put("scrts_no", manualInspcRslt.getScrts_no());
		pMap.put("missell_yn", manualInspcRslt.getMissell_yn());
		pMap.put("scr", manualInspcRslt.getScr());
		pMap.put("esn_kwd_num", manualInspcRslt.getEsn_kwd_num());
		pMap.put("omsn_kwd_num", manualInspcRslt.getOmsn_kwd_num());
		pMap.put("esn_kwd_scr", manualInspcRslt.getEsn_kwd_scr());
		pMap.put("bnwd_cnt", manualInspcRslt.getBnwd_cnt());
		pMap.put("bnwd_scr", manualInspcRslt.getBnwd_scr());
		pMap.put("emp_no", "A219090");	//사용자 로그인 구현 후 수정 필요 **************************
		pMap.put("inspc_spr", "2");
		
		try {
			analysisResultDetailService.insertInspectionResult(pMap);
			pMap.remove("inspc_spr");
			pMap.put("inspc_spr", "1");
			analysisResultDetailService.insertInspectionResult(pMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return manualInspcRslt.getScr();
	}
}
