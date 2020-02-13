<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	#left_side {
		float: left;
	}
	
	#div_sttRslt {
		float: right;
	}
	
	table, th, td {
		border: 2px solid lightgrey;
	}
	
	input[type="button"], input[type="checkbox"], label {
		float: right;
	}
	
	table {
		clear: both;
	}
	
	#div_omsEsnKwd {
		float: left;
	}
	
	h5 {
		display: inline;
	}
	
	#left_side p {
		display: inline;
		font-size: 11px;
		color: red;
	}
	
	#div_refRcdFl {
		float: right;
	}
	
	.search_kwd {
		background-color : yellow;
	}
	
	#pText {
		border: 2px solid lightgrey;
		background-color : white;
 		white-space: pre-line;
 		overflow: auto;
		width: 600px;
		height: 220px;
	}
</style>
<script type="text/javascript">
//수동 검수결과 및 불완전판매 여부 저장
function fn_save_inspcRslt(){
	if(confirm("수동검수 결과 및 불완전판매 여부를 저장하시겠습니까?")){
		var missellYn = $('#chk_missellYn').prop('checked') == true ? "Y" : "N";
		var pObj = {
			cls_cd : 	   $('#inspc_cls_cd').val(),
			req_dept_cd :  $('#inspc_req_dept_cd').val(),
			req_dt : 	   $('#inspc_req_dt').val(),
			fin_cd : 	   $('#inspc_fin_cd').val(),
			prdln_cd : 	   $('#inspc_prdln_cd').val(),
			scrts_no : 	   $('#inspc_scrts_no').val(),
			missell_yn :   missellYn,
			scr : 		   $('#manual_scr').val(),
			esn_kwd_num :  $('#manual_esn_kwd_num').val(),
			omsn_kwd_num : $('#manual_omsn_kwd_num').val(),
			esn_kwd_scr :  $('#manual_esn_kwd_scr').val(),
			bnwd_cnt : 	   $('#manual_bnwd_cnt').val(),
			bnwd_scr :     $('#manual_bnwd_scr').val()
		}
		$.ajax({
			type: "POST",
	        url: "insertInspectionResult.do",
	        data: JSON.stringify(pObj),
	        contentType:'application/json; charset=UTF-8',
	        dataType:"json",
	        async: false,
	        success: function(data) {
	        	alert("저장되었습니다.");
        		$("#td_manual_scr").html(data);
	         },
	         error       :   function(request, status, error){
	             console.log("AJAX_ERROR");
	         }
		});
	}
}

