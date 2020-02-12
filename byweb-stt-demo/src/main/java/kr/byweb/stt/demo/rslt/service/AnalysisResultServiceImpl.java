package kr.byweb.stt.demo.rslt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.rslt.mapper.AnalysisResultMapper;
import kr.byweb.stt.demo.rslt.model.AnlysRsltVo;

@Service
public class AnalysisResultServiceImpl implements AnalysisResultService{
	
	@Autowired
	AnalysisResultMapper analysisResultMapper;
	
	@Override
	public List<AnlysRsltVo> getUplFileList(Map pMap) throws Exception {
		return analysisResultMapper.getUplFileList(pMap);
	}

	@Override
	public List<AnlysRsltVo> getAnlySttsList(Map pMap) throws Exception {
		return analysisResultMapper.getAnlySttsList(pMap);
	}

	@Override
	public List<AnlysRsltVo> getTotalInspectoinList(Map pMap) throws Exception {
		return analysisResultMapper.getTotalInspectoinList(pMap);
	}

	@Override
	public List<AnlysRsltVo> getSttResultList(Map pMap) throws Exception {
		return analysisResultMapper.getSttResultList(pMap);
	}

	@Override
	public List<Map> getRcdflList(Map<String, String> map) throws Exception {
		return analysisResultMapper.getRcdflList(map);
	}

	@Override
	public void updateTmRclflInf(List<Map> setResultFile) throws Exception {
		analysisResultMapper.updateTmRclflInf(setResultFile);
	}

	@Override
	public void deleteTmUseKwd(List<Map> kwdInfo) throws Exception {
		analysisResultMapper.deleteTmUseKwd(kwdInfo);
	}

	@Override
	public void deleteKwdLineInf(List<Map> kwdInfo) throws Exception {
		analysisResultMapper.deleteKwdLineInf(kwdInfo);
	}

	@Override
	public List<Map> getKeywordList(Map mapInfo) throws Exception {
		return analysisResultMapper.getKeywordList(mapInfo);
	}

	@Override
	public void insertTmUseKwd(List<Map> getKeywordInfo) throws Exception {
		analysisResultMapper.insertTmUseKwd(getKeywordInfo);
	}
	
}
