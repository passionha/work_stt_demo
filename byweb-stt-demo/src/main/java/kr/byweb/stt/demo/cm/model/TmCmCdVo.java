package kr.byweb.stt.demo.cm.model;


import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class TmCmCdVo {
	private @NonNull String grp_cd;
	private @NonNull String cd;
	private String grp_nm;
	private String cd_nm;
	private int sno;
	private String etc1;
	private String etc2;
	private String etc3;
	private String use_yn;
	private String emp_no;
	private Timestamp reg_dt;
}
