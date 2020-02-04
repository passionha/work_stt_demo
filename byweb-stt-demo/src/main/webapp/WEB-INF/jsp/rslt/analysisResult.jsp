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

	#tot_anlys_stts {
		white-space:nowrap;
		overflow: auto;
		height: 100px;
	}
</style>
<script type="text/javascript">
const arrUplFl = new Array();	//업로드파일 object 배열
const arrAnlys = new Array();	//분석진행상태 object 배열
const arrTotRslt = new Array();	//종합결과 object 배열

//회사별 업로드파일목록 조회
function fn_searchUplFl(){
	if(document.getElementById("sel_fin_cd").value == 'SEL'){
		$("#fin_sel_rslt").empty();
		return;
	}else{
		$("#fin_sel_rslt").empty();
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
	        	if(data != ''){
	        		var source = "";
		        	$.each(data, function(idx, item){
// 		        		console.log(data[idx]);
// 		        		console.log(item);
       					switch(item.lv){
       					case '1':
       						source="<ul><li>"
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_1\">"
								+"<input type=\"checkbox\" name=\"chk_upl_fin_nm\" id=\"chk_upl_fin_nm_"+item.fin_cd+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+item.fin_cd+idx+"\">"+item.node_nm+"</label>"
								+"<ul></ul>"
								+"</li></ul>";
							$("#fin_sel_rslt").append(source);
       						break;
       					case '2':
       						source="<li>"
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_2\">"
								+"<input type=\"checkbox\" name=\"chk_upl_req_dt\" id=\"chk_upl_fin_nm_"+item.fin_cd+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+item.fin_cd+idx+"\">"+item.node_nm+"</label>"
								+"<ul></ul>";
								+"</li>";
							$("#fin_sel_rslt > ul > li > ul").append(source);
       						break;
       					case '3':
       						var uplFlId = "uplFl"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.save_file_nm;
							uplFlId = uplFlId.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, "");
       						source="<li>"
//        							+"<input type=\"checkbox\" name=\"chk_upl_file_nm\" id=\"chk_upl_fin_nm_"+item.fin_cd+idx+"\">"
       							+"<input type=\"checkbox\" name=\"chk_upl_file_nm\" id=\"chk_"+uplFlId+"\">"
       							+"<label for=\"chk_"+uplFlId+"\">"+item.node_nm+"</label>"
								+"<input type=\"hidden\" id=\"upl_cls_cd_"+item.fin_cd+idx+"\" name=\"upl_cls_cd\" value=\""+item.cls_cd+"\">"
       							+"<input type=\"hidden\" id=\"upl_req_dept_cd_"+item.fin_cd+idx+"\" name=\"upl_req_dept_cd\" value=\""+item.req_dept_cd+"\">"
       							+"<input type=\"hidden\" id=\"upl_req_dt_"+item.fin_cd+idx+"\" name=\"upl_req_dt\" value=\""+item.req_dt+"\">"
       							+"<input type=\"hidden\" id=\"upl_fin_cd_"+item.fin_cd+idx+"\" name=\"upl_fin_cd\" value=\""+item.fin_cd+"\">"
       							+"<input type=\"hidden\" id=\"upl_save_file_nm_"+item.fin_cd+idx+"\" name=\"upl_save_file_nm\" value=\""+item.save_file_nm+"\">"
								+"</li>";
							$("#fin_sel_rslt > ul > li > ul > li:last-child > ul").append(source);
							
							//업로드파일 조회 결과 object 배열로 저장
							var dupObjCnt = 0;
							for(var i in arrUplFl){
								if(arrUplFl[i].id == uplFlId){
									dupObjCnt++;
								}
							}
							if(dupObjCnt == 0){
								var objUplFl = {
									id : uplFlId,
									cls_cd : item.cls_cd,
									req_dept_cd : item.req_dept_cd,
									fin_cd : item.fin_cd,
									req_dt : item.req_dt,
									save_file_nm : item.save_file_nm,
									chk : '0'
								}
								arrUplFl.push(objUplFl);
							}
							
							//재조회 시 기 입력 체크여부 유지
							for(var i in arrUplFl){
// 								console.log("chk : "+arrUplFl[i].chk);
								if(arrUplFl[i].chk == '1'){
									$("#chk_"+arrUplFl[i].id).prop("checked",true);
								}
							}
							
							//업로드파일목록 재조회 시 이전에 체크한 파일정보와 대조하여 체크 설정
   							/* for(var i in arrAnlys){
 								if(arrAnlys[i].cls_cd ==  item.cls_cd
 								   && arrAnlys[i].req_dept_cd ==  item.req_dept_cd
 								   && arrAnlys[i].req_dt ==  item.req_dt
 								   && arrAnlys[i].fin_cd ==  item.fin_cd
 								   && arrAnlys[i].save_file_nm ==  item.save_file_nm){
 									$("#"+"chk_upl_fin_nm_"+item.fin_cd+idx).prop("checked",true);
 								}
 							} */
       						break;
       					}
		        	});
	        	}
	         },
	         error       :   function(request, status, error){
	             console.log("AJAX_ERROR");
	         }
		});
	}
}

