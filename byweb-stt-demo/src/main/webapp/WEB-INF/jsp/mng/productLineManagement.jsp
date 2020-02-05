<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %> --%>
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
</head>
<body>
<div id="wrap">
	<section>
		<c:forEach var="headerTitles" items="${sessionScope.headerTitles}">
			<c:if test="${headerTitles.menu_id eq sessionScope.sel_req_cd}">
				<c:set var="hdTitle" value="${headerTitles.menu_nm}"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-04" />
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
				<li>상품군/상품군코드</li>
				<li>
					<input type="text">
				</li>
			</ul>
		</div>
		<div>
			<div id="btn_top">
				<input type="button" value="행추가" onclick="fn_addRow()">
				<input type="button" value="행삭제" onclick="fn_delRow()">
			</div>
			<table>
				<thead>
					<tr>
						<td>삭제</td>
						<td>권역</td>
						<td>구분</td>
						<td>상품군</td>
						<td>상품군코드</td>
						<td>사용여부</td>
						<td>등록일</td>
						<td>등록자</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td>A보험권역</td>
						<td>생명보험</td>
						<td>정기보험</td>
						<td>00001</td>
						<td>
							<select name="">
								<option value="Y" <%-- <c:if test="${kwdList.use_yn eq 'Y'}">selected</c:if> --%>>Y</option>
								<option value="N" <%-- <c:if test="${kwdList.use_yn eq 'N'}">selected</c:if> --%>>N</option>
							</select>
						</td>
						<td>2020-01-01</td>
						<td>홍길동(A219090)</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
</div>
</body>
</html>