package kr.byweb.stt.demo.cm.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//@EntityScan
public class Account {
	//회원 테이블 : AIAS_MEMBER
	private String acnt_id;
	private String acnt_pw;
	private String emp_no;
	private String emp_nm;
	private String emp_email;
	private String auth_cd;
	private String use_yn;
}
