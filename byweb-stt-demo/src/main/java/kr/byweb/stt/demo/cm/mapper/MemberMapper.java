package kr.byweb.stt.demo.cm.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.cm.model.MemberVo;

@Mapper
public interface MemberMapper {

	public MemberVo authenticate(Map pMap) throws Exception;
	
}