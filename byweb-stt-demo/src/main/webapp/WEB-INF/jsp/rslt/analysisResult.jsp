<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, kr.byweb.stt.demo.cm.model.*" %>
<%
	String sectionTitle = "";
	String sel_req_cd = (String)session.getAttribute("sel_req_cd");
	String contentPage = (String)request.getAttribute("contentPage");
	List<TmCmCdVo> headerTitles = (List<TmCmCdVo>)session.getAttribute("headerTitles");
	List<TmCmCdVo> navTitles = (List<TmCmCdVo>)session.getAttribute("navTitles");
	
	Iterator<TmCmCdVo> hdIt = headerTitles.iterator();
	TmCmCdVo hdTitleInfo;
	while(hdIt.hasNext()){
		hdTitleInfo = hdIt.next();
		if(hdTitleInfo.getMenu_id().equals(sel_req_cd)){
			sectionTitle = hdTitleInfo.getMenu_nm().toString();
		}
	}
	Iterator<TmCmCdVo> navIt = navTitles.iterator();
	TmCmCdVo navTitleInfo;
	while(navIt.hasNext()){
		navTitleInfo = navIt.next();
		if(navTitleInfo.getMenu_id().equals(sel_req_cd.toString()+"-03")){
			sectionTitle += " > "+navTitleInfo.getMenu_nm().toString();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과 확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
	#upl_file_sel {
  		float: left;
  		width: 20%;
  		height: 90%;
  		border: 1px solid blue;
	}
	#sel_fin_nm {
		height: 14%;
	}
	#sel_fin_nm ul {
		border: 3px solid #00b0f0;
	}
	#right_side {
		width: 78%;
		border: 1px solid red;
		float: right;
	}
	#fin_sel_rslt {
		border: 2px solid lightgrey;
	}
	#right_side table {
		width: 100%
	}
	#right_side table, th, td{
		border: 2px solid lightgrey;
	}
	#right_side div input[type="button"] {
 		float: right;
	}
	#right_side div h5, input{
		display: inline;
	}
	#srch_con_rslt ul {
		border: 3px solid #00b0f0;
	}
	
    #fin_sel_rslt input[name^=chk_hid_lv_] {
        display:none;
    }
/*
	#fin_sel_rslt input[name^=chk_hid_lv_]:checked ~ul {
        display: none;
    }
*/
</style>
<script type="text/javascript">
//업로드파일 조회
function fn_selFin(){
	if(document.getElementById("sel_fin_cd").value == 'SEL'){
		$("#fin_sel_rslt").children().remove();
// 		return;
	}else{
		var idx = $("#sel_fin_cd option").index( $("#sel_fin_cd option:selected") );
		document.getElementById("upl_class_cd").value = $('input[name="fin_cls_cd"]').eq(idx).val();
		document.getElementById('frm_getUplList').submit();
	}
}

//트리뷰 +,-이미지 클릭
function fn_foldClick(lv, idx){
	if($('input[name="chk_hid_lv_'+lv+'"]').eq(idx).prop("checked") == true){
		$('input[name="chk_hid_lv_'+lv+'"]').eq(idx).children('ul').css( 'display', 'none' );
		console.log($('input[name="chk_hid_lv_'+lv+'"]').eq(idx).children('ul'));
		$('input[name="chk_hid_lv_'+lv+'"]').eq(idx).prop("checked",false);
	}else{
		$('input[name="chk_hid_lv_'+lv+'"]').eq(idx).prop("checked",true);
	}
}
</script>
</head>
<body>
<div id="wrap">
	<section>
		<h3><%=sectionTitle%></h3>
		<div id="upl_file_sel">
			<form id="frm_getUplList" action="getAnlysRsltList.do" method="post">
			<input type="hidden" id="upl_class_cd" name="upl_class_cd">
			<div id="sel_fin_nm">
				<h5>> 업로드파일 선택</h5>
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="sel_fin_cd" onchange="fn_selFin()">
							<option value="SEL" <c:if test="${fin_cd eq ''}">selected</c:if>>선택</option>
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
				</ul>
			</div>
			</form>
			<div id="fin_sel_rslt">
				<ul>
					<li>
						<c:forEach var="uplList" items="${uplList}" begin="0" step="1" varStatus="status">
						<c:if test="${uplList.lv eq '1'}">
						<input type="checkbox" name="chk_hid_lv_1">
						<img onclick="fn_foldClick('1', ${status.index})" src="/user/images/icon_plus.jpg">
						<input type="checkbox" id="upl_fin_nm">
						<label for="upl_fin_nm">${uplList.node_nm}</label>
						</c:if>
						<ul>
							<li>
								<c:if test="${uplList.lv eq '2'}">
								<input type="checkbox" name="chk_hid_lv_2">
								<img onclick="fn_foldClick('2', ${status.index})" src="/user/images/icon_plus.jpg">
								<input type="checkbox" id="upl_req_dt">
								<label for="upl_req_dt">${uplList.node_nm}</label>
								</c:if>
								<ul>
									<c:if test="${uplList.lv eq '3'}">
									<li>
										<input type="checkbox" id="chk_[]status1">
										<label for="chk_[]status1">${uplList.node_nm}</label>
									</li>
									</c:if>
								</ul>
							</li>
						</ul>
						</c:forEach>
					</li>
				</ul>
			</div>
		</div>
		<div id="right_side">
			<div id="tot_anlys_stts">
				<h5>> 전체 분석 진행상태</h5>
				<input type="button" value="분석">
				<table>
					<tr>
						<th>회사명</th>
						<th>요청일</th>
						<th>파일명</th>
						<th>STT진행상태</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="tot_rslt">
				<h5>> 종합결과 조회</h5>
				<input type="button" value="엑셀">
				<table>
					<tr>
						<th>회사명</th>
						<th>요청일</th>
						<th>상품군</th>
						<th>자동평균</th>
						<th>수동평균</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="txt_stt_rslt">
				<h5>> 텍스트 변환결과 다운로드</h5>
				<input type="button" value="파일다운">
				<table>
					<tr>
						<th><input type="checkbox"></th>
						<th>회사명</th>
						<th>요청일</th>
						<th>상품군</th>
						<th>증권번호</th>
						<th>자동점수</th>
						<th>수동점수</th>
					</tr>
					<tr>
						<td><input type="checkbox"></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="con_rslt">
				<h5>> 계약별 결과 조회</h5>
				<div id="srch_con_rslt">
					<ul>
						<li>▶</li>
						<li>증권번호</li>
						<li><input type="text"></li>
						<li><input type="button" value="조회"></li>
						<li><input type="button" value="엑셀"></li>
					</ul>
				</div>
				<table>
					<tr>
						<th>회사명</th>
						<th>요청일</th>
						<th>상품군</th>
						<th>증권번호</th>
						<th>상품명</th>
						<th>계약일</th>
						<th>계약상태</th>
						<th>계약자명</th>
						<th>자동점수</th>
						<th>수동점수</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
	</section>
</div>	
</body>
</html>