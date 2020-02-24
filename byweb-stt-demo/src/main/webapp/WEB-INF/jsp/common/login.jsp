<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:url value="/login" var="loginUrl"/>
<%-- 	<c:url value="/cm/main.do" var="loginUrl"/> --%>
	       
		<c:if test="${param.error != null}">        
			<p>
				Invalid username and password.
			</p>
		</c:if>
		<c:if test="${param.logout != null}">       
			<p>
				You have been logged out.
			</p>
		</c:if>

		 <sec:authorize access="isAnonymous()">
		 	<form action="${loginUrl}" method="post">
		 	<p>
				<label for="username">Username</label>
				<input type="text" id="acnt_id" name="acnt_id"/>
			</p>
			<p>
				<label for="password">Password</label>
				<input type="password" id="acnt_pw" name="acnt_pw"/>
			</p>
			<%-- <input type="hidden"                        
			name="${_csrf.parameterName}"
			value="${_csrf.token}"/> --%>
			<sec:csrfInput />
			<button type="submit" class="btn">Log in</button>
			</form>
		 	<a href="/registerForm">회원가입 페이지로 이동</a><br>
		 </sec:authorize>
		 <sec:authorize access="isAuthenticated()">
		 	<sec:authentication property="principal"/><br>
			ID : <sec:authentication property="principal.username"/><br>
			'<sec:authentication property="principal.emp_nm"/>'님 안녕하세요 !<br>
			<form action="/logout" method="post">
	<%-- 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
				<input type="submit" value="로그아웃">
			</form>
		 </sec:authorize>
<hr>
<a href="/">홈으로 이동</a>
</body>
</html>