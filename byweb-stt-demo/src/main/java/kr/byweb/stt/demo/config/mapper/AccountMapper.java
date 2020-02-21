package kr.byweb.stt.demo.config.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.byweb.stt.demo.config.model.Account;

@Mapper
public interface AccountMapper {
	public Account findMe() throws Exception;

	public Account findByUserid(String user_id) throws Exception;

	public void saveAccount(Account account)  throws Exception;
}
