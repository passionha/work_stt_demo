package kr.byweb.stt.demo.conf.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface KeywordManagementMapper {
	public String selectTime() throws Exception;
}
