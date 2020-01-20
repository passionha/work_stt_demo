package kr.byweb.stt.demo.conf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.conf.mapper.KeywordManagementMapper;
import kr.byweb.stt.demo.conf.model.AnlysStdVo;

@Service
public class KeywordManagementServiceImpl implements KeywordManagementService{
	
	@Autowired
	private KeywordManagementMapper keywordManagementMapper;

	@Override
	public List<AnlysStdVo> getAnalysisStandardList(Map pMap) throws Exception {
		return keywordManagementMapper.getAnalysisStandardList(pMap);
	}

	@Override
	public void insertAnalysisStandard(Map pMap) throws Exception {
		keywordManagementMapper.insertAnalysisStandard(pMap);
	}

	@Override
	public String getKeywordDuplicationList(Map pMap) throws Exception {
		return keywordManagementMapper.getKeywordDuplicationList(pMap);
	}
	
	
}
