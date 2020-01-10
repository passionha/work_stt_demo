package kr.byweb.stt.demo.conf.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data				//@Getter, @Setter, @RequiredArgsConstructor, @ToString, @EqualsAndHashCode 포함
@NoArgsConstructor	//기본생성자 생성
public class AnlysStd {
	private @NonNull String kwd_spr;
	private @NonNull String scrng_spr;
	private @NonNull String kwd_nm;
	private @NonNull String grp_nm;
	private String syn_nm;
	private BigDecimal rng;		//오라클 Number -> MyBatis의 HashMap 타입
	private BigDecimal scr;
	private String use_yn;
	private String emp_no;
	private Timestamp reg_dt;
}
