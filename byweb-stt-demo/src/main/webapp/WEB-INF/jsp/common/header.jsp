<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	header {
		border: 1px solid #999;
		margin: 5px;
		padding: 10px;
	}
	
	li {
		display: inline;
	}
</style>
<script type="text/javascript">
	function fn_sbmReqCd(reqCd){
		var frm = document.getElementById("frm_selHeader");
		
		document.getElementById("req_dept_cd").value = reqCd;
		
		frm.submit();
	}
</script>
</head>
<body>
	<header>
		<div>
			<ul>
				<c:forEach var="headerTitles" items="${headerTitles}" begin="0" step="1">
				<li onclick="fn_sbmReqCd('${headerTitles.class_cd}')">${headerTitles.class_name}</li>
				</c:forEach>
			</ul>
		</div>
		<form id="frm_selHeader" action="selHeader" method="post" target="_self">
			<input type="hidden" id="req_dept_cd" name="req_dept_cd">
		</form>
	</header>
</body>
</html>