<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ page import="java.util.*, kr.byweb.stt.demo.conf.model.*" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>녹취파일 분석기준 설정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	body {
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
	
	#wrapper li {
		display: inline;
	}
	
	#wrapper li:nth-child(2), :nth-child(5) {
		padding-right: 5px;
	}
	
	#wrapper li:nth-child(3) {
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
	
	#btn_kwdList {
		float: right;
	}
	
	#btn_kwdList input {
		margin-bottom: 10px;
	}
	
	#tbl_kwdList{
		clear: both;
		width: 100%;
	}
	
	#tbl_kwdList tr, th, td {
		border-style: solid;
		border-width: 1px;
	}
</style>
<script type="text/javascript">
var f_kwdDupYn;					//키워드 중복결과 변수
var f_arrModIdx = new Array();	//키워드목록 중 수정된 인덱스 배열
//키워드목록 조회
function fn_search() {
	if(document.getElementById("sel_kwdKnd").value != 'SEL' && document.getElementById("sel_prdln").value == 'SEL'){
		alert("상품군을 선택하세요.");
		$("#tbl_kwdList tbody tr").remove();
		$("#ta_writeKwd").val("");
		document.getElementById("sel_kwdKnd").value = 'SEL';
		document.getElementById("sel_prdln").focus();
		return;
	}else if(document.getElementById("sel_kwdKnd").value != 'SEL'){
		document.getElementById('searchFrm').submit();
	}
}

//상품군, 키워드종류 조회조건 선택여부 검사 후 키워드목록 조회
function fn_prdlnSelYn(obj) {
	if(obj.value=='SEL'){
		$("#tbl_kwdList tbody tr").remove();
		$("#ta_writeKwd").val("");
		return;
	}else{
		fn_search();
	}
}

//키워드 등록
function fn_insertKwdList(){
	//입력키워드 유효성 검사
	 if(fn_kwdValid(document.getElementById("ta_writeKwd").value)){
		//입력키워드 상품군 내 중복검사
		if(fn_kwdDupDtn()){
			document.getElementById("ins_prdln_cd").value = document.getElementById("sel_prdln").value;
			document.getElementById("ins_kwd_spr").value = document.getElementById("sel_kwdKnd").value;
			var frm = document.getElementById("insertKwdListFrm");
			frm.submit();
		}
	 }else{
		 document.getElementById("ta_writeKwd").focus();
		 return;
	 }
}

//입력키워드 선택 상품군 내 중복검사
function fn_kwdDupDtn(){
	var sel_prdln = document.getElementById("sel_prdln").value;
	var kwd_nms = document.getElementById("ta_writeKwd").value;
	$.ajax({
		type: "POST",
        url: "getKeywordDuplicationList.do",
        data: "prdln_cd="+sel_prdln+"&kwd_nms="+kwd_nms,
        dataType:"json",
        async: false,
        success: function(data) {
        	if(data != ''){
	        	alert("["+data+"]은(는) 이미 등록된 키워드입니다.");
	        	$("#ta_writeKwd").focus();
	        	f_kwdDupYn = false;
        	}else{
        		f_kwdDupYn = true;
        	}
         },
         error       :   function(request, status, error){
             console.log("AJAX_ERROR");
         }
	});
	return f_kwdDupYn;
}

//동의어관리 팝업
function fn_synPopup(kwd_nm, syn_nm, scrng_spr){
	window.open('','synPop','width=430,height=500,location=no,status=no,scrollbars=no');
	var frm_synPop = document.getElementById('frm_synPop');
	frm_synPop.method = 'post';
	frm_synPop.action = 'getSynonymKeywordList.do';
	frm_synPop.target = 'synPop';
	document.getElementById("pop_prdln_cd").value = document.getElementById("sel_prdln").value;
	document.getElementById("pop_kwd_spr").value = document.getElementById("sel_kwdKnd").value;
	document.getElementById("pop_kwd_nm").value = kwd_nm;
	document.getElementById("pop_syn_nm").value = syn_nm;
	frm_synPop.submit();
}

//배점 입력 시 사용여부 자동 변경
function fn_scrInsert(idx){
	fn_setModIdx(idx);
	if($('.scr').eq(idx).val() > 0){
		$('.sel_useYn').eq(idx).val('Y');
	}else{
		$('.sel_useYn').eq(idx).val('N');
	}
}

//배점, 범위 항목 내 정수만 입력 가능
function fn_inNumber(obj){
	var regexp = /^[0-9]*$/
	if(!regexp.test(obj.value)){
		obj.value = obj.value.replace(/[^0-9]/g,'');
	}
}

