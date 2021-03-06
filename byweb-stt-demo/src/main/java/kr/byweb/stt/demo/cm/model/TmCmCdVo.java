package kr.byweb.stt.demo.cm.model;


import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class TmCmCdVo implements Serializable {
	
	//공통코드 테이블 : TM_CD_INF
	private String grp_cd;
	private String cd;
	private String grp_nm;
	private String cd_nm;
	private int sno;
	private String etc1;
	private String etc2;
	private String etc3;
	private String use_yn;
	private String emp_no;
	private Timestamp reg_dt;
	
	//회사정보 테이블 : RR_FINANCE
	private String class_cd;
	private String finance_cd;
	private String finance_name;
	private String busi_strt_day;
	private String busi_end_day;
	
	//상품군 관리 테이블 : TM_PRDLN_MNG
	private String cls_cd;
	private String req_dept_cd;
	private String prdln_cd;
	private String prdln_nm;
//	private String use_yn;
//	private String emp_no;
//	private Timestamp reg_dt;
	
	//메뉴 관리 테이블 : TM_MENU_MNG
	private String menu_id;
	private String menu_nm;
	private String menu_url;
	private int menu_level;
//	private String use_yn;
	private String menu_target;
	private String upper_menu_id;
	private String menu_desc;
	   
	//기타 화면 정의 파라미터
	private String class_name;
}
