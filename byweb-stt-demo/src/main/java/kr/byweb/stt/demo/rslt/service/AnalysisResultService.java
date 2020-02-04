package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

public interface AnalysisResultService {
	public List<AnlysRsltVo> getUplFileList(Map pMap) throws Exception;

	public List<AnlysRsltVo> getAnlySttsList(Map pMap) throws Exception;

	public List<AnlysRsltVo> getTotalInspectoinList(Map pMap) throws Exception;
}
