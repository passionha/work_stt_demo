package kr.byweb.stt.demo.rpt.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class ContractVo {
	
	//계약정보 테이블 : RR_TM001
	private String cls_cd;
	private String req_dept_cd;
	private String fin_cd;
	private String req_dt;
	private String sbm_file_nm;
	private String sbm_dt;
	private String reg_dt;
//	private String ga_rno;
//	private String ga_nm;
//	private String rcrt_chnl;
//	private String rcrt_sto_nm;
//	private String hpycl_scpt_file_nm;
//	private String pdesc_scpt_file_nm;
//	private String cttor_nm;
//	private String ctt_stts_efdt;
//	private String ctt_stts;
//	private String ctt_dt;
//	private String prd_nm;
//	private int sno;
//	private String prdln_cd;
//	private String scrts_no;
	
	//기타 화면 정의 파라미터
	private String fin_nm;
	private String trns_stts;
	private String anly_st;
	private String file_cnt;
	private String ctt_cnt;
	private String mismatch_cnt;
	private String match_cnt;
	private String match_f_cnt;
	private String upl_file_nm;
}
