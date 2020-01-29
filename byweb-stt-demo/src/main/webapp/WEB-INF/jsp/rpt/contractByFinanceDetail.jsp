<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, kr.byweb.stt.demo.cm.model.*" %>
<%
	String sectionTitle = "";
	String sel_req_cd = (String)session.getAttribute("sel_req_cd");
	String contentPage = (String)request.getAttribute("contentPage");
	List<TmCmCdVo> headerTitles = (List<TmCmCdVo>)session.getAttribute("headerTitles");
	List<TmCmCdVo> navTitles = (List<TmCmCdVo>)session.getAttribute("navTitles");
	
	Iterator<TmCmCdVo> hdIt = headerTitles.iterator();
	TmCmCdVo hdTitleInfo;
	while(hdIt.hasNext()){
		hdTitleInfo = hdIt.next();
		if(hdTitleInfo.getMenu_id().equals(sel_req_cd)){
			sectionTitle = hdTitleInfo.getMenu_nm().toString();
		}
	}
	Iterator<TmCmCdVo> navIt = navTitles.iterator();
	TmCmCdVo navTitleInfo;
	while(navIt.hasNext()){
		navTitleInfo = navIt.next();
		if(navTitleInfo.getMenu_id().equals(sel_req_cd+"-01-01")){
			sectionTitle += " > "+navTitleInfo.getMenu_nm().toString();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>녹취파일 계약정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	body {
		color: black;
		width: 1400px;
	}

	#wrap {
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
	
	#wrap li {
		display: inline;
	}
	
	#wrap li:nth-child(2), :nth-child(5) {
		padding-right: 5px;
	}
	
	#wrap li:nth-child(3) {
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
	/*if(fn_validDate(document.getElementById("sdate"))){
		return;
	}
	if(fn_validDate(document.getElementById("edate"))){
		return;
	}*/
	var idx = $("#sel_fin_cd option").index( $("#sel_fin_cd option:selected") );
	document.getElementById("det_cls_cd").value = $('input[name="fin_cls_cd"]').eq(idx).val();
	var frm = document.getElementById("frm");
	frm.submit();
}

//계약일자 조회조건 유효성 검사
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
</script>
</head>
<body>
<div id="wrap">
	<section>
		<h3><%=sectionTitle%></h3>
		<form id="frm" action="getContractDetailList.do" method="post">
			<input type="hidden" id="det_cls_cd" name="det_cls_cd">
			<div id="btn_top">
				<input type="button" value="녹취파일변환" onclick="">
				<input type="button" value="엑셀" onclick="fn_excel()">
				<input type="button" value="조회" onclick="fn_search()">
			</div>
			<br>
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="fin_cd">
							<c:forEach var="finList" items="${finList}" begin="0" step="1">
								<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
							</c:forEach>
						</select>
						<c:forEach var="finList" items="${finList}" begin="0" step="1">
							<input type="hidden" name="fin_cls_cd" value="${finList.class_cd}">
						</c:forEach>
					</li>
					
					<li>▶</li>
					<li>요청일</li>
					<li>
						<input type="text" name="req_dt" value="${req_dt}" readonly>
					</li>
					<br>
					<li>▶</li>
					<li>상품군</li>
					<li>
						<select id="sel_prdln_cd" name="prdln_cd">
							<c:forEach var="prdList" items="${prdList}" begin="0" step="1">
							<c:if test="${prdList.prdln_cd != 'SEL'}">
								<option value="${prdList.prdln_cd}" <c:if test="${prdln_cd eq prdList.prdln_cd}">selected</c:if>>${prdList.prdln_nm}</option>
							</c:if>
							</c:forEach>
						</select>
					</li>
					
					<li>▶</li>
					<li>증권번호</li>
					<li>
						<input type="text" id="scrts_no" name="scrts_no">
					</li>
					
					<li>▶</li>
					<li>계약일</li>
					<li>
						<fmt:parseDate value="${ctt_sdate}" var="sdate_dt" pattern="yyyyMMdd"/>
						<input type="text" id="sdate" name="ctt_sdate" <c:if test="${ctt_sdate ne ''}">value="<fmt:formatDate value="${sdate_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif">
					</li>
					<li>~</li>
					<li>
						<fmt:parseDate value="${ctt_edate}" var="edate_dt" pattern="yyyyMMdd"/>
						<input type="text" id="edate" name="ctt_edate" <c:if test="${ctt_edate ne ''}">value="<fmt:formatDate value="${edate_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif">
					</li>
				</ul>
			</div>
		</form>
		<table id="tbl_sbmList" border="1">
			<thead>
				<tr>
					<th>회사명</th>
					<th>상품군</th>
					<th>증권번호</th>
					<th>상품명</th>
					<th>계약일</th>
					<th>계약상태</th>
					<th>계약상태발생일</th>
					<th>계약자명</th>
					<th>대리점명</th>
					<th>대리점등록번호</th>
					<th>모집점포명</th>
					<th>모집채널</th>
					<th>STT진행상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="conList" items="${conList}" begin="0" step="1">
				<fmt:parseDate value="${conList.ctt_stts_efdt}" var="fmt_ctt_stts_efdt" pattern="yyyyMMdd"/>
				<tr>
					<td>${conList.fin_nm}</td>
					<td>${conList.prdln_nm}</td>
					<td>${conList.scrts_no}</td>
					<td>${conList.prd_nm}</td>
					<td>${conList.ctt_dt}</td>
					<td>${conList.ctt_stts}</td>
					<td><fmt:formatDate value="${fmt_ctt_stts_efdt}" pattern="yyyy-MM-dd"/></td>
					<td>${conList.cttor_nm}</td>
					<td>${conList.ga_nm}</td>
					<td>${conList.ga_rno}</td>
					<td>${conList.rcrt_sto_nm}</td>
					<td>${conList.rcrt_chnl}</td>
					<td>${conList.anly_st}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>
</div>
</body>
</html>