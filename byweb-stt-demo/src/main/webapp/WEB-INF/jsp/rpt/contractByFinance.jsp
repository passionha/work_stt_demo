<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사별 제출현황</title>
<style type="text/css">
	body {
		text-align: center;
		color: black;
		width: 1400px;
	}

	#wrapper {
		width: 100%;
		text-align: left;
		min-height: 300px;
		margin: 0 auto;
	}
	
	section {
		border: 1px solid #999;
		margin: 5px;
		padding: 10px;
		float: left;
		height: 550px;
		width: 1235px;
	}
	
	li {
		display: inline;
	}
	
	li:nth-child(2), :nth-child(5) {
		padding-right: 5px;
	}
	
	li:nth-child(3) {
		padding-right: 100px;
	}
	
	#searchBar {
		border-style: solid;
		border-width: 3px;
		border-color: #00b0f0;
	}
	
	#tbl_sbmList th, td, input {
		text-align: center;
	}
	
	#btn_top input {
		float: right;
		margin-bottom: 10px;
	}
</style>
<script type="text/javascript">
//조회조건 유효성 검사 및 submit
function fn_search(){
	if(fn_validDate(document.getElementById("sdate"))){
		return;
	}
	if(fn_validDate(document.getElementById("edate"))){
		return;
	}
	
	frm.submit();
}

function fn_delContract(fin_nm, sbm_dt, fin_cd, req_dt){
	//sbm_dt .포맷 변경 필요
	if(confirm('[ '+fin_nm+' / 제출일 : '+sbm_dt+' ]\n해당 행과 모든 데이터를 삭제하시겠습니까?')){
// 		var frm = document.createElement('form');
		var frm = document.getElementById("frm");
		
		frm.name = 'newFrm';
		frm.method = 'post';
		frm.action = 'delContract';
		frm.target = '_self';
		
		var ipt_fin_cd = document.createElement('input');
		var ipt_req_dt = document.createElement('input');
		
		ipt_fin_cd.setAttribute("type", "hidden");
		ipt_fin_cd.setAttribute("name", "fin_cd");
		ipt_fin_cd.setAttribute("value", fin_cd);
		
		ipt_req_dt.setAttribute("type", "hidden");
		ipt_req_dt.setAttribute("name", "req_dt");
		ipt_req_dt.setAttribute("value", req_dt);
		
		frm.appendChild(ipt_fin_cd);
		frm.appendChild(ipt_req_dt);
		
		document.body.appendChild(frm);
		
		frm.submit();
	}else{
		return;
	}
}

function fn_openUploadPop(fin_cd, req_dt){
	window.open('','recUplPopup','width=800,height=600,location=no,status=no,scrollbars=no');
	
	var frm_uplPop = document.createElement('form');
	
	frm_uplPop.name = 'frm_uplPop';
	frm_uplPop.method = 'post';
	frm_uplPop.action = 'getDefInfo';
	frm_uplPop.target = 'recUplPopup';
	
	var ipt_fin_cd = document.createElement('input');
	var ipt_req_dt = document.createElement('input');
	
	ipt_fin_cd.setAttribute("type", "hidden");
	ipt_fin_cd.setAttribute("name", "fin_cd");
	ipt_fin_cd.setAttribute("value", fin_cd);
	
	ipt_req_dt.setAttribute("type", "hidden");
	ipt_req_dt.setAttribute("name", "req_dt");
	ipt_req_dt.setAttribute("value", req_dt);
	
	frm_uplPop.appendChild(ipt_fin_cd);
	frm_uplPop.appendChild(ipt_req_dt);
	
	document.body.appendChild(frm_uplPop);
	
	frm_uplPop.submit();
}

//제출일자 조회조건 유효성 검사
function fn_validDate(obj){
	var sdtVal = fn_onlyNum(document.getElementById("sdate").value);
	var edtVal = fn_onlyNum(document.getElementById("edate").value);
	var objVal = fn_onlyNum(obj.value);
	
	var checkLength = /^\d{8}$/;
	if(!checkLength.test(objVal)){
		alert("올바른 일자를 입력해주세요.");
		obj.focus();
	}else if(!obj.value.trim() && obj.value == document.getElementById("sdate").value){
		alert("시작일자를 입력해주세요.");
		obj.focus();
	}else if(!obj.value.trim() && obj.value == document.getElementById("edate").value){
		alert("종료일자를 입력해주세요.");
		obj.focus();
	}else if(objVal == edtVal && edtVal < sdtVal){
		alert("시작일자 이후의 종료일자를 입력해주세요.");
		obj.focus();
	}else if(objVal == sdtVal && sdtVal > edtVal){
		alert("종료일자 이전의 시작일자를 입력해주세요.");
		obj.focus();
	}else{
		return false;
	}
	return true;
}

//숫자만 추출
function fn_onlyNum(value) {
    return value.replace(/[^0-9]/g,"");
}

//엑셀 다운로드
function fn_excel(){
	var frm = document.getElementById("frm");
	frm.action = 'getContract_exl';
	frm.submit();
}
</script>
</head>
<body>
<div id="wrapper">
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/nav.jsp" %>
	<section>
		<h3>회사별 제출현황</h3>
		<form id="frm" action="getContractList" method="post">
			<div id="btn_top">
				<input type="button" value="엑셀" onclick="fn_excel()">
				<input type="button" value="조회" onclick="fn_search()">
			</div>
			<br>
			<input type="hidden" id="org_fin_cd" name="org_fin_cd" value="${fin_cd}">
			<input type="hidden" id="org_sdate" name="org_sdate" value="${sdate}">
			<input type="hidden" id="org_edate" name="org_edate" value="${edate}">
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="sel_fin_cd">
							<c:forEach var="finList" items="${finList}" begin="0" step="1">
								<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
							</c:forEach>
						</select>
					</li>
					<li>▶</li>
					<li>제출일자</li>
					<li>
						<input type="text" id="sdate" name="sdate" <c:if test="${sdate ne ''}">value="${sdate}"</c:if>>
						<img src="/user/images/calendar.gif">
					</li>
					<li>~</li>
					<li>
						<input type="text" id="edate" name="edate" <c:if test="${edate ne ''}">value="${edate}"</c:if>>
						<img src="/user/images/calendar.gif">
					</li>
				</ul>
			</div>
		</form>
		<table id="tbl_sbmList" border="1">
			<thead>
				<tr>
					<th>회사명</th>
					<th>제출파일명</th>
					<th>요청일자</th>
					<th>제출일자</th>
					<th>업로드파일명</th>
					<th>계약건수</th>
					<th>녹취파일건수</th>
					<th>비매칭건수</th>
					<th>녹취파일 업로드</th>
					<th>STT진행상태</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="conList" items="${conList}" begin="0" step="1">
				<tr>
					<td>${conList.fin_nm}</td>
					<td>${conList.sbm_file_nm}</td>
					<td>${conList.req_dt}</td>
					<td>${conList.sbm_dt}</td>
					<td>${conList.upl_file_nm}</td>
					<td>${conList.ctt_cnt}</td>
					<td>${conList.file_cnt}</td>
					<td>${conList.mismatch_cnt}</td>
					<td><input type="button" value="업로드" onclick="fn_openUploadPop('${conList.fin_cd}', '${conList.req_dt}')"></td>
					<td>${conList.anly_st}</td>
					<td><input type="button" value="삭제" onclick="fn_delContract('${conList.fin_nm}', '${conList.sbm_dt}', '${conList.fin_cd}', '${conList.req_dt}')"></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>