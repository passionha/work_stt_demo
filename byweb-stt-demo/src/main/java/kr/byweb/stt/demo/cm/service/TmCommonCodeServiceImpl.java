package kr.byweb.stt.demo.cm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.cm.mapper.TmCommonCodeMapper;
import kr.byweb.stt.demo.cm.model.TmCmCdVo;

@Service
public class TmCommonCodeServiceImpl implements TmCommonCodeService{
	
	@Autowired
	private TmCommonCodeMapper tmCommonCodeMapper;
	
	@Override
	public List<TmCmCdVo> getPrdlnList(Map pMap) throws Exception {
		return tmCommonCodeMapper.getPrdlnList(pMap);
	}
	
	@Override
	public List<TmCmCdVo> getKwdKndCd() throws Exception {
		return tmCommonCodeMapper.getKwdKndCd();
	}
	
	@Override
	public List<TmCmCdVo> getReqDeptList(Map pMap) throws Exception {
		return tmCommonCodeMapper.getReqDeptList(pMap);
	}

	@Override
	public List<TmCmCdVo> getTitleList() throws Exception {
		return tmCommonCodeMapper.getTitleList();
	}

	@Override
	public List<TmCmCdVo> getNavTitleList(String req_cd) throws Exception {
		return tmCommonCodeMapper.getNavTitleList(req_cd);
	}
	
	
}
