package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rslt.mapper.RecordingFileResultMapper;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Service
public class RecordingFileResultServiceImpl implements RecordingFileResultService{
	
	@Autowired
	RecordingFileResultMapper recordingFileResultMapper;

	@Override
	public List<AnlysRsltVo> getRecordingFileResultList(Map pMap) throws Exception {
		return recordingFileResultMapper.getRecordingFileResultList(pMap);
	}
}
