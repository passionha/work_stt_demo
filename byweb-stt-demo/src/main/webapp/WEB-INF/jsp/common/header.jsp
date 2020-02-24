<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="java.util.*" %>
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
	
	#frm_logout {
		display: inline;
	}
	
	#li_logoutBtn, #li_loginNm {
		float: right;
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
				<c:forEach var="headerTitles" items="${sessionScope.headerTitles}" begin="0" step="1">
				<li onclick="fn_sbmReqCd('${headerTitles.menu_id}')">${headerTitles.menu_nm}</li>
				</c:forEach>
				<sec:authorize access="isAuthenticated()">
					<li id="li_logoutBtn">
						<form id="frm_logout" action="/logout" method="post">
				<%-- 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
							<input type="submit" id="btn_logout" value="로그아웃">
						</form>
					</li>
					<li id="li_loginNm">
						'<sec:authentication property="principal.emp_nm"/>
						(<sec:authentication property="principal.username"/>)'님 안녕하세요 !
					</li>
				 </sec:authorize>
			</ul>
		</div>
		<form id="frm_selHeader" action="/cm/selHeader.do" method="post">
			<input type="hidden" id="req_dept_cd" name="req_dept_cd">
<%-- 			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
		</form>
	</header>
</body>
</html>