package kr.byweb.stt.demo.rslt.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	
	@Value("${file_path_root_key}")
    private String file_path_root_key;
	
	@Value("${file_upload_path.stt}")
	private String file_upload_path_stt;
	
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
				map.put("req_dt", chkFile.getReq_dt());
				map.put("save_file_nm", chkFile.getSave_file_nm());
				paramList.add(map);
				try {
					//키워드 json정보 호출
					List<Map> kwdInfo = analysisResultService.getRcdflList(map);
					//변환파일 저장
					List<Map> setResultFile = setResultFile(kwdInfo);
					if(setResultFile.size() > 0) {
						analysisResultService.updateTmRclflInf(setResultFile);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
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
	
	/**
	 * 키워드 분석 시작
	 * 분석단계 : 보험사 계약정보 제출 -> 업무담당자 녹취파일 업로드(4) -> 업무담당자 전체분석시작 클릭(3) -> 연계데몬(STT엔진에 변환 요청)
	 * -> STT엔진 변환 후 결과파일 생성 -> 연계데몬 결과파일 DB저장(1)/에러(2) -> 업무담당자 분석 버튼 클릭 -> 키워드 및 점수 계산 -> 완료(0)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/setKeywordInfo.do")
	@ResponseBody
	public List<AnlysRsltVo> setKeywordInfo(@RequestBody AnlysRsltVo[] arrAnlysStts, HttpSession session, HttpServletRequest request, Model model) {
//		Map pMap = new HashMap();
		
		for(AnlysRsltVo anlysStts : arrAnlysStts) {
			Map<String, String> map = new HashMap<String, String>();
				map.put("cls_cd", anlysStts.getCls_cd());
				map.put("req_dept_cd", anlysStts.getReq_dept_cd());
				map.put("fin_cd", anlysStts.getFin_cd());
				map.put("req_dt", anlysStts.getReq_dt());
				map.put("save_file_nm", anlysStts.getSave_file_nm());
				
				try {
					//키워드 json정보 호출
					List<Map> kwdInfo = analysisResultService.getRcdflList(map);
					
					//이전 사용키워드 삭제
					analysisResultService.deleteTmUseKwd(kwdInfo);
					
					//이전 키워드 라인정보 삭제
					analysisResultService.deleteKwdLineInf(kwdInfo);
					
					//변환파일 저장
					List<Map> setResultFile = setResultFile(kwdInfo);
					analysisResultService.updateTmRclflInf(setResultFile);
					
					Map kwdInfoMap = kwdInfoMake(kwdInfo);
					
					//키워드 등록
					if(kwdInfoMap.get("TM_USE_KWD") != null) {
						List<Map> getKeywordInfo = (List<Map>) kwdInfoMap.get("TM_USE_KWD");
						analysisResultService.insertTmUseKwd(getKeywordInfo);
					}
					
					//키워드 라인정보 등록
					if(kwdInfoMap.get("TM_KWD_LNINF") != null) {
						List<Map> getKeywordLineInfo = (List<Map>) kwdInfoMap.get("TM_KWD_LNINF");
//						analysisResultService.insertTmKwdLineInf(getKeywordLineInfo);
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		
		
		List<AnlysRsltVo> anlysSttsList = new ArrayList<AnlysRsltVo>();
		return anlysSttsList;
	}
	
	/**
	 * 변환파일 저장 후 db에서 비우기(empty)위한 목록 추출
	 * @param resultList
	 * @return
	 */
	public List<Map> setResultFile(List<Map> resultList) {
		
		String filePath = file_path_root_key + file_upload_path_stt;
		List<Map> result = new ArrayList<Map>();
		
		for(Map mapInfo : resultList) {
			if(!mapInfo.get("TRNS_STTS").equals("0")) {
				if(ResultFileWrite(mapInfo)) {
					String saveFileNm = mapInfo.get("SAVE_FILE_NM").toString();
					int pos = saveFileNm.lastIndexOf(".");
					String fileDirName = filePath + saveFileNm.substring(0, pos) + "/";
					String txtFile = mapInfo.get("FILE_NM").toString() + ".txt";
					String smiFile = mapInfo.get("FILE_NM").toString() + ".smi";
					
					File txtF = new File(fileDirName + txtFile);
					File smiF = new File(fileDirName + smiFile);
					
					if((txtF.exists() && txtF.length() > 0) && (smiF.exists() && smiF.length() > 0)) {
						Map<String, String> map = new HashMap<String, String>();
						map.put("CLS_CD", mapInfo.get("CLS_CD").toString());
						map.put("REQ_DEPT_CD", mapInfo.get("REQ_DEPT_CD").toString());
						map.put("FIN_CD", mapInfo.get("FIN_CD").toString());
						map.put("SCRTS_NO", mapInfo.get("SCRTS_NO").toString());
						map.put("REQ_DT", mapInfo.get("REQ_DT").toString());
						map.put("UPL_SPR", mapInfo.get("UPL_SPR").toString());
						map.put("SAVE_FILE_NM", mapInfo.get("SAVE_FILE_NM").toString());
						map.put("PRDLN_CD", mapInfo.get("PRDLN_CD").toString());
						map.put("FILE_NM", mapInfo.get("FILE_NM").toString());
						result.add(map);
					}
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 변환파일 저장
	 * @param mapInfo 파일정보
	 * @return 처리결과
	 */
	public boolean ResultFileWrite(Map mapInfo) {
		boolean ret = true;
		BufferedWriter bw = null;
		HashMap fileMap = new HashMap();
		String filePath = file_path_root_key + file_upload_path_stt;
		String saveFileNm = mapInfo.get("SAVE_FILE_NM").toString();
		int pos = saveFileNm.lastIndexOf(".");
		String fileDirName = filePath + saveFileNm.substring(0, pos) + "/";
		String fileName = mapInfo.get("FILE_NM").toString();
		String fileExt = "";
		
		File fdir = new File(fileDirName);
		if(!fdir.exists()) {
			fdir.mkdirs();
		}
		
		fileMap.put(0, mapInfo.get("FILE_TXT"));
		fileMap.put(1, mapInfo.get("FILE_SMI"));
		
		for(int i=0; i<fileMap.size(); i++) {
			String resultString = (String) fileMap.get(i);
			try {
				if(i==0) {
					fileExt = ".txt";
				}else if(i==1) {
					fileExt = ".smi";
				}
				
				if(resultString != null) {
					bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDirName + fileName + fileExt), "EUC-KR"));
					bw.write(resultString);
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				ret = false;
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				ret = false;
			} catch (IOException e) {
				e.printStackTrace();
				ret = false;
			} finally {
				if(bw != null) {
					try {
						bw.close();
					} catch (Exception e) {
						e.printStackTrace();
						ret = false;
					}
				}
			}
		}
		return ret;
	}
	
	/**
	 * 키워드 및 라인정보 추출
	 * @param resultList
	 * @return 키워드정보, 라인정보
	 * @throws IOException
	 */ 
	public synchronized Map kwdInfoMake(List<Map> resultList) throws IOException {
		List<Map<String, String>> useKwdInfo = new ArrayList<Map<String, String>>();
		List<Map<String, String>> kwdLnInf 	 = new ArrayList<Map<String, String>>();
		String filePath = file_path_root_key + file_upload_path_stt;
		
		BufferedReader 	  br  = null;
		FileInputStream   fis = null;
		InputStreamReader isr = null;
		
		try {
			for(Map mapInfo : resultList) {
				String saveFileNm  = mapInfo.get("SAVE_FILE_NM").toString();
				int pos 		   = saveFileNm.lastIndexOf(".");
				String fileDirName = filePath + saveFileNm.substring(0, pos) + "/";
				String fileName    = fileDirName + mapInfo.get("FILE_NM").toString() + ".smi";
				File f = new File(fileName);
				
				if(f.exists()) {
					List<Map<String, String>> kwdLnInfTmp = new ArrayList<Map<String, String>>();
					
					int totLnCnt  = 0;	//전체 라인 수
					int totWrdCnt = 0;	//전체 단어 수
					int lnWrdNum  = 0;	//라인 단어 수
					String readLine = "";
					
					List<Map> kwdList = new ArrayList<Map>();
					try {
						kwdList = analysisResultService.getKeywordList(mapInfo);
					} catch (Exception e) {
						e.printStackTrace();
					}
					
					fis = new FileInputStream(f);
					isr = new InputStreamReader(fis, "EUC-KR");
					if(isr != null) {
						br = new BufferedReader(isr);
						if(br != null) {
							while((readLine = br.readLine()) != null) {
								String[] lineArray = readLine.trim().split(";");
								
								if(lineArray.length == 4) {
									if(lineArray[2] != null && !lineArray[2].equals("")) {
										Map<String, String> kwdLnInfMapTmp = new HashMap<String, String>();
										
										String inLine = lineArray[2].trim();
										String[] words = inLine.split(" ");
										lnWrdNum = words.length;
										
										kwdLnInfMapTmp.put("SNO", Integer.toString(totLnCnt));	//해당라인 번호
										kwdLnInfMapTmp.put("LN_WRDNUM", Integer.toString(lnWrdNum));	//해당라인 번호
										kwdLnInfTmp.add(kwdLnInfMapTmp);
										
										for(int j=0; j<kwdList.size(); j++) {
											Map kwdInfo = (Map) kwdList.get(j);
											String kwdSpr = kwdInfo.get("KWD_SPR").toString();
											String kwdNm = kwdInfo.get("KWD_NM").toString();
											
											if(inLine.indexOf(kwdNm) >= 0) {	//띄어쓰기가 있는 단어인 경우 inLine에서 검색
												//위치찾기
												String prevKwdNm = inLine.substring(0, inLine.indexOf(kwdNm));
												int kwdNmLen = prevKwdNm.split(" ").length;
												
												Map<String, String> useKwdInfoMap = new HashMap<String, String>();
												useKwdInfoMap.put("CLS_CD", mapInfo.get("CLS_CD").toString());
												useKwdInfoMap.put("REQ_DEPT_CD", mapInfo.get("REQ_DEPT_CD").toString());
												useKwdInfoMap.put("FIN_CD", mapInfo.get("FIN_CD").toString());
												useKwdInfoMap.put("SCRTS_NO", mapInfo.get("SCRTS_NO").toString());
												useKwdInfoMap.put("REQ_DT", mapInfo.get("REQ_DT").toString());
												useKwdInfoMap.put("UPL_SPR", mapInfo.get("UPL_SPR").toString());
												useKwdInfoMap.put("SAVE_FILE_NM", mapInfo.get("SAVE_FILE_NM").toString());
												useKwdInfoMap.put("PRDLN_CD", mapInfo.get("PRDLN_CD").toString());
												useKwdInfoMap.put("FILE_NM", mapInfo.get("FILE_NM").toString());
												useKwdInfoMap.put("KWD_SPR", kwdSpr);
												useKwdInfoMap.put("APRNC_KWD_NM", kwdNm);
												useKwdInfoMap.put("APRNC_LNPOS", Integer.toString(totLnCnt));
												useKwdInfoMap.put("APRNC_WRDPOS", Integer.toString(kwdNmLen));
												useKwdInfoMap.put("APRNC_TM", lineArray[0].trim());
												//중복검사
												if(!useKwdInfo.contains(useKwdInfoMap)) {
													useKwdInfo.add(useKwdInfoMap);
												}
											}
											
											for(int i=0; i<lnWrdNum; i++) {
												if(words[i].indexOf(kwdNm) >= 0) {
													Map<String, String> useKwdInfoMap = new HashMap<String, String>();
													useKwdInfoMap.put("CLS_CD", mapInfo.get("CLS_CD").toString());
													useKwdInfoMap.put("REQ_DEPT_CD", mapInfo.get("REQ_DEPT_CD").toString());
													useKwdInfoMap.put("FIN_CD", mapInfo.get("FIN_CD").toString());
													useKwdInfoMap.put("SCRTS_NO", mapInfo.get("SCRTS_NO").toString());
													useKwdInfoMap.put("REQ_DT", mapInfo.get("REQ_DT").toString());
													useKwdInfoMap.put("UPL_SPR", mapInfo.get("UPL_SPR").toString());
													useKwdInfoMap.put("SAVE_FILE_NM", mapInfo.get("SAVE_FILE_NM").toString());
													useKwdInfoMap.put("PRDLN_CD", mapInfo.get("PRDLN_CD").toString());
													useKwdInfoMap.put("FILE_NM", mapInfo.get("FILE_NM").toString());
													useKwdInfoMap.put("KWD_SPR", kwdSpr);
													useKwdInfoMap.put("APRNC_KWD_NM", kwdNm);
													useKwdInfoMap.put("APRNC_LNPOS", Integer.toString(totLnCnt));
													useKwdInfoMap.put("APRNC_WRDPOS", Integer.toString(i));
													useKwdInfoMap.put("APRNC_TM", lineArray[0].trim());
													//중복검사
													if(!useKwdInfo.contains(useKwdInfoMap)) {
														useKwdInfo.add(useKwdInfoMap);
													}
												}
											}
										}
									}
									totWrdCnt += lnWrdNum;
								}
								totLnCnt++;
							}
						}
						
						for(int i=0; i<kwdLnInfTmp.size(); i++) {
							Map<String, String> kwdLnInfMapTmp = kwdLnInfTmp.get(i);
							Map<String, String> kwdLnInfMap = new HashMap<String, String>();
							
							kwdLnInfMap.put("CLS_CD", mapInfo.get("CLS_CD").toString());
							kwdLnInfMap.put("REQ_DEPT_CD", mapInfo.get("REQ_DEPT_CD").toString());
							kwdLnInfMap.put("FIN_CD", mapInfo.get("FIN_CD").toString());
							kwdLnInfMap.put("SCRTS_NO", mapInfo.get("SCRTS_NO").toString());
							kwdLnInfMap.put("REQ_DT", mapInfo.get("REQ_DT").toString());
							kwdLnInfMap.put("UPL_SPR", mapInfo.get("UPL_SPR").toString());
							kwdLnInfMap.put("SAVE_FILE_NM", mapInfo.get("SAVE_FILE_NM").toString());
							kwdLnInfMap.put("PRDLN_CD", mapInfo.get("PRDLN_CD").toString());
							kwdLnInfMap.put("FILE_NM", mapInfo.get("FILE_NM").toString());
							kwdLnInfMap.put("SNO", kwdLnInfMapTmp.get("SNO"));
							kwdLnInfMap.put("LN_WRDNUM", kwdLnInfMapTmp.get("LN_WRDNUM"));
							kwdLnInfMap.put("TOT_WRDCNT", Integer.toString(totWrdCnt));
							kwdLnInfMap.put("TOT_LNCNT", Integer.toString(totLnCnt));
							kwdLnInf.add(kwdLnInfMap);
						}
					}
				}
				if(br != null) br.close();
				if(fis != null) fis.close();
				if(isr != null) isr.close();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(br != null) br.close();
			if(fis != null) fis.close();
			if(isr != null) isr.close();
		}
				
		Map returnMap = new HashMap();
		returnMap.put("TM_USE_KWD", useKwdInfo);
		returnMap.put("TM_KWD_LNINF", kwdLnInf);
		
		return returnMap;
	}
}
