package kr.byweb.stt.demo.rpt.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rpt.mapper.ContractByFinanceMapper;
import kr.byweb.stt.demo.rpt.model.ContractVo;

@Service
public class ContractByFinanceServiceImpl implements ContractByFinanceService{
	
	@Autowired
	ContractByFinanceMapper contractByFinanceMapper;
	
	@Override
	public List<ContractVo> getContractList(Map pMap) throws Exception {
		return contractByFinanceMapper.getContractList(pMap);
	}

	@Override
	public List<Map> delContract(Map pMap) throws Exception {
		List<Map> files = new ArrayList<Map>();
		files = contractByFinanceMapper.getDeleteFileList(pMap);
		contractByFinanceMapper.deleteContract(pMap);
		contractByFinanceMapper.deleteContractMatch(pMap);
		contractByFinanceMapper.deleteInspectionResult(pMap);
		contractByFinanceMapper.deleteUseKeyword(pMap);
		contractByFinanceMapper.deleteKeywordLineInfo(pMap);
		contractByFinanceMapper.deleteKeywordResult(pMap);
		contractByFinanceMapper.deleteUploadFileInfo(pMap);
		contractByFinanceMapper.deleteRecordingFile(pMap);
		return files;
	}

}
