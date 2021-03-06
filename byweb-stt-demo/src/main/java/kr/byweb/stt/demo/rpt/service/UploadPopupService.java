package kr.byweb.stt.demo.rpt.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.rpt.model.ContractVo;

public interface UploadPopupService {
	public ContractVo getDefInfo(Map pMap) throws Exception;

	public List<ContractVo> getHisList(Map pMap) throws Exception;

	public List<ContractVo> getMismatchList(Map pMap) throws Exception;
}
