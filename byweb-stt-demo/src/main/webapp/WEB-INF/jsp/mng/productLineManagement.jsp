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
const f_arrChangedIdx = new Array();	//수정된 상품군 인덱스 배열

//상품군 목록 조회
function fn_search(){
	var frm = document.getElementById("frm_prdln");
	frm.action = "getProductList.do";
	frm.submit();
}

//상품군 목록 저장
function fn_save(){
	//상품군명, 상품군코드 미입력 여부 검사
	var emptyNmIdx = "";
	var emptyCdIdx = "";
	for(var i=0; i<$('input[name$="\.prdln_nm"]').length; i++){
		if(!jQuery.trim($('input[name$="\.prdln_nm"]').eq(i).val())){
			emptyNmIdx = i;
		}
		if(!jQuery.trim($('input[name$="\.prdln_cd"]').eq(i).val())){
			emptyCdIdx = i;
		}
	}
	if(emptyNmIdx){
		alert("상품군을 입력해주세요.");
		$('input[name$="\.prdln_nm"]').eq(emptyNmIdx).focus();
		return;
	}else if(emptyCdIdx){
		alert("상품군코드를 입력해주세요.");
		$('input[name$="\.prdln_cd"]').eq(emptyCdIdx).focus();
		return;
	}
	
	//상품군명 중복검사
	var dupPrdlnNm = "";
	var dupNmIdx = "";
	for(var i=0; i<$('input[name$="\.prdln_nm"]').length; i++){
		var prdln_nm = $('input[name$="\.prdln_nm"]').eq(i).val();
		if(!prdln_nm){ continue; }
		$('input[name$="\.prdln_nm"]').each(function(index, item){
			if(i != index && prdln_nm == $(this).val()){
				dupPrdlnNm = prdln_nm;
				dupNmIdx = i;
			}
		});
	}
	//상품군코드 중복검사
	var dupPrdlnCd = "";
	var dupCdIdx = "";
	for(var i=0; i<$('input[name$="\.prdln_cd"]').length; i++){
		var prdln_cd = $('input[name$="\.prdln_cd"]').eq(i).val();
		if(!prdln_cd){ continue; }
		$('input[name$="\.prdln_cd"]').each(function(index, item){
			if(i != index && prdln_cd == $(this).val()){
				dupPrdlnCd = prdln_cd;
				dupCdIdx = i;
			}
		});
	}
	
	if(dupPrdlnNm){
		alert("["+dupPrdlnNm+"]은(는) 중복된 상품군입니다.");
		$('input[name$="\.prdln_nm"]').eq(dupNmIdx).focus();
		return;
	}else if(dupPrdlnCd){
		alert("["+dupPrdlnCd+"]은(는) 중복된 상품군코드입니다.");
		$('input[name$="\.prdln_cd"]').eq(dupCdIdx).focus();
		return;
	}
	
	//상품군, 코드 중복검사 필요*****************************
	if(confirm("수정사항을 저장하시겠습니까?")){
		var arrNoDupChangedIdx = Array.from(new Set(f_arrChangedIdx));
		for(var i=0; i<$('input[name$="\.prdln_cd"]').length; i++){
			$('input[name$="\.prdln_cd"]').each(function(index, item){
				if($(this).prop('type')=="hidden"){
					if(arrNoDupChangedIdx.indexOf(index) == -1){
						$(this).prop('disabled', true);
						$('select[name$="\.use_yn"]').eq(index).prop('disabled', true);
						$('input[name$="\.cls_cd"]').eq(index).prop('disabled', true);
						$('input[name$="\.req_dept_cd"]').eq(index).prop('disabled', true);
						$('input[name$="\.prdln_nm"]').eq(index).prop('disabled', true);
						return;
					}
				}
			});
		}
		var frm = document.getElementById("frm_prdln");
		frm.action = "saveProductList.do";
		frm.submit();
		alert("저장되었습니다.");
	}
}

//수정된 상품군 인덱스 저장
function fn_chkChangedIdx(idx){
	f_arrChangedIdx.push(idx);
}

//엑셀 다운로드
function fn_excel(){
	$('#req_dept_nm').val($("#tbl_prdln > tbody > tr > td").eq('1').text());
	var frm = document.getElementById("frm_prdln");
	frm.action = 'getProduct_exl.do';
	frm.submit();
}

