package kr.byweb.stt.demo.rslt.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rslt.mapper.AnalysisResultDetailMapper;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Service
public class AnalysisResultDetailServiceImpl implements AnalysisResultDetailService{
	
	@Autowired
	AnalysisResultDetailMapper analysisResultDetailMapper;

	@Override
	public AnlysRsltVo getContractInfo(Map pMap) throws Exception {
		return analysisResultDetailMapper.getContractInfo(pMap);
	}

	@Override
	public List<AnlysRsltVo> getInspectionResultList(Map pMap) throws Exception {
		return analysisResultDetailMapper.getInspectionResultList(pMap);
	}

//	@Override
//	public List<AnlysRsltVo> getKwdList(Map pMap) throws Exception {
//		return analysisResultDetailMapper.getKwdList(pMap);
//	}

	@Override
	public Integer getKwdRsltCnt(Map pMap) throws Exception {
		return analysisResultDetailMapper.getKwdRsltCnt(pMap);
	}

	@Override
	public ArrayList<Map> getKwdRsltList(Map pMap) throws Exception {
		return analysisResultDetailMapper.getKwdRsltList(pMap);
	}

	@Override
	public List<AnlysRsltVo> getOmissionKeywordList(Map omsnKwdPMap) throws Exception {
		return analysisResultDetailMapper.getOmissionKeywordList(omsnKwdPMap);
	}

	@Override
	public List<AnlysRsltVo> getRecordingFileList(Map rcdFlPMap) throws Exception {
		return analysisResultDetailMapper.getRecordingFileList(rcdFlPMap);
	}

	@Override
	public void insertInspectionResult(Map pMap) throws Exception {
		analysisResultDetailMapper.insertInspectionResult(pMap);
	}
	
}