//전체 분석 진행상태 조회
$('body').on('change', 'input[name="chk_upl_file_nm"]', function(){
	var arrJsonObj = new Array();
	var cls_cd = $(this).siblings('input[name="upl_cls_cd"]').val();
	var req_dept_cd = $(this).siblings('input[name="upl_req_dept_cd"]').val();
	var fin_cd = $(this).siblings('input[name="upl_fin_cd"]').val();
	var flCmCd = cls_cd + req_dept_cd + fin_cd;
	flCmCd = flCmCd.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, "");
// 	alert("this id : "+$(this).prop('id'));
	//업로드파일 체크여부 저장
	if($(this).prop("checked") == true){
// 		console.log("chked");
		for(var i in arrUplFl){
			if("chk_"+arrUplFl[i].id == $(this).prop('id')){
				arrUplFl[i].chk = '1';
			}
		}
	}else{
		console.log("arrTotRslt.length : "+arrTotRslt.length);
		for(var i in arrUplFl){
			if("chk_"+arrUplFl[i].id == $(this).prop('id')){
				arrUplFl[i].chk = '0';
				for(var j in arrAnlys){
					if(arrUplFl[i].cls_cd == arrAnlys[j].cls_cd
					   && arrUplFl[i].req_dept_cd == arrAnlys[j].req_dept_cd
					   && arrUplFl[i].fin_cd == arrAnlys[j].fin_cd
					   && arrUplFl[i].req_dt == arrAnlys[j].req_dt
					   && arrUplFl[i].save_file_nm == arrAnlys[j].save_file_nm){
						arrAnlys.splice(j, 1);
					}
				}
				/* var cnt = 0;
				for(var k=0; k<arrTotRslt.length; k++){
					if(arrUplFl[i].cls_cd == arrTotRslt[k].cls_cd
					   && arrUplFl[i].req_dept_cd == arrTotRslt[k].req_dept_cd
					   && arrUplFl[i].fin_cd == arrTotRslt[k].fin_cd
					   && arrUplFl[i].req_dt == arrTotRslt[k].req_dt){
						console.log("2k : "+k);
						console.log("upl cls_cd : "+arrUplFl[i].cls_cd+" vs tot : "+arrTotRslt[k].cls_cd);
					   console.log("upl req_dept_cd : "+arrUplFl[i].req_dept_cd+" vs tot : "+arrTotRslt[k].req_dept_cd);
					   console.log("upl fin_cd : "+arrUplFl[i].fin_cd+" vs tot : "+arrTotRslt[k].fin_cd);
					   console.log("upl req_dt : "+arrUplFl[i].req_dt+" vs tot : "+arrTotRslt[k].req_dt);
					   arrTotRslt.splice(k, 1);
					}
				} */
				/*for(var k in arrTotRslt){
					console.log("1k : "+k);
// 					console.log("tot : "+arrTotRslt[k].cls_cd);
// 				   console.log("tot : "+arrTotRslt[k].req_dept_cd);
// 				   console.log("tot : "+arrTotRslt[k].fin_cd);
// 				   console.log("tot : "+arrTotRslt[k].req_dt);
				   console.log(arrUplFl[i].cls_cd == arrTotRslt[k].cls_cd
						   && arrUplFl[i].req_dept_cd == arrTotRslt[k].req_dept_cd
						   && arrUplFl[i].fin_cd == arrTotRslt[k].fin_cd
						   && arrUplFl[i].req_dt == arrTotRslt[k].req_dt);
					
					if(arrUplFl[i].cls_cd == arrTotRslt[k].cls_cd
					   && arrUplFl[i].req_dept_cd == arrTotRslt[k].req_dept_cd
					   && arrUplFl[i].fin_cd == arrTotRslt[k].fin_cd
					   && arrUplFl[i].req_dt == arrTotRslt[k].req_dt){
						console.log("2k : "+k);
						console.log("upl cls_cd : "+arrUplFl[i].cls_cd+" vs tot : "+arrTotRslt[k].cls_cd);
					   console.log("upl req_dept_cd : "+arrUplFl[i].req_dept_cd+" vs tot : "+arrTotRslt[k].req_dept_cd);
					   console.log("upl fin_cd : "+arrUplFl[i].fin_cd+" vs tot : "+arrTotRslt[k].fin_cd);
					   console.log("upl req_dt : "+arrUplFl[i].req_dt+" vs tot : "+arrTotRslt[k].req_dt);
					   arrTotRslt.splice(k, 1);
					}
				}*/
				console.log("cnt : "+cnt);
			}
		}
		console.log("arrAnlys length: "+arrAnlys.length);
		console.log("arrTotRslt length: "+arrTotRslt.length);
		/*for(var j in arrAnlys){
			console.log("남은 arrAnlys : "+arrAnlys[j].save_file_nm);
		}*/
		if(arrTotRslt.length > 0){
			for(var k in arrTotRslt){
				console.log("남은 arrTotRslt : "+arrTotRslt[k].req_dt);
			}
		}
	}
	
	if($('input[name="chk_upl_file_nm"]:checked').length > 0){
		$('input[name="chk_upl_file_nm"]:checked').each(function(index, item){
			var jsonObj = {
				cls_cd : $(this).siblings('input[name="upl_cls_cd"]').val(),
				req_dept_cd : $(this).siblings('input[name="upl_req_dept_cd"]').val(),
				req_dt : $(this).siblings('input[name="upl_req_dt"]').val(),
				fin_cd : $(this).siblings('input[name="upl_fin_cd"]').val(),
				save_file_nm : $(this).siblings('input[name="upl_save_file_nm"]').val()
			}
			arrJsonObj.push(jsonObj);
		});
		$.ajax({
			type: "POST",
	        url: "getAnlySttsList.do",
	        contentType:'application/json; charset=UTF-8',
	        data:JSON.stringify(arrJsonObj),
	        dataType:"json",
	        async: false,
	        success: function(data) {
	        	if(data != ''){
	        		$("#tot_anlys_stts > table > tbody > tr[id^=anlys"+flCmCd+"]").remove();
//	         		$('tr[id^='+trId+']').css( "color", "green" );
		        	$.each(data, function(idx, item){
		        		var anlysId = "anlys"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.save_file_nm;
		        		anlysId = anlysId.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, "");
//			        		idStr = $.escapeSelector(idStr);
		        		var source = "<tr id=\""+anlysId+"\">"
			        		+"<td>"+item.fin_nm+"</td>"
			        		+"<td>"+item.req_dt+"</td>"
			        		+"<td>"+item.upl_file_nm+"</td>"
			        		+"<td>"+item.trns_stts_nm+"</td>"
			        		+"</tr>";
		        		$("#tot_anlys_stts > table > tbody").append(source);
		        		
						//분석진행상태 조회결과 object 배열로 저장
		        		var dupObjCnt = 0;
						for(var i in arrAnlys){
							if(arrAnlys[i].id == anlysId){
								dupObjCnt++;
							}
						}
						if(dupObjCnt == 0){
							var objAnlys = {
			        				id : anlysId,
									cls_cd : item.cls_cd,
									req_dept_cd : item.req_dept_cd,
									fin_cd : item.fin_cd,
									req_dt : item.req_dt,
									save_file_nm : item.save_file_nm
							}
							console.log("input objAnlys : "+objAnlys);
		 					arrAnlys.push(objAnlys);
						}
		        	});
	        		//종합결과 조회
 	        		fn_searchTotRslt(arrJsonObj, flCmCd);
	        	}
	         },
	         error       :   function(request, status, error){
	             console.log("AJAX_ERROR");
	         }
		});
	}else{
		$("#tot_anlys_stts > table > tbody > tr[id^=anlys"+flCmCd+"]").remove();
		$("#tot_rslt > table > tbody > tr[id^=totRslt"+flCmCd+"]").remove();
	}
	
	
});

