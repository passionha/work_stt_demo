package kr.byweb.stt.demo.conf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.conf.mapper.KeywordManagementMapper;

@Service
public class KeywordManagementServiceImpl implements KeywordManagementService{
	
	@Autowired
	private KeywordManagementMapper keywordManagementMapper;
	
	@Override
	public String selectTime() throws Exception {
		return keywordManagementMapper.selectTime();
	}
	
}
