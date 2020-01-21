package kr.byweb.stt.demo.conf.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data				//@Getter, @Setter, @RequiredArgsConstructor, @ToString, @EqualsAndHashCode 포함
@NoArgsConstructor	//기본생성자 생성
public class AnlysStdVo {
	//분석 기준 테이블 : TM_ANLYS_STD
	private String req_dept_cd;
	private String prdln_cd;
	private String kwd_spr;
	private String scrng_spr;
	private String kwd_nm;
	private String grp_nm;
	private String syn_nm;
	private int rng;
	private int scr;
	private String use_yn;
	private String emp_no;
	private String reg_dt;
	
	//기타 화면 정의 파라미터
//	private BigDecimal rng;		//오라클 Number -> MyBatis의 HashMap 타입
	private String org_scrng_spr;
	private String org_kwd_nm;
	private String user_nm;
	private String chk_del;
	private String chk_sel;
}