//키워드목록 전체 선택
function fn_chkAll(){
	if($('#chkAll').is(':checked')){
		$('.chk').prop("checked", true);
    } else {
        $('.chk').prop("checked", false);
    }
}

//수정된 row index를 모두 배열 저장 후 submit 시 Set()<->Array.from()으로 중복제거 후 배열 외 idx input disabled화
function fn_setModIdx(idx){
	f_arrModIdx.push(idx);
}

//입력키워드 유효성 검사
function fn_kwdValid(val){
	var resultVal = "";
	//연속된 공백을 단일 공백으로 치환
	var dblBlank = /\s\s+/gm;
	resultVal = val.replace(dblBlank," ");
	
	//전체 개행문자 제거
	var lineBrk = /\r|\n/gm;
	resultVal = resultVal.replace(lineBrk,"");
	
	//슬래시 전후 공백 제거
	var slashBlank = /\s*\/{1}\s*/gm;
	resultVal = resultVal.replace(slashBlank,"/");
	
	//콤마 전후 공백 제거
	var commaBlank = /\s*\,{1}\s*/gm;
	resultVal = resultVal.replace(commaBlank,",");
	
	//연속된 콤마 제거
	var consctvComma = /\,{2,}/gm;
	resultVal = resultVal.replace(consctvComma,",");
	/*
	//연속된 슬래시 검사
	var consctvSlash = /\/{2,}/gm;
	if(consctvSlash.test(resultVal)){
		alert("슬래시\(\"\/\"\)를 연속해서 입력할 수 없습니다.");
		return false;
	}
	
	//한글 외 문자 검사(슬래시, 콤마 제외)
	var onlyKorean = /[^가-힣\,\/ ]+/gm;
	if(onlyKorean.test(resultVal)){
		alert("키워드는 한글만 입력할 수 있습니다.");
		return false;
	}
	*/
	//각 키워드 길이검사(100byte 미만)
	var arrKwdNm = new Array();
	var arrCommaSplit = resultVal.split(",");
	for(var i in arrCommaSplit){
		if(arrCommaSplit[i].length >= 50){
			alert("키워드는 50자를 초과할 수 없습니다.");
			return false;
		}
		if(arrCommaSplit[i] != ""){
			arrKwdNm.push(arrCommaSplit[i]);
		}
	}
	
	//콤마구분 각 키워드 간 중복검사*************************************************
	
	//중복키워드 제거
	var arrSet = new Set(arrKwdNm);
	console.log(arrSet);
	console.log(Array.from(arrSet));
	
	//슬래시구분 단어 간 중복검사
	
	return true;
}

