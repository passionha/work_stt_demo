<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
function fn_submit(){
	$('#acnt_id').val($('#id').val());
	$('#acnt_pw').val($('#pw').val());
	
	document.getElementById('frm_auth').submit();
}
</script>
</head>
<body>
	<p>로그인 폼 화면입니다.</p>
	<form action="authenticate" method="post" id="frm_auth">
		아이디 <input type="text" id="id">
		비밀번호 <input type="password" id="pw">
		<input type="hidden" id="acnt_id" name="acnt_id">
		<input type="hidden" id="acnt_pw" name="acnt_pw">
		<input type="button" value="로그인" onclick="fn_submit()">	
	</form>
</body>
</html>