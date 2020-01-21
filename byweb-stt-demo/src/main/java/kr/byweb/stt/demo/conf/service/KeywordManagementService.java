package kr.byweb.stt.demo.conf.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.conf.model.AnlysStdVo;

public interface KeywordManagementService {
	public List<AnlysStdVo> getAnalysisStandardList(Map pMap) throws Exception;

	public void insertAnalysisStandard(Map pMap) throws Exception;

	public String getKeywordDuplicationList(Map pMap) throws Exception;

	public List<AnlysStdVo> getSynonymKeywordList(Map pMap) throws Exception;

	public void updateSynonym(Map pMap) throws Exception;
	
}
