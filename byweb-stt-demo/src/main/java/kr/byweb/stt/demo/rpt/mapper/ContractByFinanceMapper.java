package kr.byweb.stt.demo.rpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rpt.model.ContractVo;

@Mapper
public interface ContractByFinanceMapper {
	public List<ContractVo> getContractList(Map pMap) throws Exception;

	public void deleteContract(Map pMap) throws Exception;

	public void deleteContractMatch(Map pMap) throws Exception;

	public void deleteInspectionResult(Map pMap) throws Exception;

	public void deleteUseKeyword(Map pMap) throws Exception;

	public void deleteKeywordLineInfo(Map pMap) throws Exception;

	public void deleteKeywordResult(Map pMap) throws Exception;

	public void deleteUploadFileInfo(Map pMap) throws Exception;

	public void deleteRecordingFile(Map pMap) throws Exception;

	public List<Map> getDeleteFileList(Map pMap) throws Exception;
}