//종합결과 조회
function fn_searchTotRslt(pObj, flCmCd){
	$.ajax({
		type: "POST",
        url: "getTotalInspectoinList.do",
        contentType:'application/json; charset=UTF-8',
        data:JSON.stringify(pObj),
        dataType:"json",
        async: false,
        success: function(data) {
        	if(data != ''){
// 				console.log(data);        		
        		$("#tot_rslt > table > tbody > tr[id^=totRslt"+flCmCd+"]").remove();
	        	$.each(data, function(idx, item){
	        		//체크한 파일별 id생성(권역코드+요청부서코드+회사코드+요청일자+저장파일명)
	        		var idStr = "totRslt"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.prdln_cd;
	        		idStr = idStr.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, "");
// 					console.log("rslt id : "+idStr);
	        		var source = "<tr id=\""+idStr+"\" ondblclick=\"fn_searchSttRslt()\">"
		        		+"<td>"+item.fin_nm+"</td>"
		        		+"<td>"+item.req_dt+"</td>"
		        		+"<td>"+item.prdln_nm+"</td>"
		        		+"<td>"+item.auto_avg+"</td>"
		        		+"<td>"+item.manual_avg+"</td>"
		        		+"</tr>";
	        		$("#tot_rslt > table > tbody").append(source);
					//종합결과 조회결과 object 배열로 저장
	        		var objTotRslt = {
	        				id : idStr,
							cls_cd : item.cls_cd,
							req_dept_cd : item.req_dept_cd,
							fin_cd : item.fin_cd,
							req_dt : item.req_dt,
							prdln_cd : item.prdln_cd
					}
	        		arrTotRslt.push(objTotRslt);
	        	});
        	}
         },
         error       :   function(request, status, error){
             console.log("AJAX_ERROR");
         }
	});
}

