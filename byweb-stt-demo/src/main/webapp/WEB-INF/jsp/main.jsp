<%-- <%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</style>
</head>
<body>
<div id="wrap">
	<div id="header">
		<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
	</div>
	<div id="nav">
		<jsp:include page="/WEB-INF/jsp/common/nav.jsp"></jsp:include>
	</div>
	<div id="section">
			<c:set var="contPage" value="/WEB-INF/jsp/${requestScope.contentPage}.jsp" />
			<jsp:include page="${requestScope.contentPage eq null || sessionScope.req_dept_cd eq null ? 'common/mainSection.jsp' : contPage}"></jsp:include>
	</div>
	<div id="footer">
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp"></jsp:include>
	</div>
</div>
</body>
</html>