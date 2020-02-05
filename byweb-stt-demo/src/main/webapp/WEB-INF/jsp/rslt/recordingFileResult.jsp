<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	}else if(!obj.value.trim()){
		alert("요청일자를 입력해주세요.");
		obj.focus();
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
		
		<div id="btn_top">
			<input type="button" value="엑셀" onclick="fn_excel()">
			<input type="button" value="저장" onclick="fn_save()">
			<input type="button" value="조회" onclick="fn_search()">
		</div>
		<br>
		<div id="searchBar">
			<ul>
				<li>▶</li>
				<li>회사명</li>
				<li>
					<select id="sel_fin_cd" name="sel_fin_cd">
						<%-- <c:forEach var="finList" items="${finList}" begin="0" step="1">
							<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
						</c:forEach> --%>
					</select>
				</li>
				<li>▶</li>
				<li>요청일자</li>
				<li>
					<fmt:parseDate value="${sdate}" var="fmt_req_dt" pattern="yyyyMMdd"/>
					<input type="text" id="" name="" <%-- <c:if test="${sdate ne ''}">value="<fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/>"</c:if> --%> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
					<img src="/user/images/calendar.gif">
				</li>
				<li>▶</li>
				<li>오류내역</li>
				<li>
					<select id="" name="">
						<%-- <c:forEach var="finList" items="${finList}" begin="0" step="1">
							<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
						</c:forEach> --%>
					</select>
				</li>
			</ul>
		</div>
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
					<tr>
						<td>A보험회사</td>
						<td>기타 일반 종신보험</td>
						<td>ABC0001</td>
						<td>2020-01-01</td>
						<td>테스트_녹취파일.zip</td>
						<td>testRcd_3.wav</td>
						<td>2020-01-01</td>
						<td>녹취파일 8K WAVE 파일로 변환 에러</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
</div>
</body>
</html>