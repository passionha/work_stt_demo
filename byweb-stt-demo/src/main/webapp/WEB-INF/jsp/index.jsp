<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
hello<br> 

<a href="/admin">어드민 페이지로 이동</a><br>
<a href="/user">유저 페이지로 이동</a><br>

<a href="/registerForm">회원가입 페이지로 이동</a><br>

 <sec:authorize access="isAnonymous()">
 	<br> 로그아웃 중입니다.
 </sec:authorize>
 <sec:authorize access="isAuthenticated()">
 	<br> 로그인 중입니다. 
 </sec:authorize>
</body>
</html>