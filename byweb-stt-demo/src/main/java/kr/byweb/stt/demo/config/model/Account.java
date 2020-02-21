package kr.byweb.stt.demo.config.model;

import org.springframework.boot.autoconfigure.domain.EntityScan;

import lombok.Data;
import lombok.NoArgsConstructor;

@EntityScan
@Data
@NoArgsConstructor
public class Account {
	//회원 테이블 : AIAS_MEMBER
	private String acnt_id;
	private String acnt_pw;
	private String emp_no;
	private String emp_nm;
	private String emp_email;
	private String auth_cd;
	private String use_yn;

	// 이 부분은 나중에 enum 과 일대다로 빼든 지 하는 작업이 필요할 것으로 보임. 
//	private String user_role;
}
