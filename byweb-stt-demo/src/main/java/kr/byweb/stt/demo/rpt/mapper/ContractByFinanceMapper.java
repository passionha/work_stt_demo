package kr.byweb.stt.demo.rpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rpt.model.ContractVo;

@Mapper
public interface ContractByFinanceMapper {
	public List<ContractVo> getContractList(Map pMap) throws Exception;

	public void deleteContract(Map pMap);

	public void deleteContractMatch(Map pMap);

	public void deleteInspectionResult(Map pMap);

	public void deleteUseKeyword(Map pMap);

	public void deleteKeywordLineInfo(Map pMap);

	public void deleteKeywordResult(Map pMap);

	public void deleteUploadFileInfo(Map pMap);

	public void deleteRecordingFile(Map pMap);

	public List<Map> getDeleteFileList(Map pMap);
}
