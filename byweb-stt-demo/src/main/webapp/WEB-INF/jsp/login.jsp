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
	<form action="${loginUrl}" method="post">       
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


<hr>
<a href="/">홈으로 이동</a>
</body>
</html>