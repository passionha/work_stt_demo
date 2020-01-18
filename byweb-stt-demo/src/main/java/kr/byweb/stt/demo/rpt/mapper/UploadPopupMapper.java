package kr.byweb.stt.demo.rpt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rpt.model.ContractVo;

@Mapper
public interface UploadPopupMapper {
	public ContractVo getDefInfo(Map pMap) throws Exception;

	public List<ContractVo> getHisList(Map pMap) throws Exception;

	public List<ContractVo> getMismatchList(Map pMap) throws Exception;
}
