package kr.byweb.stt.demo.cm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.cm.mapper.TmCommonCodeMapper;
import kr.byweb.stt.demo.cm.model.FinanceVo;
import kr.byweb.stt.demo.cm.model.PrdlnMngVo;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.mng.mapper.ProductLineManagementMapper;

@Service
public class TmCommonCodeServiceImpl implements TmCommonCodeService{
	
	@Autowired
	private TmCommonCodeMapper tmCmCdMapper;
	
	@Override
	public List<PrdlnMngVo> getPrdlnList(Map pMap) throws Exception {
		return tmCmCdMapper.getPrdlnList(pMap);
	}
	
	@Override
	public List<TmCmCdVo> getKwdKndCd() throws Exception {
		return tmCmCdMapper.getKwdKndCd();
	}
	
	@Override
	public List<FinanceVo> getReqDeptList(Map pMap) throws Exception {
		return tmCmCdMapper.getReqDeptList(pMap);
	}
	
	
}
