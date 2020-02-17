package kr.byweb.stt.demo.conf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.conf.model.AnlysStdVo;

@Mapper
public interface KeywordManagementMapper {
	public List<AnlysStdVo> getAnalysisStandardList(Map pMap) throws Exception;

	public void insertAnalysisStandard(Map pMap) throws Exception;

	public String getKeywordDuplicationList(Map pMap) throws Exception;

	public List<AnlysStdVo> getSynonymKeywordList(Map pMap) throws Exception;

	public void updateSynonym(Map pMap) throws Exception;

	public void updateAnalysisStandard(Map pMap) throws Exception;

	public void deleteAnalysisStandard(Map pMap) throws Exception;

	public void updateDelSynonym(Map pMap) throws Exception;

	public Integer getSynonymDup(Map pMap) throws Exception;
}
