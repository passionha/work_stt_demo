package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

public interface RecordingFileResultService {
	public List<AnlysRsltVo> getRecordingFileResultList(Map pMap) throws Exception;
}
