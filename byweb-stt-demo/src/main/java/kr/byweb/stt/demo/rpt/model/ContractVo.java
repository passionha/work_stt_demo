package kr.byweb.stt.demo.rpt.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class ContractVo {
	private @NonNull String cls_cd;
	private @NonNull String req_dept_cd;
	private @NonNull String fin_cd;
	private @NonNull String req_dt;
	private String fin_nm;
	private String trns_stts;
	private String anly_st;
	private String file_cnt;
	private String ctt_cnt;
	private String mismatch_cnt;
	private String match_cnt;
	private String match_f_cnt;
	private String sbm_file_nm;
	private String upl_file_nm;
	private String sbm_dt;
	private String reg_dt;
}
