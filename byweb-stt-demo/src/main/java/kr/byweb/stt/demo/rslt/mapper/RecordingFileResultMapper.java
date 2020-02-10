package kr.byweb.stt.demo.rslt.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.cm.model.TmCmCdVo;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Mapper
public interface RecordingFileResultMapper {
	public List<AnlysRsltVo> getRecordingFileResultList(Map pMap) throws Exception;
}
