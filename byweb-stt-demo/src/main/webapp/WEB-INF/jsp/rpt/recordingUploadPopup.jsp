<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>※녹취파일 업로드</title>
<style type="text/css">
	#mismatchBox {
		float: left;
	}
	
	#fileInfo {
		float: right;
	}
</style>
</head>
<body>
	<div id="wrap">
		<div id="mismatchBox">
			<div id="mismatchTitle">
				<h4>□비매칭 녹취파일</h4>
			</div>
			<div id="mismatchList>">
				<table border="1">
					<thead>
						<tr><th>파일명</th></tr>
					</thead>
					<tbody>
						<c:forEach var="mismatchList" items="${mismatchList}" begin="0" step="1">
						<tr><td>${mismatchList.rcd_file_nm}</td></tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
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
			
			<div id="uplHisTitle">
				<h4>□조회 결과</h4>
			</div>
			<div id="uplHisList">
				<table border="1">
					<thead>
						<tr>
							<th>업로드파일명</th>
							<th>등록일자</th>
							<th>등록자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="hisList" items="${hisList}" begin="0" step="1">
						<tr>
							<td>${hisList.upl_file_nm}</td>
							<td>${hisList.reg_dt}</td>
							<td>${hisList.emp_nm}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
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
	</div>
</body>
</html>