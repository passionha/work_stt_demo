package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

public interface AnalysisResultDetailService {
	public AnlysRsltVo getContractInfo(Map pMap) throws Exception;

	public List<AnlysRsltVo> getInspectionResultList(Map pMap) throws Exception;
}
