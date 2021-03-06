<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, kr.byweb.stt.demo.cm.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>녹취파일 계약정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	body {
		color: black;
		width: 1400px;
	}

	#wrap {
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
	
	#wrap li {
		display: inline;
	}
	
	#wrap li:nth-child(2), :nth-child(5) {
		padding-right: 5px;
	}
	
	#wrap li:nth-child(3) {
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
	
	#modal_layer {
    	display: none;
    	position: fixed;
    	top: 0;
    	left: 0;
    	width: 100%;
        height: 100%;
/*         background:rgba(0, 0, 0, 0.5); */
        z-index: 9000;
    }
</style>
<script type="text/javascript">
//조회조건 유효성 검사 및 submit
function fn_search(){
	//회사별-녹계 전환시 / 녹계 재조회 시 계약일(sdate, edate) 최소,최대값 default지정 필요**************************************
	if(fn_validDate(document.getElementById("sdate"))){
		return;
	}
	if(fn_validDate(document.getElementById("edate"))){
		return;
	}
	var idx = $("#sel_fin_cd option").index( $("#sel_fin_cd option:selected") );
	document.getElementById("det_class_cd").value = $('input[name="fin_cls_cd"]').eq(idx).val();
	document.getElementById("req_dt").value = fn_onlyNum(document.getElementById("req_dt").value);
	document.getElementById("sdate").value = fn_onlyNum(document.getElementById("sdate").value);
	document.getElementById("edate").value = fn_onlyNum(document.getElementById("edate").value);
	var frm = document.getElementById("frm");
	frm.submit();
}

//계약일자 조회조건 유효성 검사
function fn_validDate(obj){
	var sdtVal = fn_onlyNum(document.getElementById("sdate").value);
	var edtVal = fn_onlyNum(document.getElementById("edate").value);
	var objVal = fn_onlyNum(obj.value);
	var date_pattern = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; 
	if(!date_pattern.test(objVal)){
		alert("올바른 일자를 입력해주세요.");
		obj.focus();
	}else if(!obj.value.trim() && obj.value == document.getElementById("sdate").value){
		alert("시작일자를 입력해주세요.");
		obj.focus();
	}else if(!obj.value.trim() && obj.value == document.getElementById("edate").value){
		alert("종료일자를 입력해주세요.");
		obj.focus();
	}else if(objVal == edtVal && edtVal < sdtVal){
		alert("시작일자 이후의 종료일자를 입력해주세요.");
		obj.focus();
	}else if(objVal == sdtVal && sdtVal > edtVal){
		alert("종료일자 이전의 시작일자를 입력해주세요.");
		obj.focus();
	}else{
		return false;
	}
	return true;
}

//숫자만 추출
function fn_onlyNum(value) {
    return value.replace(/[^0-9]/g,"");
}

//계약일 입력 시 '-' 자동 입력
function fn_addDash( event, obj ){
    var num_arr = [ 
        97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    ]
    var key_code = ( event.which ) ? event.which : event.keyCode;
    if( num_arr.indexOf( Number( key_code ) ) != -1 ){
        var len = obj.value.length;
        if( len == 4 ) obj.value += "-";
        if( len == 7 ) obj.value += "-";
    }
}


//엑셀 다운로드
function fn_excel(){
	var frm = document.getElementById("frm_exl");
	$('#org_fin_nm').val($("#sel_fin_cd option:selected").text());
	frm.action='/tm/getContractDetail_exl.do';
	frm.submit();
}

//녹취파일변환
function fn_anlysAll(){
	var req_cnt = 0;
	$('input[name="conList_trns_stts"]').each(function (i, element) {
		if($(element).val() == '4' && $('input[name="conList_req_yn"]').eq(i).val() == 'N'){
			req_cnt++;
		}
    });
	
	if(req_cnt > 0){
		if(confirm("STT진행상태가 \'업로드완료\'인 건만 녹취파일 변환요청이 진행됩니다.\n변환요청을 진행하시겠습니까?")){
			var frm = document.getElementById("frm_anlysAll");
			frm.action='/tm/setAnalysisAll.do';
			frm.submit();
			alert("녹취파일 변환을 요청하였습니다.");
		}
	}else{
		alert("STT진행상태가 \'업로드완료\'인 건이 존재하지 않습니다.");
	}
}

