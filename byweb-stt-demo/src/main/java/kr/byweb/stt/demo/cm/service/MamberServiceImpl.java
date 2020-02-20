package kr.byweb.stt.demo.cm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.cm.mapper.MemberMapper;
import kr.byweb.stt.demo.cm.model.MemberVo;

@Service
public class MamberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public MemberVo authenticate(Map pMap) throws Exception {
		return memberMapper.authenticate(pMap);
	}

}
