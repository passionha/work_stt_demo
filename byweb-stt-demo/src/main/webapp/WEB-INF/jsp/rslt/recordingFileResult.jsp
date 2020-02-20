<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	#searchBar {
		border-style: solid;
		border-width: 3px;
		border-color: #00b0f0;
	}
	
	input[type="button"] {
		float: right;
	}
	
	table, th, td {
		border: 2px solid lightgrey;
	}
	
	table {
		clear: both;
	}
</style>
<script type="text/javascript">
//요청일자 입력 시 '-' 자동 입력
function fn_addDash( event, obj ){
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

//요청일자 조회조건 유효성 검사
function fn_validDate(obj){
	var objVal = fn_onlyNum(obj.value);
	var date_pattern = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; 
	if(!date_pattern.test(objVal)){
		alert("올바른 일자를 입력해주세요.");
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

//입력 시 yyyy-mm-dd형태로 "-"추가
function fn_addDashDate(str){
	str = str.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	return str;
}

//녹취파일 오류내역 목록 조회
function fn_search(){
	if(document.getElementById("req_dt").value != ""){
		if(fn_validDate(document.getElementById("req_dt"))){
			return;
		}
	}
	var frm = document.getElementById("frm_search_errResult");
	frm.action='/tm/getRecordingFileResultList.do';
	frm.submit();
}

//녹취파일 오류내역 엑셀 다운로드
function fn_excel(){
	$('#org_fin_nm').val($("#sel_fin_cd option:selected").text());
	var frm = document.getElementById("frm_search_errResult");
	frm.action='/tm/getRecordingFileResult_exl.do';
	frm.submit();
}
</script>
</head>
<body>
<div id="wrap">
	<section>
		<div>
			<c:forEach var="headerTitles" items="${sessionScope.headerTitles}">
				<c:if test="${headerTitles.menu_id eq sessionScope.sel_req_cd}">
					<c:set var="hdTitle" value="${headerTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-05" />
			<c:forEach var="navTitles" items="${sessionScope.navTitles}">
				<c:if test="${navTitles.menu_id eq navMenuId}">
					<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<h3>${sectionTitle}</h3>
		</div>
		
		<div id="btn_top">
			<input type="button" value="엑셀" onclick="fn_excel()">
			<input type="button" value="조회" onclick="fn_search()">
		</div>
		<br>
		<form id="frm_search_errResult" method="post">
		<input type="hidden" id="org_fin_cd" name="org_fin_cd" value="${fin_cd}">
		<input type="hidden" id="org_req_dt" name="org_req_dt" value="${req_dt}">
		<input type="hidden" id="org_err_cd" name="org_err_cd" value="${err_cd}">
		<input type="hidden" id="org_fin_nm" name="org_fin_nm">
		<div id="searchBar">
			<ul>
				<li>▶</li>
				<li>회사명</li>
				<li>
					<select id="sel_fin_cd" name="sel_fin_cd">
						<c:forEach var="fList" items="${finList}" begin="0" step="1">
							<option value="${fList.finance_cd}" <c:if test="${fin_cd eq fList.finance_cd}">selected</c:if>>${fList.finance_name}</option>
						</c:forEach>
					</select>
				</li>
				<li>▶</li>
				<li>요청일자</li>
				<li>
					<fmt:parseDate value="${req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
					<input type="text" id="req_dt" name="req_dt" <c:if test="${req_dt ne ''}">value="<fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
					<img src="/user/images/calendar.gif">
				</li>
				<li>▶</li>
				<li>오류내역</li>
				<li>
					<select name="err_cd">
						<c:forEach var="eList" items="${errList}" begin="0" step="1">
							<option value="${eList.cd}" <c:if test="${err_cd eq eList.cd}">selected</c:if>>${eList.cd_nm}</option>
						</c:forEach>
					</select>
				</li>
			</ul>
		</div>
		</form>
		<div>
			<table>
				<thead>
					<tr>
						<td>회사명</td>
						<td>상품군</td>
						<td>증권번호</td>
						<td>요청일</td>
						<td>업로드파일명</td>
						<td>녹취파일명</td>
						<td>파일등록일</td>
						<td>오류내역</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="rList" items="${rcdRsltList}" begin="0" step="1">
					<tr>
						<td>${rList.fin_nm}</td>
						<td>${rList.prdln_nm}</td>
						<td>${rList.scrts_no}</td>
						<fmt:parseDate value="${rList.req_dt}" var="fmt_rList_req_dt" pattern="yyyyMMdd"/>
						<td><fmt:formatDate value="${fmt_rList_req_dt}" pattern="yyyy-MM-dd"/></td>
						<td>${rList.upl_file_nm}</td>
						<td>${rList.file_nm}</td>
						<td>${rList.reg_dt}</td>
						<td>${rList.err_nm}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
</div>
</body>
</html>