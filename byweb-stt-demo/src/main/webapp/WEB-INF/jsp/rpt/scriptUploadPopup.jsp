<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대본파일 업로드</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
var parentSearchYn = false;		//팝업 종료 시 부모창 재조회 여부

$(document).ready(function(){
	//팝업 시 parent창 비활성화
	window.opener.$('#modal_layer').css({'display':'block'});
});

//팝업 종료 시 parent 활성화
function fn_befClosePop(){
	if(parentSearchYn) window.opener.fn_search();			//부모창 재조회
	window.opener.$('#modal_layer').css({'display':'none'});
}
</script>
</head>
<body onbeforeunload="fn_befClosePop();">
<div id="wrap">
	<div id="fileInfo">
		<div id="finInfoTitle">
			<h4>□기본 정보</h4>
		</div>
		<div id="finInfoList">
			<table border="1">
				<thead>
					<tr>
						<th>회사명</th>
						<th>요청일자</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${contractVo.fin_nm}</td>
						<td>${contractVo.req_dt}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="uplHisTitle">
		<h4>□조회 결과</h4>
	</div>
	<div id="uplHisList">
		<div>
			<table border="1">
				<thead>
					<tr>
						<th>업로드파일명</th>
						<th>등록일시</th>
						<th>등록자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="hisList" items="${hisList}">
					<tr>
						<td>${hisList.upl_file_nm}</td>
						<td>${hisList.reg_dt}</td>
						<td>${hisList.emp_nm}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="attachTitle">
		<h4>□파일 목록</h4>
	</div>
	<div id="attachList">
	</div>
	
	<div id="btn_uplAndDel">
		<input type="button" value="업로드">
		<input type="button" value="취소" onclick="self.close()">
	</div>
</div>
</body>
</html>