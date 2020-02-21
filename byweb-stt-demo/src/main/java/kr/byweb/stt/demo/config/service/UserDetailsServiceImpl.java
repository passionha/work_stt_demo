/*package kr.byweb.stt.demo.config.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.config.mapper.AccountMapper;
import kr.byweb.stt.demo.config.model.Account;
import kr.byweb.stt.demo.config.model.UserDetailsImpl;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
	
	@Autowired
	AccountMapper accountMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Account account = new Account();
		try {
			System.out.println("**************UserDetailsServiceImpl_loadUserByUsername_username : "+username);
			account = accountMapper.findByUserid(username);
			System.out.println("**************UserDetailsServiceImpl_loadUserByUsername account : "+account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (account == null) {
	            throw new UsernameNotFoundException(username);
	    }
		return new UserDetailsImpl(account);
//		return null;
	}
	
	
}
*/