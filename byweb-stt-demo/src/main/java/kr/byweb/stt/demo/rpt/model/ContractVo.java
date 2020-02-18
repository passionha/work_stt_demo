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
	private String ga_rno;
	private String ga_nm;
	private String rcrt_chnl;
	private String rcrt_sto_nm;
	private String hpycl_scpt_file_nm;
	private String pdesc_scpt_file_nm;
	private String cttor_nm;
	private String ctt_stts_efdt;
	private String ctt_stts;
	private String ctt_dt;
	private String prd_nm;
	private int sno;
	private String prdln_cd;
	private String scrts_no;
//	private Timestamp reg_dt;
	
	//파일업로드 정보 테이블 : TM_FLUPL_INF
//	private String cls_cd;
//	private String req_dept_cd;
//	private String fin_cd;
//	private String req_dt;
	private String upl_spr;
	private String save_file_nm;
//	private String upl_file_nm;
	private String upl_path;
//	private String trns_stts;
	private String req_yn;
	private String emp_no;
//	private Timestamp reg_dt;
	
	//녹취파일 정보 테이블 : TM_RCDFL_INF
//	private String cls_cd;
//	private String req_dept_cd;
//	private String scrts_no;
//	private String fin_cd;
//	private String req_dt;
//	private String upl_spr;
//	private String save_file_nm;
//	private String prdln_cd;
	private String file_nm;
	private String file_path;
	private String sttfile_path;
	private String file_spr;
	private String file_txt;
	private String file_smi;
	private String file_kwd;
//	private String trns_stts;
	private String use_yn;
//	private String emp_no;
//	private Timestamp reg_dt;
	
	//기타 화면 정의 파라미터
	private String reg_dt;
	private String fin_nm;
	private String trns_stts;
	private String anly_st;
	private String file_cnt;
	private String ctt_cnt;
	private String mismatch_cnt;
	private String match_cnt;
	private String match_f_cnt;
	private String upl_file_nm;
	private String reg_dtm;
	private String emp_nm;
	private String rcd_file_nm;
	private String prdln_nm;
	private String scr_spr;
}
