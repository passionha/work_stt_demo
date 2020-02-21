<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/register">
	아이디 : <input type="text" name="acnt_id" /><br>
	<!-- Toy 이라 패스워드도 그냥 확인하고 싶어서 text로 걸었습니다 -->
	비밀번호 : <input type="text" name="acnt_pw" /><br>
	권한 : <input type="text" name="auth_cd" value="TM" /><br>
	사번 : <input type="text" name="emp_no"/><br>
	이름 : <input type="text" name="emp_nm"/><br>
	이메일 : <input type="text" name="emp_email"/><br>
	<input type="submit" value="확인">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</body>
</html>