package kr.byweb.stt.demo.cm.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.cm.model.Account;

@Mapper
public interface AccountMapper {
	public Account findByUserid(String username) throws Exception;

	public void register(Account account)  throws Exception;
}
