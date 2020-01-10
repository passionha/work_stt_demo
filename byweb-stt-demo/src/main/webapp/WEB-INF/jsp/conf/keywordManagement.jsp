<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>녹취파일 분석기준 설정</title>
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
	
	#kwdSetBox {
		border-style: solid;
		border-width: 1px;
		padding: 10px;
		margin: 10px 0;
	}
	
	#kwdSetTitle {
		margin: -10px 0 -30px 0;
	}
	
	#btn_kwdSet {
		float: right;
		margin-bottom: 10px;
	}
	
	#ta_writeKwd {
		width: 100%
	}
	
	#kwdListTitle {
		margin: 0 0 -30px 10px;
	}
	
	#tbl_kwdList th, td, input {
		text-align: center;
	}
	
	#btn_kwdList input {
		float: right;
		margin-bottom: 10px;
	}
	
	#tbl_kwdList tr, th, td {
		border-style: solid;
		border-width: 1px;
	}
	
	
</style>
</head>
<body>
<div id="wrapper">
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/nav.jsp" %>
	<section>
	
		<h3>녹취파일 분석기준 설정</h3>
		<div id="searchBar">
			<ul>
				<li>▶</li>
				<li>상품군</li>
				<li>
					<select>
						<option>선택</option>	
						<option>연금보험</option>	
					</select>
				</li>
				<li>▶</li>
				<li>키워드종류</li>
				<li>
					<select>
						<option>선택</option>	
						<option>필수키워드</option>
						<option>금지어</option>
					</select>
				</li>
			</ul>
		</div>
		
		<div id="kwdSetBox">
			<div id="kwdSetTitle">
				<h4>[ 필수키워드 등록 ]</h4>
			</div>
			<div id="btn_kwdSet">
				<input type="button" value="키워드 등록">
			</div>
			<textarea id="ta_writeKwd" rows="4">여러 키워드 등록 시 구분자를 ","단위로 등록하세요. 한 키워드는 50자 이상을 넘을 수 없습니다.</textarea>
		</div>
		<div id="kwdListBox">
			<div id="kwdListTitle">
				<h4>[ 필수키워드 목록 ]</h4>
			</div>
			<div id="btn_kwdList">
				<input type="button" value="저장">
				<input type="button" value="삭제">
				<input type="button" value="동의어" onclick="window.open('goSynPopup','synMngPopup','width=430,height=500,location=no,status=no,scrollbars=no');">
			</div>
			<table id="tbl_kwdList">
				<thead>
					<tr>
						<th>NO</th>
						<th><input type="checkbox"></th>
						<th>키워드</th>
						<th>동의어</th>
						<th>범위(단어 수)</th>
						<th>사용여부</th>
						<th>배점</th>
						<th>등록자</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td><input type="checkbox"></td>
						<td><input type="text" value="사망보장"></td>
						<td><input type="text" value="동의어1" readonly onclick="window.open('goSynPopup','synMngPopup','width=430,height=500,location=no,status=no,scrollbars=no');"></td>
						<td><input type="text" value="20"></td>
						<td><input type="text" value="Y"></td>
						<td><input type="text" value="10"></td>
						<td>홍길동(123456</td>
						<td>2020-01-02</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		
		
		
	</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>