<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%
	List<String> navTitles = (List<String>)session.getAttribute("navTitles");
%>
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
			<c:forEach var="navTitles" items="${navTitles}" begin="0" step="1">
			<c:if test="${navTitles.menu_level == '2'}">
			<li><a href="${navTitles.menu_url}">${navTitles.menu_nm}</a></li>
			<br>
			</c:if>
			</c:forEach>
		</ul>
	<% } %>
	</nav>
</body>
</html>