package kr.byweb.stt.demo.cm.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.cm.mapper.MemberMapper;
import kr.byweb.stt.demo.cm.model.MemberVo;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public MemberVo authenticate(Map pMap) throws Exception {
		return memberMapper.authenticate(pMap);
	}
	
}
