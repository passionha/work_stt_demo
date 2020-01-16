<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<table>
					<thead>
						<tr><th>파일명</th></tr>
					</thead>
					<tbody>
						<tr><td>123456_4.wav</td></tr>
						<tr><td>123456_5.wav</td></tr>
						<tr><td>123456_6.wav</td></tr>
						<tr><td>123456_7.wav</td></tr>
						<tr><td>123456_8.wav</td></tr>
						<tr><td>123456_9.wav</td></tr>
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
							<td>A보험회사</td>
							<td>2019-09-20</td>
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
							<th>등록일</th>
							<th>등록자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>A보험_190920.zip</td>
							<td>2019-09-20</td>
							<td>홍길동(123456)</td>
						</tr>
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
				<input type="button" value="취소">
			</div>
		</div>
	</div>
</body>
</html>