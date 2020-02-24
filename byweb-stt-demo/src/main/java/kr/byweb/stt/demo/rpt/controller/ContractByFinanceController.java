package kr.byweb.stt.demo.rpt.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.byweb.stt.demo.cm.controller.TmCommonController;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.cm.service.TmCommonCodeService;
import kr.byweb.stt.demo.cm.service.TmUtil;
import kr.byweb.stt.demo.rpt.model.ContractVo;
import kr.byweb.stt.demo.rpt.service.ContractByFinanceService;

@Controller
public class ContractByFinanceController {
	private static final Logger LOGGER = LogManager.getLogger(ContractByFinanceController.class);
	
	@Autowired
	TmCommonCodeService tmCommonCodeService;
	
	@Autowired
	ContractByFinanceService contractByFinanceService;
	
	/**
	 * 회사별 제출현황 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getContractList.do")
	public String getContractList(HttpSession session, HttpServletRequest request, Model model) {
		model.addAttribute("contentPage", "rpt/contractByFinance");
		Map finPMap = new HashMap();
		Map conPMap = new HashMap();
		String fin_cd = "";
		String sdate = "";
		String edate = "";
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		
		//삭제 후 redirect 시 저장한 파라미터 추출
		Map<String, ?> inputFlashMap =  RequestContextUtils.getInputFlashMap(request);
		if(inputFlashMap != null) {
			sdate = (String) inputFlashMap.get("sdate");
			edate = (String) inputFlashMap.get("edate");
			fin_cd = (String) inputFlashMap.get("fin_cd");
		}else {
			fin_cd = request.getParameter("sel_fin_cd") == null ? "" : (String) request.getParameter("sel_fin_cd");
			
			if(request.getParameter("edate") == null) {
				edate = fmt.format(cal.getTime());
			}else {
				edate = (String)request.getParameter("edate").replaceAll("[^0-9]", "");
			}
			
			if(request.getParameter("sdate") == null) {
				cal.add(Calendar.MONTH, -1);
				sdate = fmt.format(cal.getTime());
			}else {
				sdate = (String)request.getParameter("sdate").replaceAll("[^0-9]", "");
			}
		}
		
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
		
		model.addAttribute("sdate", sdate);
		model.addAttribute("edate", edate);
		model.addAttribute("fin_cd", fin_cd);
		
		finPMap.put("cls_cd", class_cd);
		finPMap.put("sdate", sdate);
		
		conPMap.put("req_dept_cd", req_dept_cd);
		conPMap.put("fin_cd", fin_cd);
		conPMap.put("sdate", sdate);
		conPMap.put("edate", edate);
		
		try {
			List<TmCmCdVo> finList = tmCommonCodeService.getReqDeptList(finPMap);
			model.addAttribute("finList", finList);
			
			List<ContractVo> conList = contractByFinanceService.getContractList(conPMap);
			model.addAttribute("conList", conList);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		return "main";
	}
	
	/**
	 * 회사별 제출현황 삭제
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/delContract.do")
	public String delContract(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Map pMap = new HashMap();
		List<Map> files = new ArrayList<Map>();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String sdate = request.getParameter("sdate") == null ? "" : (String) request.getParameter("sdate");
		String edate = request.getParameter("edate") == null ? "" : (String) request.getParameter("edate");
		String sel_fin_cd = request.getParameter("sel_fin_cd") == null ? "" : (String) request.getParameter("sel_fin_cd");
		String cls_cd = request.getParameter("cls_cd") == null ? "" : (String) request.getParameter("cls_cd");
		String fin_cd = request.getParameter("fin_cd") == null ? "" : (String) request.getParameter("fin_cd");
		String req_dt = request.getParameter("req_dt") == null ? "" : (String) request.getParameter("req_dt");
		
		pMap.put("cls_cd", cls_cd);
		pMap.put("req_dept_cd", req_dept_cd);
		pMap.put("fin_cd", fin_cd);
		pMap.put("req_dt", req_dt);
		
		try {
			files = contractByFinanceService.delContract(pMap);
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		/*
		//property설정 필요
		String rootPath = "";
		String rcdFilePath = "";
		String scriptPath = "";
		
		for(int i=0; i<files.size(); i++) {
			String fileDirName = "";
			String filePath = "";
			Map map = files.get(i);
			String uplSpr = map.get("UPL_SPR").toString();
			String saveFileNm = map.get("SAVE_FILE_NM").toString();
			
			int pos = saveFileNm.lastIndexOf(".");
			if(pos >= 0) {
				if(saveFileNm != null) {
					fileDirName = saveFileNm.substring(0, pos) + "/";
				}
			}
			
			//녹취파일 경로
			if(uplSpr.equals("1")) {
				filePath = rootPath + rcdFilePath + fileDirName;
			}
			
			//대본파일 경로
			if(uplSpr.equals("2")) {
				filePath = rootPath + scriptPath + fileDirName;
			}
			
			try {
				fileDelete(filePath);
			} catch (IOException e) {
				//loggere
				e.printStackTrace();
			}
		}
		*/
		
		//redirect경로로 전달할 파라미터 저장
		redirectAttributes.addFlashAttribute("fin_cd", sel_fin_cd);
		redirectAttributes.addFlashAttribute("sdate", sdate);
		redirectAttributes.addFlashAttribute("edate", edate);
		
		return "redirect:/tm/getContractList.do";
	}
	
	/**
	 * 회사별 제출현황 엑셀 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/tm/getContract_exl.do")
	public String getContract_exl(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) {
		Map pMap1 = new HashMap();
		Map pMap2 = new HashMap();
		String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String) session.getAttribute("req_dept_cd");
		String fin_cd = request.getParameter("org_fin_cd") == null ? "" : (String) request.getParameter("org_fin_cd");
		String sdate = request.getParameter("org_sdate") == null ? "" : (String) request.getParameter("org_sdate");
		String edate = request.getParameter("org_edate") == null ? "" : (String) request.getParameter("org_edate");
		String fin_nm = request.getParameter("org_fin_nm") == null ? "" : (String) request.getParameter("org_fin_nm")+"_";
		
		pMap2.put("req_dept_cd", req_dept_cd);
		pMap2.put("fin_cd", fin_cd);
		pMap2.put("sdate", sdate);
		pMap2.put("edate", edate);
		
		try {
			List<ContractVo> conList = contractByFinanceService.getContractList(pMap2);
			model.addAttribute("conList", conList);
			model.addAttribute("filename", fin_nm+"제출현황.xls");
		} catch (Exception e) {
			LOGGER.debug("Exception : " + e.toString());
		}
		return "rpt/contractByFinance_exl";
	}
	
	/**
	 * 디렉토리 하위 파일 삭제
	 * @param filePath
	 */
	private void fileDelete(String filePath) throws IOException {
		TmUtil tmUtil = new TmUtil();
		
		if(!filePath.equals("")) {
			File savePath = new File(filePath);
			if(savePath != null) {
				File[] files = savePath.listFiles();
				if(files != null && savePath.exists()) {
					for(File f : files) {
						if(f != null && f.exists()) {
							tmUtil.fileDelete(f);
						}
					}
					tmUtil.fileDelete(savePath);
				}
			}
		}
	}
}
