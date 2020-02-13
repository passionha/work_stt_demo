package kr.byweb.stt.demo.rslt.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Mapper
public interface AnalysisResultDetailMapper {

	public AnlysRsltVo getContractInfo(Map pMap) throws Exception;

	public List<AnlysRsltVo> getInspectionResultList(Map pMap) throws Exception;

//	public List<AnlysRsltVo> getKwdList(Map pMap) throws Exception;

	public Integer getKwdRsltCnt(Map pMap) throws Exception;

	public ArrayList<Map> getKwdRsltList(Map pMap) throws Exception;

	public List<AnlysRsltVo> getOmissionKeywordList(Map omsnKwdPMap) throws Exception;

	public List<AnlysRsltVo> getRecordingFileList(Map rcdFlPMap) throws Exception;

	public void insertInspectionResult(Map pMap) throws Exception;

	public ArrayList<Map> getRcdFileList(Map fMap) throws Exception;

}
