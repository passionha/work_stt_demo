package kr.byweb.stt.demo.cm.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.cm.model.FinanceVo;
import kr.byweb.stt.demo.cm.model.PrdlnMngVo;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;

public interface TmCommonCodeService {
	public List<PrdlnMngVo> getPrdlnList(Map pMap) throws Exception;
	
	public List<TmCmCdVo> getKwdKndCd() throws Exception;
	
	public List<FinanceVo> getReqDeptList(Map pMap) throws Exception;
	
	
}
