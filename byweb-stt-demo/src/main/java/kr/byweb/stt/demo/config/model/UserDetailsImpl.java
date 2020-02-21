package kr.byweb.stt.demo.config.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class UserDetailsImpl extends User {
	private String nick;
	public String getNick() { return nick;}
	public void setNick(String nick) {this.nick = nick; }
	
	public UserDetailsImpl(Account account) {
		super(account.getAcnt_id(), account.getAcnt_pw(), authorities(account));
		this.nick = account.getEmp_nm();
	}

	private static Collection<? extends GrantedAuthority> authorities(Account account) {
		List<GrantedAuthority> authorities = new ArrayList<>();
		// 원래 일대다, 이늄을 하는 식으로 해서 처리를 해야 할 것같지만
		authorities.add(new SimpleGrantedAuthority(account.getAuth_cd()));
		return authorities;
	}
}
