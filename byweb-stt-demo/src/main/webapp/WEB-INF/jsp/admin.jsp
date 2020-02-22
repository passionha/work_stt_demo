<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	관리자 페이지입니다.<br>
	<sec:authentication property="principal"/><br>
	ID : <sec:authentication property="principal.username"/><br>
	'<sec:authentication property="principal.emp_nm"/>'님 안녕하세요 !<br>
	
	 <sec:authorize access="isAnonymous()">
		<br> 로그아웃 중입니다.
	 </sec:authorize>
	 <sec:authorize access="isAuthenticated()">
	 	<br> 로그인 중입니다. 
	 </sec:authorize>
	
	<form action="/logout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" value="로그아웃">
	</form>

</body>
</html>