//텍스트 변환결과 및 계약별 결과 조회 
function fn_searchSttRslt(){
	
}

/*
//트리뷰 +,-이미지 클릭
function fn_foldClick(lv, idx){
	if($('input[name="chk_hid_lv_'+lv+'"]').eq(idx).prop("checked") == true){
		$('input[name="chk_hid_lv_'+lv+'"]').eq(idx).children('ul').css( 'display', 'none' );
		console.log($('input[name="chk_hid_lv_'+lv+'"]').eq(idx).children('ul'));
		$('input[name="chk_hid_lv_'+lv+'"]').eq(idx).prop("checked",false);
	}else{
		$('input[name="chk_hid_lv_'+lv+'"]').eq(idx).prop("checked",true);
	}
}*/
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
						<select id="sel_fin_cd" name="sel_fin_cd" onchange="fn_searchUplFl()">
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
			<div id="fin_sel_rslt"></div>
		</div>
		<div id="right_side">
			<div id="tot_anlys_stts">
				<h5>> 전체 분석 진행상태</h5>
				<input type="button" value="분석">
				<table>
					<thead>
						<tr>
							<th>회사명</th>
							<th>요청일</th>
							<th>파일명</th>
							<th>STT진행상태</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div id="tot_rslt">
				<h5>> 종합결과 조회</h5>
				<input type="button" value="엑셀">
				<table>
					<thead>
					<tr>
						<th>회사명</th>
						<th>요청일</th>
						<th>상품군</th>
						<th>자동평균</th>
						<th>수동평균</th>
					</tr>
					</thead>
					<tbody></tbody>
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