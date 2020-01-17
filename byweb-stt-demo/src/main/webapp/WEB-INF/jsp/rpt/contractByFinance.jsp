<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">
/* 
var red_fin_cd = '${red_fin_cd}';
var req_dt = '${req_dt}';
console.log('red_fin_cd : '+red_fin_cd);
console.log('req_dt : '+req_dt);
 */
function delContract(fin_nm, sbm_dt, fin_cd, req_dt){
	//sbm_dt .포맷 변경 필요
	if(confirm('[ '+fin_nm+' / 제출일 : '+sbm_dt+' ]\n해당 행과 모든 데이터를 삭제하시겠습니까?')){
// 		var frm = document.createElement('form');
		var frm = document.getElementById("frm");
		
		frm.name = 'newFrm';
		frm.method = 'post';
		frm.action = 'delContract';
		frm.target = '_self';
		
		var input_fin_cd = document.createElement('input');
		var input_req_dt = document.createElement('input');
		
		input_fin_cd.setAttribute("type", "hidden");
		input_fin_cd.setAttribute("name", "fin_cd");
		input_fin_cd.setAttribute("value", fin_cd);
		
		input_req_dt.setAttribute("type", "hidden");
		input_req_dt.setAttribute("name", "req_dt");
		input_req_dt.setAttribute("value", req_dt);
		
		frm.appendChild(input_fin_cd);
		frm.appendChild(input_req_dt);
		
		document.body.appendChild(frm);
		
		frm.submit();
	}else{
		return;
	}
}

</script>
</head>
<body>
<div id="wrapper">
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/nav.jsp" %>
	<section>
		<h3>회사별 제출현황</h3>
		<form id="frm" action="getContractList" method="post">
			<div id="btn_top">
				<input type="button" value="엑셀">
				<input type="submit" value="조회">
			</div>
			<br>
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="sel_fin_cd">
							<c:forEach var="fin" items="${finList}" begin="0" step="1">
								<option value="${fin.finance_cd}" <c:if test="${fin_cd eq fin.finance_cd}">selected</c:if>>${fin.finance_name}</option>
							</c:forEach>
						</select>
					</li>
					<li>▶</li>
					<li>제출일자</li>
					<li>
						<input type="text" name="sdate" <c:if test="${sdate ne ''}">value="${sdate}"</c:if>>
						<img src="/user/images/calendar.gif" onclick="">
					</li>
					<li>~</li>
					<li>
						<input type="text" name="edate" <c:if test="${edate ne ''}">value="${edate}"</c:if>>
						<img src="/user/images/calendar.gif" onclick="">
					</li>
				</ul>
			</div>
		</form>
		<table id="tbl_sbmList" border="1">
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
				<c:forEach var="con" items="${conList}" begin="0" step="1">
				<tr>
					<td>${con.fin_nm}</td>
					<td>${con.sbm_file_nm}</td>
					<td>${con.req_dt}</td>
					<td>${con.sbm_dt}</td>
					<td>${con.upl_file_nm}</td>
					<td>${con.ctt_cnt}</td>
					<td>${con.file_cnt}</td>
					<td>${con.mismatch_cnt}</td>
					<td><input type="button" value="업로드" onclick="window.open('recUplPopup','recUplPopup','width=800,height=600,location=no,status=no,scrollbars=no');"></td>
					<td>${con.anly_st}</td>
					<td><input type="button" value="삭제" onclick="delContract('금융감독원', ${con.sbm_dt}, ${con.fin_cd}, ${con.req_dt})"></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>