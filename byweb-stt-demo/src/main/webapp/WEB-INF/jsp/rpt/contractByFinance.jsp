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

//계약정보 삭제
function fn_delContract(fin_nm, sbm_dt, fin_cd, req_dt){
	//sbm_dt .포맷 변경 필요
	if(confirm('[ '+fin_nm+' / 제출일 : '+sbm_dt+' ]\n해당 행과 모든 데이터를 삭제하시겠습니까?')){
		var frm = document.getElementById("frm_del");
		
		document.getElementById("del_sdate").value = document.getElementById("sdate").value;
		document.getElementById("del_edate").value = document.getElementById("edate").value;
		document.getElementById("del_sel_fin_cd").value = document.getElementById("sel_fin_cd").value;
		document.getElementById("del_fin_cd").value = fin_cd;
		document.getElementById("del_req_dt").value = req_dt;
		
		frm.submit();
	}else{
		return;
	}
}

//녹취파일 업로드 팝업
function fn_openUploadPop(fin_cd, req_dt){
	window.open('','recUplPopup','width=800,height=600,location=no,status=no,scrollbars=no');
	
	var frm_uplPop = document.getElementById("frm_uplPop");
	
	document.getElementById("upl_fin_cd").value = fin_cd;
	document.getElementById("upl_req_dt").value = req_dt;
	
	frm_uplPop.submit();
}

//제출일자 조회조건 유효성 검사
function fn_validDate(obj){
	var sdtVal = fn_onlyNum(document.getElementById("sdate").value);
	var edtVal = fn_onlyNum(document.getElementById("edate").value);
	var objVal = fn_onlyNum(obj.value);
	var date_pattern = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; 
	if(!date_pattern.test(objVal)){
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

//제출일자 입력 시 '-' 자동 입력
function fn_addSlash( event, obj ){
    var num_arr = [ 
        97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    ]
    var key_code = ( event.which ) ? event.which : event.keyCode;
    if( num_arr.indexOf( Number( key_code ) ) != -1 ){
        var len = obj.value.length;
        if( len == 4 ) obj.value += "-";
        if( len == 7 ) obj.value += "-";
    }
}

//엑셀 다운로드
function fn_excel(){
	var frm = document.getElementById("frm_exl");
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
						<fmt:parseDate value="${sdate}" var="sdate_dt" pattern="yyyyMMdd"/>
						<input type="text" id="sdate" name="sdate" <c:if test="${sdate ne ''}">value="<fmt:formatDate value="${sdate_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif">
					</li>
					<li>~</li>
					<li>
						<fmt:parseDate value="${edate}" var="edate_dt" pattern="yyyyMMdd"/>
						<input type="text" id="edate" name="edate" <c:if test="${edate ne ''}">value="<fmt:formatDate value="${edate_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
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
				<fmt:parseDate value="${conList.req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
				<fmt:parseDate value="${conList.sbm_dt}" var="fmt_sbm_dt" pattern="yyyyMMdd"/>
				<tr>
					<td>${conList.fin_nm}</td>
					<td>${conList.sbm_file_nm}</td>
					<td><fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${fmt_sbm_dt}" pattern="yyyy-MM-dd"/></td>
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
		<form id="frm_del" name="frm_del" method="post" action="delContract" target="_self">
			<input type="hidden" id="del_fin_cd" name="fin_cd">
			<input type="hidden" id="del_req_dt" name="req_dt">
			<input type="hidden" id="del_sdate" name="sdate">
			<input type="hidden" id="del_edate" name="edate">
			<input type="hidden" id="del_sel_fin_cd" name="sel_fin_cd">
		</form>
		<form id="frm_uplPop" name="frm_uplPop" method="post" action="getDefInfo" target="recUplPopup">
			<input type="hidden" id="upl_fin_cd" name="fin_cd">
			<input type="hidden" id="upl_req_dt" name="req_dt">
		</form>
		<form id="frm_exl" name="frm_exl" method="post" action="getContract_exl">
			<input type="hidden" id="org_fin_cd" name="org_fin_cd" value="${fin_cd}">
			<input type="hidden" id="org_sdate" name="org_sdate" value="${sdate}">
			<input type="hidden" id="org_edate" name="org_edate" value="${edate}">
		</form>
	</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>