package kr.byweb.stt.demo.rslt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Mapper
public interface AnalysisResultMapper {
	public List<AnlysRsltVo> getUplFileList(Map pMap) throws Exception;

}
