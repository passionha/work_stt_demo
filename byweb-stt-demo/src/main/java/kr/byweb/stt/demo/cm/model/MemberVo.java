package kr.byweb.stt.demo.cm.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.StringUtils;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//@EqualsAndHashCode(of = "username")
public class MemberVo /* implements UserDetails */{
	//회원 테이블 : AIAS_MEMBER
	private String acnt_id;
	private String acnt_pw;
	private String emp_no;
	private String emp_nm;
	private String emp_email;
	private String auth_cd;
	private String use_yn;
	
	private String username;
	private String authorities;
	private static final long serialVersionUID = 1L;
	
	/*@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List authorityList = new ArrayList<>();
        if (!StringUtils.isEmpty(authorities)) {
            String[] splitedValue = authorities.split(",");
            for (String auth : splitedValue) {
                authorityList.add(new SimpleGrantedAuthority(auth));
            }
        }
        return authorityList;
	}
	@Override
	public String getPassword() {
		return null;
	}
	@Override
	public String getUsername() {
		return this.username;
	}
	@Override
	public boolean isAccountNonExpired() {
		return false;
	}
	@Override
	public boolean isAccountNonLocked() {
		return false;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return false;
	}
	@Override
	public boolean isEnabled() {
		return false;
	}*/
}
