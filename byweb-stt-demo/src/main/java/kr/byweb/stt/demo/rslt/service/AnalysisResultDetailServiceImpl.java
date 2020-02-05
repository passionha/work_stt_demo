package kr.byweb.stt.demo.rslt.service;

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
	
}
