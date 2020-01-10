<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사별 제출현황</title>
<style type="text/css">
	body {
		text-align: center;
		color: black;
		width: 1400px;
	}

	#wrapper {
		width: 100%;
		text-align: left;
		min-height: 300px;
		margin: 0 auto;
	}
	
	section {
		border: 1px solid #999;
		margin: 5px;
		padding: 10px;
		float: left;
		height: 550px;
		width: 1235px;
	}
	
	li {
		display: inline;
	}
	
	li:nth-child(2), :nth-child(5) {
		padding-right: 5px;
	}
	
	li:nth-child(3) {
		padding-right: 100px;
	}
	
	#searchBar {
		border-style: solid;
		border-width: 3px;
		border-color: #00b0f0;
	}
	
	#tbl_sbmList th, td, input {
		text-align: center;
	}
	
	#btn_top input {
		float: right;
		margin-bottom: 10px;
	}
</style>
</head>
<body>
<div id="wrapper">
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/nav.jsp" %>
	<section>
		<h3>회사별 제출현황</h3>
		
		<div id="btn_top">
			<input type="button" value="엑셀">
			<input type="button" value="조회">
		</div>
			
		<div id="searchBar">
			<ul>
				<li>▶</li>
				<li>회사명</li>
				<li>
					<select>
						<option>전체</option>	
						<option>A보험회사</option>	
						<option>B보험회사</option>	
					</select>
				</li>
				<li>▶</li>
				<li>제출일자</li>
				<li>
					<input type="text" value="2019-12-11">
				</li>
				<li>~</li>
				<li>
					<input type="text" value="2019-01-11">
				</li>
			</ul>
			<table id="tbl_sbmList">
				<thead>
					<tr>
						<th>회사명</th>
						<th>제출파일명</th>
						<th>요청일자</th>
						<th>제출일자</th>
						<th>업로드파일명</th>
						<th>계약건수</th>
						<th>녹취파일건수</th>
						<th>비매칭건수</th>
						<th>녹취파일 업로드</th>
						<th>STT진행상태</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>A보험회사</td>
						<td>TM_20190920_1.txt</td>
						<td>2019-09-20</td>
						<td>2019-09-20</td>
						<td>A보험_190920.zip</td>
						<td>15</td>
						<td>15</td>
						<td>1</td>
						<td><input type="button" value="업로드"></td>
						<td>완료</td>
						<td><input type="button" value="삭제"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>