//키워드목록 수정사항 저장
function fn_saveKwdList(){
	console.log("f_arrModIdx : "+f_arrModIdx);
	var arrSet = new Set(f_arrModIdx);
	console.log("arrSet : "+arrSet);
	console.log("from : "+Array.from(arrSet));
	var arrModIdxs = Array.from(arrSet);
	var totInputLength = $("input[name=mod_kwd_nm]").length;
	for(var i=0; i<totInputLength; i++){
		console.log("i.toString() : "+i.toString());
		console.log("idxof : "+arrModIdxs.indexOf(i.toString()));
		if(arrModIdxs.indexOf(i.toString()) == -1){
			$("input[name=mod_kwd_nm]:eq("+i+")").prop("disabled",true);
			$("input[name=mod_rng]:eq("+i+")").prop("disabled",true);
			$("select[name=mod_use_yn]:eq("+i+")").prop("disabled",true);
			$("input[name=mod_scr]:eq("+i+")").prop("disabled",true);
		}
	}
	
	var frm_kwdList = document.getElementById('frm_kwdList');
	frm_kwdList.submit();
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/jsp/common/nav.jsp"></jsp:include>
<div id="wrapper">
	<section>
		<h3>녹취파일 분석기준 설정</h3>
		<form name="searchFrm" id="searchFrm" action="getAnalysisStandardList.do" method="post">
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>상품군</li>
					<li>
						<select id="sel_prdln" name="prdln_cd" onchange="fn_search();">
							<c:forEach var="prdlnMng" items="${prdlnMngVos}" begin="0" step="1">
								<c:if test="${prdlnMng.prdln_cd != 'ALL'}">
								<option value="${prdlnMng.prdln_cd}" <c:if test="${prdln_cd eq prdlnMng.prdln_cd}">selected</c:if>>${prdlnMng.prdln_nm}</option>
								</c:if>
							</c:forEach>
						</select>
					</li>
					<li>▶</li>
					<li>키워드종류</li>
					<li>
						<select id="sel_kwdKnd" name="kwd_spr" onchange="fn_prdlnSelYn(this);">
							<c:forEach var="tmCmCd" items="${tmCmCdVos}" begin="0" step="1">
								<option value="${tmCmCd.cd}" <c:if test="${kwd_spr eq tmCmCd.cd}">selected</c:if>>${tmCmCd.cd_nm}</option>
							</c:forEach>
						</select>
					</li>
				</ul>
			</div>
		</form>
		
		<div id="kwdSetBox">
			<div id="kwdSetTitle">
				<h4>[ 필수키워드 등록 ]</h4>
			</div>
			<div id="btn_kwdSet">
				<input type="button" value="키워드 등록" onclick="fn_insertKwdList();">
			</div>
			<form id="insertKwdListFrm" action="insertAnalysisStandard.do" method="post">
				<textarea id="ta_writeKwd" name="kwd_nms" rows="4" placeholder="여러 키워드 등록 시 구분자를 ','단위로 등록하세요. 한 키워드는 50자 이상을 넘을 수 없습니다.">${kwd_nms}</textarea>
				<input type="hidden" id="ins_prdln_cd" name="ins_prdln_cd">
				<input type="hidden" id="ins_kwd_spr" name="ins_kwd_spr">
			</form>
		</div>
		<div id="kwdListBox">
			<div id="kwdListTitle">
				<h4>[ 필수키워드 목록 ]</h4>
			</div>
			<div id="btn_kwdList">
				<input type="button" value="저장" onclick="fn_saveKwdList()">
				<input type="button" value="삭제">
<!-- 				<input type="button" value="동의어" onclick="fn_synPopup()"> -->
			</div>
			<form id="frm_kwdList" action="updateAnalysisStandard.do" method="post">
				<table id="tbl_kwdList">
					<thead>
						<tr>
							<th>NO</th>
							<th><input type="checkbox" id="chkAll" onclick="fn_chkAll();"></th>
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
						<c:forEach var="kwdList" items="${kwdList}" begin="0" step="1" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td><input type="checkbox" class="chk" value="${kwdList.chk_del}"></td>
							<td><input type="text" name="mod_kwd_nm" value="${kwdList.kwd_nm}" onchange="fn_setModIdx('${status.index}')"></td>
							<td onclick="fn_synPopup('${kwdList.kwd_nm}','${kwdList.syn_nm}','${kwdList.scrng_spr}')">${kwdList.syn_nm}</td>
							<td><input type="text" name="mod_rng" value="${kwdList.rng}" onkeyup="fn_inNumber(this)" onchange="fn_setModIdx('${status.index}')"></td>
							<td>
								<!-- 사용여부 수정 시 배점 미입력/0이면 수정 불가&툴팁텍스트 뜨게 -->
								<select class="sel_useYn" name="mod_use_yn" onchange="fn_setModIdx('${status.index}')">
									<option value="Y" <c:if test="${kwdList.use_yn eq 'Y'}">selected</c:if>>Y</option>
									<option value="N" <c:if test="${kwdList.use_yn eq 'N'}">selected</c:if>>N</option>
								</select>
							</td>
							<td><input type="text" name="mod_scr" class="scr" value="${kwdList.scr}" maxlength="10" onkeyup="fn_inNumber(this);" onchange="fn_scrInsert('${status.index}');"></td>
							<td>${kwdList.user_nm}(${kwdList.emp_no})</td>
							<td>${kwdList.reg_dt}</td>
						</tr>
						<input type="hidden" id="org_scrng_spr" name="org_scrng_spr" value="${kwdList.org_scrng_spr}">
						<input type="hidden" id="org_kwd_nm" name="org_kwd_nm" value="${kwdList.org_kwd_nm}">
						</c:forEach>
					
					</tbody>
				</table>
			</form>
			<form id="frm_synPop">
				<input type="hidden" id="pop_prdln_cd" name="prdln_cd">
				<input type="hidden" id="pop_kwd_spr" name="kwd_spr">
				<input type="hidden" id="pop_kwd_nm" name="kwd_nm">
				<input type="hidden" id="pop_syn_nm" name="syn_nm">
			</form>
			<form id="frm_saveKwdList">
			</form>
		</div>
	</section>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp"></jsp:include>
</div>
</body>
</html>