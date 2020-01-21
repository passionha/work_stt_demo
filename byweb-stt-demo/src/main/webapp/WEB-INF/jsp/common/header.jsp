<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		var frm = document.createElement('form');
		frm.name = 'newFrm';
		frm.method = 'post';
		frm.action = 'selHeader';
		frm.target = '_self';
		
		var input_reqCd = document.createElement('input');
		input_reqCd.setAttribute("type", "hidden");
		input_reqCd.setAttribute("name", "req_dept_cd");
		input_reqCd.setAttribute("value", reqCd);
		
		frm.appendChild(input_reqCd);
		
		document.body.appendChild(frm);
		
		frm.submit();
	}
</script>
</head>
<body>
	<header>
		<div>
			<ul>
				<li onclick="fn_sbmReqCd(1)">생명보험</li>
				<li onclick="fn_sbmReqCd(2)">손해보험</li>
				<li onclick="fn_sbmReqCd(3)">보험대리점</li>
			</ul>
		</div>
	</header>
</body>
</html>