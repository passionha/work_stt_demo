<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	#searchBar {
		border-style: solid;
		border-width: 3px;
		border-color: #00b0f0;
	}
	
	input[type="button"] {
		float: right;
	}
	
	table, th, td {
		border: 2px solid lightgrey;
	}
	
	table {
		clear: both;
	}
</style>
<script type="text/javascript">
const arrChangedIdx = new Array();		//수정된 상품군 인덱스 배열
//상품군 목록 조회
function fn_search(){
	var frm = document.getElementById("frm_prdln");
	frm.action = "getProductList.do";
	frm.submit();
}

//상품군 목록 저장
function fn_save(){
	var arrNoDupIdx = Array.from(new Set(arrChangedIdx));
	alert(arrNoDupIdx);
	for(var i=0; i<$('input[name$="\.prdln_cd"]').length; i++){
		$('input[name$="\.prdln_cd"]').each(function(index, item){
			if(arrNoDupIdx.indexOf(index) == -1){
				$(this).prop('disabled', true);
				console.log(index);
				$('select[name$="\.use_yn"]').eq(index).prop('disabled', true);
				$('input[name$="\.cls_cd"]').eq(index).prop('disabled', true);
				$('input[name$="\.req_dept_cd"]').eq(index).prop('disabled', true);
				$('input[name$="\.prdln_nm"]').eq(index).prop('disabled', true);
				return;
			}
		});
	}
	var frm = document.getElementById("frm_prdln");
	frm.action = "saveProductList.do";
	frm.submit();
}

//수정된 상품군 인덱스 저장
function fn_chkChangedIdx(idx){
	arrChangedIdx.push(idx);
}

//엑셀 다운로드
function fn_excel(){
	var frm = document.getElementById("frm_prdln");
	frm.action = 'getProduct_exl.do';
	frm.submit();
}

//행 추가
function fn_addRow(){
	var trStr="<ul><li>"
		+"<input type=\"checkbox\" name=\"chk_upl_fin_nm\" id=\"chk_upl_fin_nm_"+idx+"\">"
		+"<label for=\"chk_upl_fin_nm_"+idx+"\">"+item.node_nm+"</label>"
//			+"<ul></ul>"
		+"<ul id=\"cls_ul"+idx+"\"></ul>";
		+"</li></ul>";
	$("#tbl_prdln > tbody").append(source);
}

//행 삭제
function fn_delRow(){
	
}

//삭제 체크 row... 
function fn_chkDel(obj){
	
}
</script>
</head>
<body>
<div id="wrap">
	<section>
		<div>
			<c:forEach var="headerTitles" items="${sessionScope.headerTitles}">
				<c:if test="${headerTitles.menu_id eq sessionScope.sel_req_cd}">
					<c:set var="hdTitle" value="${headerTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-04" />
			<c:forEach var="navTitles" items="${sessionScope.navTitles}">
				<c:if test="${navTitles.menu_id eq navMenuId}">
					<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<h3>${sectionTitle}</h3>
		</div>
		
		<div id="btn_top">
			<input type="button" value="엑셀" onclick="fn_excel()">
			<input type="button" value="저장" onclick="fn_save()">
			<input type="button" value="조회" onclick="fn_search()">
		</div>
		<br>
		<form id="frm_prdln" method="post">
		<input type="hidden" id="org_s_PRDLN" name="org_s_PRDLN" value="${s_PRDLN}">
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>상품군/상품군코드</li>
					<li>
						<input type="text" name="s_PRDLN" value="${s_PRDLN}">
					</li>
				</ul>
			</div>
			<div>
				<div id="btn_top">
					<input type="button" value="행추가" onclick="fn_addRow()">
					<input type="button" value="행삭제" onclick="fn_delRow()">
				</div>
				<table id="tbl_prdln">
					<thead>
						<tr>
							<td>삭제</td>
							<td>권역</td>
							<td>구분</td>
							<td>상품군</td>
							<td>상품군코드</td>
							<td>사용여부</td>
							<td>등록일</td>
							<td>등록자</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="pList" items="${prdlnList}" begin="0" step="1" varStatus="status">
						<input type="hidden" name="prdlnList[${status.index}].cls_cd" value="${pList.cls_cd}">
						<input type="hidden" name="prdlnList[${status.index}].req_dept_cd" value="${pList.req_dept_cd}">
						<input type="hidden" name="prdlnList[${status.index}].prdln_cd" value="${pList.prdln_cd}">
						<tr>
							<td></td>
							<td>${pList.req_dept_nm}</td>
							<td>${pList.cls_cd_nm}</td>
							<td><input type="text" value="${pList.prdln_nm}" name="prdlnList[${status.index}].prdln_nm" onchange="fn_chkChangedIdx(${status.index})"></td>
							<td>${pList.prdln_cd}</td>
							<td>
								<select name="prdlnList[${status.index}].use_yn" onchange="fn_chkChangedIdx(${status.index})">
									<option value="Y" <c:if test="${pList.use_yn eq 'Y'}">selected</c:if>>Y</option>
									<option value="N" <c:if test="${pList.use_yn eq 'N'}">selected</c:if>>N</option>
								</select>
							</td>
							<td>${pList.reg_dt}</td>
							<td>${pList.emp_nm}(${pList.emp_no})</td>
						</tr>
						<!--  -->
						<%-- 
						<tr>
							<td><input type="checkbox" name="chk_del" onchange="fn_chkDel(this)"></td>
							<td></td>
							<td></td>
							<td><input type="text" value="${pList.prdln_nm}" name="prdlnList[${status.index}].prdln_nm" onchange="fn_chkChangedIdx(${status.index})"></td>
							<td><input type="text" name="prdlnList[].prdln_cd"></td>
							<td>
								<select name="prdlnList[].use_yn">
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</td>
							<td>${pList.reg_dt}</td>
							<td>${pList.emp_nm}(${pList.emp_no})</td>
						</tr>
						 --%>
						<!--  -->
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
	</section>
</div>
</body>
</html>