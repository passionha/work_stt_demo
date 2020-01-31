package kr.byweb.stt.demo.rpt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rpt.mapper.ContractByFinanceDetailMapper;
import kr.byweb.stt.demo.rpt.model.ContractVo;

@Service
public class ContractByFinanceDetailServiceImpl implements ContractByFinanceDetailService{
	
	@Autowired
	ContractByFinanceDetailMapper contractByFinanceDetailMapper;
	
	@Override
	public List<ContractVo> getContractDetailList(Map pMap) throws Exception {
		return contractByFinanceDetailMapper.getContractDetailList(pMap);
	}

	@Override
	public void setAnalysisAll(Map pMap) throws Exception {
		contractByFinanceDetailMapper.updateAnalysisUploadFile(pMap);
		contractByFinanceDetailMapper.updateAnalysisRecordingFile(pMap);
	}
	
}