//대본파일 다운로드 팝업(scrSpr - 1:상품설명, 2:해피콜)
function fn_openScrDownPopup(scrSpr, idx){
	var scrts_no = $('input[name="conList_scrts_no"]').eq(idx).val();
// 	var pScrNm = encodeURIComponent($('input[name="conList_pdesc_scpt_file_nm"]').eq(idx).val());
// 	var hScrNm = encodeURIComponent($('input[name="conList_hpycl_scpt_file_nm"]').eq(idx).val());
// 	var fin_nm = encodeURIComponent($('input[name="conList_fin_nm"]').eq(idx).val());
// 	var strUrl = 'getScriptFileInfo.do?cls_cd='+$('#scr_cls_cd').val()+'&fin_cd='+$('#scr_fin_cd').val()+'&req_dt='+$('#scr_req_dt').val()+'&scrts_no='+scrts_no
// 								   +'&pdesc_scpt_file_nm='+pScrNm+'&hpycl_scpt_file_nm='+hScrNm+'&scr_spr='+scrSpr+'&fin_nm='+fin_nm;
// 	var strFeature = "dialogWidth:350px; dialogHeight:120px; center:yes; help:no; status:no; scroll:no; resizable:no";
// 	var rtnVal = window.showModalDialog(strUrl, '', strFeature);
	
	var popWidth = 350;
	var popHeight = 120;
	var popupX = (window.screen.width / 2) - (popWidth / 2);
	var popupY= (window.screen.height / 2) - (popHeight / 2);
	
	
	f_childPop = window.open('','scrDownPopup','width='+popWidth+', height='+popHeight+', location=no, status=no, scrollbars=no, menubar=no, titlebar=no, left='+popupX+', top='+popupY);
	var frm_uplPop = document.getElementById("frm_scrDownPop");
	$('#scr_pdesc_scpt_file_nm').val($('input[name="conList_pdesc_scpt_file_nm"]').eq(idx).val());
	$('#scr_hpycl_scpt_file_nm').val($('input[name="conList_hpycl_scpt_file_nm"]').eq(idx).val());
	$('#scr_spr').val(scrSpr);
	$('#scr_fin_nm').val($('input[name="conList_fin_nm"]').eq(idx).val());
	$('#scr_scrts_no').val(scrts_no);
	frm_uplPop.submit();
}

