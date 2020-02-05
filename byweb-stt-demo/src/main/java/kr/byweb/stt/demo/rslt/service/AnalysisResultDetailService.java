package kr.byweb.stt.demo.rslt.service;

import java.util.Map;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

public interface AnalysisResultDetailService {
	public AnlysRsltVo getContractInfo(Map pMap) throws Exception;
}
