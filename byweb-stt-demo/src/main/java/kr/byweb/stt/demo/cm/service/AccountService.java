package kr.byweb.stt.demo.cm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.byweb.stt.demo.cm.mapper.AccountMapper;
import kr.byweb.stt.demo.cm.model.Account;

@Service
public class AccountService implements UserDetailsService{
	
	@Autowired
	private AccountMapper accountMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Account account = null;
		try {
			account = accountMapper.findByUserid(username);
//			account.setAcnt_pw(passwordEncoder.encode(account.getAcnt_pw()));
			System.out.println("loadUserByUsername getAcnt_pw : "+account.getAcnt_pw());
		} catch (Exception e) {
			e.printStackTrace();
		}
//		List<GrantedAuthority> authorities = new ArrayList<>();
//		authorities.add(new SimpleGrantedAuthority(account.getAuth_cd()));
//		return new User(account.getAcnt_id(), account.getAcnt_pw(), authorities);
		return new UserDetailsImpl(account);
	}
	
	public void register(Account account){
		account.setAcnt_pw(passwordEncoder.encode(account.getAcnt_pw()));
		try {
			accountMapper.register(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