//녹취파일 계약정보 페이지 이동 시 열린 팝업 자동 닫기
function fn_childPopup(){
	if(!f_childPop.closed && f_childPop){
		f_childPop.close();	
	}
}
</script>
</head>
<body onbeforeunload="fn_childPopup();">
<div id="modal_layer"></div><!-- 팝업 시 parent창 비활성화용 cover -->
<div id="wrap">
	<section>
		<div>
			<c:forEach var="headerTitles" items="${sessionScope.headerTitles}">
				<c:if test="${headerTitles.menu_id eq sessionScope.sel_req_cd}">
					<c:set var="hdTitle" value="${headerTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-01-01" />
			<c:forEach var="navTitles" items="${sessionScope.navTitles}">
				<c:if test="${navTitles.menu_id eq navMenuId}">
					<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<h3>${sectionTitle}</h3>
		</div>
		<form id="frm" action="/tm/getContractDetailList.do" method="post">
			<input type="hidden" id="det_class_cd" name="det_class_cd">
			<div id="btn_top">
				<input type="button" value="녹취파일변환" onclick="fn_anlysAll()">
				<input type="button" value="엑셀" onclick="fn_excel()">
				<input type="button" value="조회" onclick="fn_search()">
			</div>
			<br>
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="fin_cd">
							<c:forEach var="finList" items="${finList}" begin="0" step="1">
								<c:if test="${finList.finance_cd ne 'ALL'}">
								<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
								</c:if>
							</c:forEach>
						</select>
						<c:forEach var="finList" items="${finList}" begin="0" step="1">
							<c:if test="${finList.finance_cd ne 'ALL'}">
							<input type="hidden" name="fin_cls_cd" value="${finList.class_cd}">
							</c:if>
						</c:forEach>
					</li>
					
					<li>▶</li>
					<li>요청일</li>
					<li>
						<fmt:parseDate value="${req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
						<input type="text" id="req_dt" name="req_dt" value="<fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/>" readonly>
					</li>
					<br>
					<li>▶</li>
					<li>상품군</li>
					<li>
						<select id="sel_prdln_cd" name="prdln_cd">
							<c:forEach var="prdList" items="${prdList}" begin="0" step="1">
							<c:if test="${prdList.prdln_cd != 'SEL'}">
								<option value="${prdList.prdln_cd}" <c:if test="${prdln_cd eq prdList.prdln_cd}">selected</c:if>>${prdList.prdln_nm}</option>
							</c:if>
							</c:forEach>
						</select>
					</li>
					
					<li>▶</li>
					<li>증권번호</li>
					<li>
						<input type="text" id="scrts_no" name="scrts_no" value="${scrts_no}">
					</li>
					
					<li>▶</li>
					<li>계약일</li>
					<li>
						<fmt:parseDate value="${ctt_sdate}" var="fmt_sdate" pattern="yyyyMMdd"/>
						<input type="text" id="sdate" name="ctt_sdate" <c:if test="${ctt_sdate ne ''}">value="<fmt:formatDate value="${fmt_sdate}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif">
					</li>
					<li>~</li>
					<li>
						<fmt:parseDate value="${ctt_edate}" var="fmt_edate" pattern="yyyyMMdd"/>
						<input type="text" id="edate" name="ctt_edate" <c:if test="${ctt_edate ne ''}">value="<fmt:formatDate value="${fmt_edate}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif">
					</li>
				</ul>
			</div>
		</form>
		<table id="tbl_sbmList" border="1">
			<thead>
				<tr>
					<th>회사명</th>
					<th>상품군</th>
					<th>증권번호</th>
					<th>상품명</th>
					<th>계약일</th>
					<th>계약상태</th>
					<th>계약상태발생일</th>
					<th>계약자명</th>
					<th>상품설명대본파일명</th>
					<th>해피콜대본파일명</th>
					<th>대리점명</th>
					<th>대리점등록번호</th>
					<th>모집점포명</th>
					<th>모집채널</th>
					<th>STT진행상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="conList" items="${conList}" begin="0" step="1" varStatus="status">
				<fmt:parseDate value="${conList.ctt_dt}" var="fmt_ctt_dt" pattern="yyyyMMdd"/>
				<fmt:parseDate value="${conList.ctt_stts_efdt}" var="fmt_ctt_stts_efdt" pattern="yyyyMMdd"/>
				<tr>
					<td>${conList.fin_nm}</td>
					<td>${conList.prdln_nm}</td>
					<td>${conList.scrts_no}</td>
					<td>${conList.prd_nm}</td>
					<td><fmt:formatDate value="${fmt_ctt_dt}" pattern="yyyy-MM-dd"/></td>
					<td>${conList.ctt_stts}</td>
					<td><fmt:formatDate value="${fmt_ctt_stts_efdt}" pattern="yyyy-MM-dd"/></td>
					<td>${conList.cttor_nm}</td>
					<td onclick="fn_openScrDownPopup(1, ${status.index})">${conList.pdesc_scpt_file_nm}</td>
					<td onclick="fn_openScrDownPopup(2, ${status.index})">${conList.hpycl_scpt_file_nm}</td>
					<td>${conList.ga_nm}</td>
					<td>${conList.ga_rno}</td>
					<td>${conList.rcrt_sto_nm}</td>
					<td>${conList.rcrt_chnl}</td>
					<td>${conList.anly_st}</td>
				</tr>
				<input type="hidden" name="conList_trns_stts" value="${conList.trns_stts}">
				<input type="hidden" name="conList_req_yn" value="${conList.req_yn}">
				<input type="hidden" name="conList_scrts_no" value="${conList.scrts_no}">
				<input type="hidden" name="conList_pdesc_scpt_file_nm" value="${conList.pdesc_scpt_file_nm}">
				<input type="hidden" name="conList_hpycl_scpt_file_nm" value="${conList.hpycl_scpt_file_nm}">
				<input type="hidden" name="conList_fin_nm" value="${conList.fin_nm}">
				</c:forEach>
			</tbody>
		</table>
		<form id="frm_exl" name="frm_exl" method="post">
			<input type="hidden" name="org_cls_cd" value="${org_cls_cd}">
			<input type="hidden" name="org_fin_cd" value="${fin_cd}">
			<input type="hidden" id="org_fin_nm" name="org_fin_nm">
			<input type="hidden" name="org_req_dt" value="${req_dt}">
			<input type="hidden" name="org_prdln_cd" value="${prdln_cd}">
			<input type="hidden" name="org_scrts_no" value="${scrts_no}">
			<input type="hidden" name="org_ctt_sdate" value="${ctt_sdate}">
			<input type="hidden" name="org_ctt_edate" value="${ctt_edate}">
		</form>
		<form id="frm_anlysAll" name="frm_anlysAll" method="post" action="/tm/setAnalysisAll.do">
			<input type="hidden" name="org_cls_cd" value="${org_cls_cd}">
			<input type="hidden" name="org_fin_cd" value="${fin_cd}">
			<input type="hidden" name="org_req_dt" value="${req_dt}">
			<input type="hidden" name="org_prdln_cd" value="${prdln_cd}">
			<input type="hidden" name="org_scrts_no" value="${scrts_no}">
			<input type="hidden" name="org_ctt_sdate" value="${ctt_sdate}">
			<input type="hidden" name="org_ctt_edate" value="${ctt_edate}">
		</form>
		<form id="frm_scrDownPop" name="frm_scrDownPop" method="post" action="/tm/getScriptFileInfo.do" target="scrDownPopup">
			<input type="hidden" id="scr_spr" name="scr_spr">
			<input type="hidden" id="scr_cls_cd" name="cls_cd" value="${org_cls_cd}">
			<input type="hidden" id="scr_fin_cd" name="fin_cd" value="${fin_cd}">
			<input type="hidden" id="scr_req_dt" name="req_dt" value="${req_dt}">
			<input type="hidden" id="scr_scrts_no" name="scrts_no">
			<input type="hidden" id="scr_fin_nm" name="fin_nm">
			<input type="hidden" id="scr_pdesc_scpt_file_nm" name="pdesc_scpt_file_nm">
			<input type="hidden" id="scr_hpycl_scpt_file_nm" name="hpycl_scpt_file_nm">
		</form>
	</section>
</div>
</body>
</html>