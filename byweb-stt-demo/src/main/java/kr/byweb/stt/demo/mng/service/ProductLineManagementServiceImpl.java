package kr.byweb.stt.demo.mng.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.mng.mapper.ProductLineManagementMapper;

@Service
public class ProductLineManagementServiceImpl implements ProductLineManagementService{
	
	@Autowired
	private ProductLineManagementMapper productLineManagementMapper;
	
//	@Override
//	public List<PrdlnMng> getPrdlnList(Map pMap) throws Exception {
//		return prdlnMngMapper.getPrdlnList(pMap);
//	}

}
