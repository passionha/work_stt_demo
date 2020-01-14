<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>※동의어 관리</title>
</head>
<body>
	<div id="wrap">
		<div id="popupTitle">
			<h3>※동의어 관리</h3>
		</div> 
		
		<div id="btn_synSet">
			<input type="button" value="저장">
			<input type="button" value="삭제" onclick="confirm('동의어를 삭제하시겠습니까?');">
		</div>
		
		<table border="1">
			<tr>
				<th>동의어</th>
				<td><input type="text" value="동의어2"></td>
			</tr>
			<tr>
				<th>기준 키워드</th>
				<td><input type="text" value="사업자/퍼센트" readonly></td>
			</tr>
		</table>
		
		<div id="synSelTitle">
			<h4>□동의어 선택</h4>
		</div>
		
		<table border="1">
			<thead>
				<tr>
					<th>선택</th>
					<th>키워드</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox"></td>
					<td><input type="text" value="사망보장" readonly></td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>