//행 추가
function fn_addRow(){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;	//getMonth()는 0~11 반환해서 +1
	var day = date.getDate();
	if((day+"").length < 2){ day = "0"+day; }
	if((month+"").length < 2){ month = "0"+month; }
	var today = year+"-"+month+"-"+day;
	
	var prevInputVal = $("#tbl_prdln > tbody > tr:last > td:eq(4) > input").val();
	var prevPrdlnCd = $("#tbl_prdln > tbody > tr:last > td").eq(4).text();
	var val = prevPrdlnCd == "" ? Number(prevInputVal)+1 : Number(prevPrdlnCd)+1;
	var len = prevPrdlnCd == "" ? prevInputVal.length : prevPrdlnCd.length;
	var recmdPrdlnCd = prevPrdlnCd != "" || prevInputVal != "" ? fn_lpad(val, len, '0') : "";
	
	var newRowIdx = $('input[name$="\.prdln_cd"]').length+1;
	var prevReqNm = $("#tbl_prdln > tbody > tr:last > td").eq(1).text();
	var prevClsNm = $("#tbl_prdln > tbody > tr:last > td").eq(2).text();
	var prevReqCd = $("#tbl_prdln > tbody > tr:last").siblings('input[name$=".req_dept_cd"]').last().val();
	var prevClsCd = $("#tbl_prdln > tbody > tr:last").siblings('input[name$=".cls_cd"]').last().val();
	
	//권역 콤보박스 옵션용 권역정보 추출
	if(prevReqCd == '3'){
		prevClsNm = "<select name=\"prdlnList["+newRowIdx+"].cls_cd\">";
		for(var i=0; i<$('input[name^="cd_"]').length; i++){
			prevClsNm += "<option value=\""+$('input[name^="cd_"]').eq(i).val()+"\">"+$('input[name^="nm_"]').eq(i).val()+"</option>";
		}
		prevClsNm += "</select>";
	}
	var trSrc ="<tr>"
		+"<td><input type=\"checkbox\" name=\"chk_del\"></td>"
		+"<td>"+prevReqNm+"</td>"
		+"<td>"+prevClsNm+"</td>"
		+"<td><input type=\"text\" name=\"prdlnList["+newRowIdx+"].prdln_nm\"></td>"
		+"<td><input type=\"text\" name=\"prdlnList["+newRowIdx+"].prdln_cd\" value=\""+recmdPrdlnCd+"\"></td>"
		+"<td>"
		+"<select name=\"prdlnList["+newRowIdx+"].use_yn\">"
		+"<option value=\"Y\">Y</option>"
		+"<option value=\"N\">N</option>"
		+"</select>"
		+"</td>"
		+"<td>"+today+"</td>"
		+"<td></td>"
		+"</tr>";
		if(prevReqCd != '3'){
			trSrc += "<input type=\"hidden\" name=\"prdlnList["+newRowIdx+"].cls_cd\" value=\""+prevClsCd+"\">";
		}
		trSrc += "<input type=\"hidden\" name=\"prdlnList["+newRowIdx+"].req_dept_cd\" value=\""+prevReqCd+"\">";
	$("#tbl_prdln > tbody").append(trSrc);
}

//행 삭제
function fn_delRow(){
	if(confirm("체크된 행을 삭제하시겠습니까?")){
		$('input[name="chk_del"]:checked').closest('td').closest('tr').remove();
	}
}

//LPAD함수 구현(값, 총 길이, 삽입문자)
function fn_lpad(val, len, chr) {
	val = val + '';
	return val.length >= len ? val : new Array(len - val.length + 1).join(chr) + val;
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
		<c:forEach var="cList" items="${clsCdList}" varStatus="status">
		<input type="hidden" name="cd_${status.index}" value="${cList.cd}">
		<input type="hidden" name="nm_${status.index}" value="${cList.cd_nm}">
		</c:forEach>
		<input type="hidden" id="org_s_PRDLN" name="org_s_PRDLN" value="${org_s_PRDLN}">
		<input type="hidden" id="req_dept_nm" name="req_dept_nm">
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
					<input type="button" value="행삭제" onclick="fn_delRow()">
					<input type="button" value="행추가" onclick="fn_addRow()">
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
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
	</section>
</div>
</body>
</html>