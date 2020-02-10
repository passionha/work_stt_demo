package kr.byweb.stt.demo.mng.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
public class PrdlnMngVo {
	//상품군 관리 테이블 : TM_PRDLN_MNG
	private String cls_cd;
	private String req_dept_cd;
	private String prdln_cd;
	private String prdln_nm;
	private String use_yn;
	private String emp_no;
//	private Timestamp reg_dt;
	
	//기타 화면 정의 파라미터
	private String req_dept_nm;
	private String emp_nm;
	private String chk_del;
	private String cls_cd_nm;
	private String reg_dt;
	private List<PrdlnMngVo> prdlnList;
}
