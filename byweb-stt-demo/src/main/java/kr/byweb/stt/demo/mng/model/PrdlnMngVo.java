package kr.byweb.stt.demo.mng.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class PrdlnMngVo {
	private @NonNull String cls_cd;
	private @NonNull String req_dept_cd;
	private @NonNull String prdln_cd;
	private String prdln_nm;
	private String use_yn;
	private String emp_no;
	private Timestamp reg_dt;
}
