package kr.byweb.stt.demo.cm.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoginForm {
	private String acnt_id;
	private String acnt_pw;
}
