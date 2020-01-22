package kr.byweb.stt.demo.cm.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;

public interface TmCommonCodeService {
	public List<TmCmCdVo> getPrdlnList(Map pMap) throws Exception;
	
	public List<TmCmCdVo> getKwdKndCd() throws Exception;
	
	public List<TmCmCdVo> getReqDeptList(Map pMap) throws Exception;

	public List<TmCmCdVo> getTitleList() throws Exception;
	
	
}
