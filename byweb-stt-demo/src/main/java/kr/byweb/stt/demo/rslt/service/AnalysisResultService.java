package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

public interface AnalysisResultService {
	public List<AnlysRsltVo> getUplFileList(Map pMap) throws Exception;

	public List<AnlysRsltVo> getAnlySttsList(Map pMap) throws Exception;

	public List<AnlysRsltVo> getTotalInspectoinList(Map pMap) throws Exception;

	public List<AnlysRsltVo> getSttResultList(Map pMap) throws Exception;

	public List<Map> getRcdflList(Map<String, String> map) throws Exception;

	public void updateTmRclflInf(List<Map> setResultFile) throws Exception;

	public void deleteTmUseKwd(List<Map> kwdInfo) throws Exception;

	public void deleteKwdLineInf(List<Map> kwdInfo) throws Exception;

	public List<Map> getKeywordList(Map mapInfo) throws Exception;

	public void insertTmUseKwd(List<Map> getKeywordInfo) throws Exception;

	public void insertTmKwdLineInf(List<Map> getKeywordLineInfo) throws Exception;

	public void getTmInspcRslt(Map param) throws Exception;
}
