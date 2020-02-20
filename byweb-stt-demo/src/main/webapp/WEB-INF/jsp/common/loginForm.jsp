<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
</head>
<body>
	<p>로그인 폼 화면입니다.</p>
	<form action="/authenticate" method="post" id="frm_auth">
<%-- 	<form method="post" id="frm_auth" name="loginForm" action="<c:url value='authenticate' />"> --%>
		아이디 <input type="text" id="id" name="acnt_id">
		비밀번호 <input type="password" id="pw" name="acnt_pw">
		<input type="submit" value="로그인">	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
</body>
</html>