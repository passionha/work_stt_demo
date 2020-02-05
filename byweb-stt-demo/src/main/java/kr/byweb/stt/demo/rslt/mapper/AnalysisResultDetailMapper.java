package kr.byweb.stt.demo.rslt.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Mapper
public interface AnalysisResultDetailMapper {

	public AnlysRsltVo getContractInfo(Map pMap) throws Exception;

}