//텍스트 변환 결과 내 키워드 검색
function fn_searchKwd(){
	var txt = $('#org_TEXT').val();
	arrKwd = $('#searchKwd').val().split(' ');
	for(var i in arrKwd){
		if(arrKwd[i]){
			var regex = new RegExp(arrKwd[i],'gi');
			txt = txt.replace(regex, "<span class='search_kwd'>"+arrKwd[i]+"</span>");
		}
	}
	$('#pText').html(txt);
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
			<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-03-01" />
			<c:forEach var="navTitles" items="${sessionScope.navTitles}">
				<c:if test="${navTitles.menu_id eq navMenuId}">
					<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<h3>${sectionTitle}</h3>
		</div>
		<div>
			<h5>> 계약정보</h5>
			<table>
				<thead>
					<tr>
						<td>회사명</td>
						<td>상품군</td>
						<td>증권번호</td>
						<td>상품명</td>
						<td>계약일</td>
						<td>계약상태</td>
						<td>계약자명</td>
						<td>자동점수</td>
						<td>수동점수</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${cttInfo.fin_nm}</td>
						<td>${cttInfo.prdln_nm}</td>
						<td>${cttInfo.scrts_no}</td>
						<td>${cttInfo.prd_nm}</td>
						<td>${cttInfo.ctt_dt}</td>
						<td>${cttInfo.ctt_stts}</td>
						<td>${cttInfo.cttor_nm}</td>
						<td>${cttInfo.auto_scr}</td>
						<td id="td_manual_scr">${cttInfo.manual_scr}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div id="div_inspcRslt">
			<input type="hidden" id="inspc_cls_cd" value="${cttInfo.cls_cd}">
			<input type="hidden" id="inspc_req_dept_cd" value="${cttInfo.req_dept_cd}">
			<input type="hidden" id="inspc_req_dt" value="${cttInfo.req_dt}">
			<input type="hidden" id="inspc_fin_cd" value="${cttInfo.fin_cd}">
			<input type="hidden" id="inspc_prdln_cd" value="${cttInfo.prdln_cd}">
			<input type="hidden" id="inspc_scrts_no" value="${cttInfo.scrts_no}">
			<h5>> 검수결과</h5>
			<input type="button" value="저장" onclick="fn_save_inspcRslt()">
			<c:set var="addManualInspcSpr" value="true"/>
			<c:set var="missellYnChk" value="false"/>
			<c:forEach var="inspcList" items="${inspcList}">
				<c:if test="${inspcList.inspc_spr eq '2'}">
					<c:set var="addManualInspcSpr" value="false"/>
				</c:if>
				<c:if test="${inspcList.missell_yn eq 'Y'}">
					<c:set var="chkMissellYn" value="true"/>
				</c:if>
			</c:forEach>
			<input type="checkbox" id="chk_missellYn" name="missell_yn" <c:if test="${chkMissellYn}">checked</c:if>>
			<label for="chk_missellYn">불완전판매 여부</label>
			<table>
				<thead>
					<tr>
						<td>검수결과 점수</td>
						<td>필수키워드</td>
						<td>누락키워드</td>
						<td>필수키워드 점수</td>
						<td>금지어</td>
						<td>금지어 점수</td>
						<td>검수구분</td>
					</tr>
				</thead>
				<tbody>	
					<c:forEach var="inspcList" items="${inspcList}">
						<c:if test="${inspcList.inspc_spr eq '1'}">
							<tr>
								<td>${inspcList.scr}</td>
								<td>${inspcList.esn_kwd_num}</td>
								<td>${inspcList.omsn_kwd_num}</td>
								<td>${inspcList.esn_kwd_scr}</td>
								<td>${inspcList.bnwd_cnt}</td>
								<td>${inspcList.bnwd_scr}</td>
								<td>${inspcList.inspc_spr_nm}</td>
							</tr>
						</c:if>
						<c:choose>
							<c:when test="${addManualInspcSpr}">
								<tr>
									<td><input type="text" id="manual_scr"></td>
									<td><input type="text" id="manual_esn_kwd_num"></td>
									<td><input type="text" id="manual_omsn_kwd_num"></td>
									<td><input type="text" id="manual_esn_kwd_scr"></td>
									<td><input type="text" id="manual_bnwd_cnt"></td>
									<td><input type="text" id="manual_bnwd_scr"></td>
									<td>수동</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:if test="${inspcList.inspc_spr eq '2'}">
									<tr>
										<td><input type="text" id="manual_scr" value="${inspcList.scr}"></td>
										<td><input type="text" id="manual_esn_kwd_num" value="${inspcList.esn_kwd_num}"></td>
										<td><input type="text" id="manual_omsn_kwd_num" value="${inspcList.omsn_kwd_num}"></td>
										<td><input type="text" id="manual_esn_kwd_scr" value="${inspcList.esn_kwd_scr}"></td>
										<td><input type="text" id="manual_bnwd_cnt" value="${inspcList.bnwd_cnt}"></td>
										<td><input type="text" id="manual_bnwd_scr" value="${inspcList.bnwd_scr}"></td>
										<td>${inspcList.inspc_spr_nm}</td>
									</tr>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="left_side">
			<div id="div_esnKwdUse">
				<h5>> 필수키워드 사용</h5>
				<p>키워드 더블클릭 시 텍스트 검색, 출현시간 더블클릭 시 녹취파일 재생</p>
				<table>
					<thead>
						<tr>
							<td>파일명</td>
							<td>키워드</td>
							<td colspan="${esnKwdTmCnt}">출현시간</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="eList" items="${esnKwdList}" step="1">
						<tr>
							<td>${eList.RCD_FILE_NM}</td>
							<td>${eList.KWD_NM}</td>
							<c:forEach var="i" begin="1" end="${esnKwdTmCnt}">
							<c:set var="eti_dt">T${i}_DT</c:set>
							<td>${eList[eti_dt]}</td>
							</c:forEach>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div id="div_banKwdUse">
				<h5>> 금지어 사용</h5>
				<p>키워드 더블클릭 시 텍스트 검색, 출현시간 더블클릭 시 녹취파일 재생</p>
				<table>
					<thead>
						<tr>
							<td>파일명</td>
							<td>키워드</td>
							<td colspan="${banKwdTmCnt}">출현시간</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bList" items="${banKwdList}" step="1">
						<tr>
							<td>${bList.RCD_FILE_NM}</td>
							<td>${bList.KWD_NM}</td>
							<c:forEach var="i" begin="1" end="${banKwdTmCnt}">
							<c:set var="bti_dt">T${i}_DT</c:set>
							<td>${bList[bti_dt]}</td>
							</c:forEach>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div id="div_omsEsnKwd">
				<h5>> 누락된 필수키워드</h5>
				<table>
					<thead>
						<tr>
							<td>필수키워드</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="oList" items="${omsnKwdList}" step="1">
						<tr>
							<td>${oList.kwd_nm}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div id="div_refRcdFl">
				<h5>> 관련 녹취파일</h5>
				<input type="button" value="재생">
				<table>
					<thead>
						<tr>
							<td>파일명</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rList" items="${rcdFlList}" step="1">
						<tr>
							<td>${rList.file_nm}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div id="div_sttRslt">
			<h5>> 텍스트 변환 결과</h5>
			<div>
				<input type="text" id="searchKwd">
				<input type="button" value="저장">
				<input type="button" value="검색" onclick="fn_searchKwd()">
			</div>
<%-- 			<textarea id="txt_sttRslt" wrap="hard">${TEXT}</textarea> --%>
			<p id="pText">${TEXT}</p>
			<input type="hidden" id="org_TEXT" value="${TEXT}">
		</div>
	</section>
</div>
</body>
</html>