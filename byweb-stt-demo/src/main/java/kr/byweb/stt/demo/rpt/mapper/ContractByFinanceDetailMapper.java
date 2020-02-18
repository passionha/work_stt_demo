package kr.byweb.stt.demo.rpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rpt.model.ContractVo;

@Mapper
public interface ContractByFinanceDetailMapper {
	public List<ContractVo> getContractDetailList(Map pMap) throws Exception;

	public void updateAnalysisUploadFile(Map pMap) throws Exception;

	public void updateAnalysisRecordingFile(Map pMap) throws Exception;

	public ContractVo getScriptFileInfo(Map pMap) throws Exception;
	
}
