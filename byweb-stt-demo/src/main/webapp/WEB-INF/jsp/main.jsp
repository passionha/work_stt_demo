<%-- <%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body {
		text-align: center;
		color: black;
		width: 1400px;
	}

	div#wrapper {
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
/* 		background-color: green; */
		width: 1235px; 
	}
</style>
</head>
<body>
<%
	String req_dept_cd = session.getAttribute("req_dept_cd") == null ? "" : (String)session.getAttribute("req_dept_cd");
	String localUrl = request.getServletPath().toString();
	String iPage = localUrl.substring(localUrl.lastIndexOf("/WEB-INF/jsp/")+13);
%>
<div id="wrapper">
	<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/jsp/common/nav.jsp"></jsp:include>
<%-- <%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/nav.jsp" %> --%>
	<section>
		<p><%=localUrl %></p>
		<p><%=iPage %></p>
		<article>
			<p>Main Page.</p>
			<p>Select Header</p>
			<p>localUrl : <%= localUrl%></p>
			<p>iPage : <%= iPage%></p>
			<p>req_dept_cd : <%= req_dept_cd%></p>
		</article>
	</section>
	<jsp:include page="/WEB-INF/jsp/common/footer.jsp"></jsp:include>
<%-- <%@ include file="/WEB-INF/jsp/common/footer.jsp" %> --%>
</div>
</body>
</html>