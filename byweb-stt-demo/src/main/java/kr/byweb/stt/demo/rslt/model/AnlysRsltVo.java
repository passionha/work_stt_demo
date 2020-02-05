package kr.byweb.stt.demo.rslt.model;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AnlysRsltVo {
	//파일업로드 정보 테이블 : TM_FLUPL_INF
	private String cls_cd;
	private String req_dept_cd;
	private String fin_cd;
	private String req_dt;
	private String upl_spr;
	private String save_file_nm;
	private String upl_file_nm;
	private String upl_path;
	private String trns_stts;
	private String req_yn;
	private String emp_no;
//	private Timestamp reg_dt;
	
	//검수 결과 테이블 : TM_INSPC_RSLT
//	private String cls_cd;
//	private String req_dept_cd;
//	private String fin_cd;
	private String scrts_no;
//	private String req_dt;
	private String prdln_cd;
	private String inspc_spr;
	private int scr;
	private int esn_kwd_num;
	private int esn_kwd_scr;
	private int bnwd_cnt;
	private int bnwd_scr;
	private int omsn_kwd_num;
	private String missell_yn;
//	private String emp_no;
//	private Timestamp reg_dt;
	
	//키워드 라인정보 테이블 : TM_KWD_LNINF
//	private String cls_cd;
//	private String req_dept_cd;
//	private String fin_cd;
//	private String scrts_no;
//	private String req_dt;
//	private String upl_spr;
//	private String save_file_nm;
//	private String prdln_cd;
	private String file_nm;
	private int sno;
	private int tot_lncnt;
	private int tot_wrdcnt;
	private int ln_wrdnum;
//	private Timestamp reg_dt;
	
	//키워드 결과 테이블 : TM_KWD_RSLT
//	private String cls_cd;
//	private String req_dept_cd;
//	private String fin_cd;
//	private String scrts_no;
//	private String req_dt;
//	private String inspc_spr;
//	private String prdln_cd;
//	private String save_file_nm;
	private String rcd_file_nm;
	private String kwd_spr;
	private String scrng_spr;
	private String kwd_nm;
	private int aprnc_tm;
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
//	private String file_nm;
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
	
	//사용 키워드 테이블 : TM_USE_KWD
//	private String cls_cd;
//	private String req_dept_cd;
//	private String fin_cd;
//	private String scrts_no;
//	private String req_dt;
//	private String upl_spr;
//	private String save_file_nm;
//	private String prdln_cd;
//	private String file_nm;
//	private String kwd_spr;
	private String aprnc_kwd_nm;
	private int aprnc_lnpos;
	private int aprnc_wrdpos;
//	private int aprnc_tm;
//	private Timestamp reg_dt;
	   
	//기타 화면 정의 파라미터
	private String reg_dt;
	private String chk;
	private String up_fin_cd;
	private String org_fin_cd;
	private String fin_nm;
	private String node_nm;
	private String trns_stts_nm;
	private String lv;
	private String col_img_idx;
	private String expn_img_idx;
	private String is_leaf;
	private String prdln_nm;
	private String auto_avg;
	private String manual_avg;
	private String chk_sel;
	private String cttor_nm;
	private String ctt_stts;
	private String ctt_dt;
	private String prd_nm;
	private String auto_scr;
	private String manual_scr;
	private String[] arr_save_file_nm;
	private List<AnlysRsltVo> anlysRsltVos;
	
}
