package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rslt.mapper.AnalysisResultMapper;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Service
public class AnalysisResultServiceImpl implements AnalysisResultService{
	
	@Autowired
	AnalysisResultMapper analysisResultMapper;
	
	@Override
	public List<AnlysRsltVo> getUplFileList(Map pMap) throws Exception {
		return analysisResultMapper.getUplFileList(pMap);
	}
	
}
