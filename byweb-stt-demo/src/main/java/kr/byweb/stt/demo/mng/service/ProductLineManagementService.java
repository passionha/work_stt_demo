package kr.byweb.stt.demo.mng.service;

import java.util.List;
import java.util.Map;

import kr.byweb.stt.demo.mng.model.PrdlnMngVo;

public interface ProductLineManagementService {
	public List<PrdlnMngVo> getProductList(Map pMap) throws Exception;
}
