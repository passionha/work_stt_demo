package kr.byweb.stt.demo.rpt.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.rpt.model.ContractVo;

public interface ContractByFinanceService {
	public List<ContractVo> getContractList(Map pMap) throws Exception;

	public List<Map> delContract(Map pMap) throws Exception;
}
