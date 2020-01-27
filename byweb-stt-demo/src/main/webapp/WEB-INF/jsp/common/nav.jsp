<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	nav {
		border: 1px solid #999;
		margin: 5px;
		padding: 10px;
		float: left;
		height: 550px;
		width: 100px;
		color: black;
	}
</style>
</head>
<body>
	<nav>
	<% if(session.getAttribute("req_dept_cd") != null){ %>
		<ul>
			<li><a href="getContractList.do">회사별 제출현황</a></li>
			<br>
			<li><a href="getAnlysStdList.do">분석기준 설정</a></li>
			<br>
			<li><a href="">결과 확인</a></li>
			<br>
			<li><a href="">상품군 관리</a></li>
		</ul>
	<% } %>
	</nav>
</body>
</html>