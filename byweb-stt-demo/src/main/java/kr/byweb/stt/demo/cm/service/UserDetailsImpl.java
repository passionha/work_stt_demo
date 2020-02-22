package kr.byweb.stt.demo.cm.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.byweb.stt.demo.cm.model.Account;

public class UserDetailsImpl extends User {
	
	private static final long serialVersionUID = 1L;
	
	//회원 테이블 : AIAS_MEMBER
	private String acnt_id;
	private String acnt_pw;
	private String emp_no;
	private String emp_nm;
	private String emp_email;
	private String auth_cd;
	private String use_yn;
	
	public UserDetailsImpl(Account account) {
		super(account.getAcnt_id(), account.getAcnt_pw(), authorities(account));
		this.acnt_id = account.getAcnt_id();
		this.acnt_pw = account.getAcnt_pw();
		this.emp_no = account.getEmp_no();
		this.emp_nm = account.getEmp_nm();
		this.emp_email = account.getEmp_email();
		this.auth_cd = account.getAuth_cd();
		this.use_yn = account.getUse_yn();
	}

	private static Collection<? extends GrantedAuthority> authorities(Account account) {
		List<GrantedAuthority> authorities = new ArrayList<>();
		//필요 시 일대다, 이늄  처리..
		authorities.add(new SimpleGrantedAuthority(account.getAuth_cd()));
		return authorities;
	}

	public String getAcnt_id() {
		return acnt_id;
	}

	public void setAcnt_id(String acnt_id) {
		this.acnt_id = acnt_id;
	}

	public String getAcnt_pw() {
		return acnt_pw;
	}

	public void setAcnt_pw(String acnt_pw) {
		this.acnt_pw = acnt_pw;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getEmp_nm() {
		return emp_nm;
	}

	public void setEmp_nm(String emp_nm) {
		this.emp_nm = emp_nm;
	}

	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getAuth_cd() {
		return auth_cd;
	}

	public void setAuth_cd(String auth_cd) {
		this.auth_cd = auth_cd;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
}
