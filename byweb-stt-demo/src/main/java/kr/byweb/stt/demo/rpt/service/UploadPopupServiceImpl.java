package kr.byweb.stt.demo.rpt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rpt.mapper.UploadPopupMapper;
import kr.byweb.stt.demo.rpt.model.ContractVo;

@Service
public class UploadPopupServiceImpl implements UploadPopupService{
	
	@Autowired
	UploadPopupMapper uploadPopupMapper;
	
	@Override
	public ContractVo getDefInfo(Map pMap) throws Exception {
		return uploadPopupMapper.getDefInfo(pMap);
	}

	@Override
	public List<ContractVo> getHisList(Map pMap) throws Exception {
		return uploadPopupMapper.getHisList(pMap);
	}

	@Override
	public List<ContractVo> getMismatchList(Map pMap) throws Exception {
		return uploadPopupMapper.getMismatchList(pMap);
	}
	
}
