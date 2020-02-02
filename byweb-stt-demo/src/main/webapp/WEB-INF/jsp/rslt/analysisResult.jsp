<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, kr.byweb.stt.demo.cm.model.*" %>
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
	
	#fin_sel_rslt {
		white-space:nowrap;
		overflow: auto;
		width: 240px;
		height: 360px;
	}
	
	#fin_sel_rslt ul li {
		display: block;
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
		$("#fin_sel_rslt").empty();
		return;
	}else{
		var idx = $("#sel_fin_cd option").index( $("#sel_fin_cd option:selected") );
		document.getElementById("upl_class_cd").value = $('input[name="fin_cls_cd"]').eq(idx).val();
		$.ajax({
			type: "POST",
	        url: "getUplFileList.do",
	        data: {
	        	sel_fin_cd : $("#sel_fin_cd option:selected").val(),
	        	upl_class_cd : $('input[name="fin_cls_cd"]').eq(idx).val()
	        },
	        dataType:"json",
	        async: false,
	        success: function(data) {
	        	console.log("data");
	        	if(data != ''){
	        		var source = "";
	        		var src_fin_nm = "";
	        		var src_req_dt = "";
	        		var scr_file_nm = "";
		        	$.each(data, function(idx, item){
// 		        		console.log(data[idx]);
// 		        		console.log(item);

       					switch(item.lv){
       					case '1':
       						source="<ul><li>"+
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_1\">"
								+"<input type=\"checkbox\" name=\"chk_upl_fin_nm\" id=\"chk_upl_fin_nm_"+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+idx+"\">"+item.node_nm+"</label>"
								+"<div id=\""+item.fin_cd+"\"></div>"
								+"</li></ul>"
							$("#fin_sel_rslt").append(source);
       						break;
       					case '2':
       						source="<ul><li>"
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_2\">"
								+"<input type=\"checkbox\" name=\"chk_upl_fin_nm\" id=\"chk_upl_fin_nm_"+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+idx+"\">"+item.node_nm+"</label>"
								+"<div id=\""+item.fin_cd+"\"></div>"
								+"</li></ul>"
       						break;
       					case '3':
       						/*source="<ul><li>"
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_2\">"
								+"<input type=\"checkbox\" name=\"chk_upl_fin_nm\" id=\"chk_upl_fin_nm_"+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+idx+"\">"+item.node_nm+"</label>"
								+"<div id=\"div_file_nm\"></div>"
								+"</li></ul>"
								*/
       						break;
       					}
		        	});
// 		        	source="<ul><li>"+
// 		        	+"<div id=\"div_req_dt\"></div>"
// 		        	+"</li></ul>"
		        	
// 		        	$("#div_req_dt").append(source);
// 		        	$("#div_req_dt").append(source);
					
					
					
	        	}
	         },
	         error       :   function(request, status, error){
	             console.log("AJAX_ERROR");
	         }
		});
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
		<c:forEach var="headerTitles" items="${sessionScope.headerTitles}">
			<c:if test="${headerTitles.menu_id eq sessionScope.sel_req_cd}">
				<c:set var="hdTitle" value="${headerTitles.menu_nm}"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-03" />
		<c:forEach var="navTitles" items="${sessionScope.navTitles}">
			<c:if test="${navTitles.menu_id eq navMenuId}">
				<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
			</c:if>
		</c:forEach>
		<h3>${sectionTitle}</h3>
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
			<!-- 
				<ul>
					<li>
						<input type="checkbox" name="chk_hid_lv_1">
						<input type="checkbox" name="chk_upl_fin_nm" id="chk_upl_fin_nm_idx">
						<label for="chk_upl_fin_nm_idx">금융감독원관리자</label>
						<ul>
							<li>
								<input type="checkbox" name="chk_hid_lv_2">
								<input type="checkbox" name="chk_upl_req_dt">
								20200130
								
								<ul>
									<li>
										<input type="checkbox" name="chk_upl_file">
										금감원_녹취_3.zip
									</li>
								</ul>
								
							</li>
							<li>
								<input type="checkbox" name="chk_hid_lv_2">
								<input type="checkbox" name="chk_upl_req_dt">
								20190920
								
								<ul>
									<li>
										<input type="checkbox" name="chk_upl_file">
										금감원_녹취_1.zip
									</li>
									<li>
										<input type="checkbox" name="chk_upl_file">
										금감원_녹취_2.zip
									</li>
								</ul>
								
							</li>
						</ul>
						
					</li>
				</ul>
				 -->
				<%-- 
				<ul>
					<li>
						<input type="checkbox" name="chk_hid_lv_1">
						<img onclick="fn_foldClick('1', ${status.index})" src="/user/images/icon_plus.jpg">
						<input type="checkbox" id="upl_fin_nm">
						<label for="upl_fin_nm">${uplList.node_nm}</label>
						<ul>
							<li>
								<input type="checkbox" name="chk_hid_lv_2">
								<img onclick="fn_foldClick('2', ${status.index})" src="/user/images/icon_plus.jpg">
								<input type="checkbox" id="upl_req_dt">
								<label for="upl_req_dt">${uplList.node_nm}</label>
								<ul>
									<li>
										<input type="checkbox" id="chk_[]status1">
										<label for="chk_[]status1">${uplList.node_nm}</label>
									</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul> --%>
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