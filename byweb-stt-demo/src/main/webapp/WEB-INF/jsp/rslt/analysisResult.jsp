<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, kr.byweb.stt.demo.cm.model.*" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	
	#right_side input[type="button"] {
		float: right;
	}
	
	#right_side h5, input{
		display: inline;
	}
	
	#srch_ctt_rslt ul {
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

	#tot_anlys_stts_cont, #tot_rslt_cont, #txt_stt_rslt_cont, #ctt_rslt_cont {
		white-space:nowrap;
		overflow: auto;
		height: 100px;
		width: 100%;
		border: 1px solid blue;
	}
	
</style>
<script type="text/javascript">
const f_arrUplFl = new Array();		//업로드파일 object 배열
const f_arrAnlys = new Array();		//분석진행상태 object 배열
const f_arrTotRslt = new Array();	//종합결과 object 배열
const f_arrCttRslt = new Array();	//계약별결과 object 배열
var f_srch_Scrts_no = "";			//계약별 결과 조회 시 증권번호 조회조건 저장 변수

//업로드파일 회사명 체크/체크해제에 따른 하위노드 체크/체크해제
$('body').on('change', '#fin_sel_rslt input[type="checkbox"]', function(){
	var elmt_nm = $(this).prop('name')
	if($(this).prop('checked') == true){
		switch(elmt_nm){
			case 'chk_upl_fin_nm':
				$('#fin_sel_rslt input[type="checkbox"]').prop("checked",true);
				break;
			case 'chk_upl_req_dt':
				$(this).siblings('ul').children('li').children('input[type="checkbox"]').prop("checked",true);
				//모든 요청부서노드 체크 시 회사명노드 체크 추가 필요**************************
				break;
			case 'chk_upl_file_nm':
				//해당 요청부서노드 내 모든 파일명노드 체크 시 해당 요청부서노드 체크 추가 필요**************************
// 				console.log($(this).parents('li').siblings('li').children('input[type="checkbox"]').prop('checked'));
// 				if($(this).siblings('input[type="checkbox"]').prop('checked') == true){
					
// 				}
				break;
		}
	}else{
		switch(elmt_nm){
			case 'chk_upl_fin_nm':
				$('#fin_sel_rslt input[type="checkbox"]').prop("checked",false);	
				break;
			case 'chk_upl_req_dt':
				$(this).siblings('ul').children('li').children('input[type="checkbox"]').prop("checked",false);
				$(this).parents('ul').siblings('input[type="checkbox"]').prop("checked",false);
				break;
			case 'chk_upl_file_nm':
				$(this).parents('ul').siblings('input[type="checkbox"]').prop("checked",false);
				break;
		}
	}
});

//회사별 업로드파일목록 조회
function fn_search_uplFl(){
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
       					switch(item.lv){
       					case '1':
       						source="<ul><li>"
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_1\">"
								+"<input type=\"checkbox\" name=\"chk_upl_fin_nm\" id=\"chk_upl_fin_nm_"+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+idx+"\">"+item.node_nm+"</label>"
								+"<ul></ul>"
								+"</li></ul>";
							$("#fin_sel_rslt").append(source);
       						break;
       					case '2':
       						source="<li>"
       							+"<input type=\"checkbox\" name=\"chk_hid_lv_2\">"
								+"<input type=\"checkbox\" name=\"chk_upl_req_dt\" id=\"chk_upl_fin_nm_"+idx+"\">"
								+"<label for=\"chk_upl_fin_nm_"+idx+"\">"+addDashDate(item.node_nm)+"</label>"
								+"<ul></ul>";
								+"</li>";
							$("#fin_sel_rslt > ul > li > ul").append(source);
       						break;
       					case '3':
       						var uplFlId = removeSpcChar("uplFl"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.save_file_nm);
       						source="<li>"
       							+"<input type=\"checkbox\" name=\"chk_upl_file_nm\" id=\"chk_"+uplFlId+"\">"
       							+"<label for=\"chk_"+uplFlId+"\">"+item.node_nm+"</label>"
								+"<input type=\"hidden\" id=\"upl_cls_cd_"+idx+"\" name=\"upl_cls_cd\" value=\""+item.cls_cd+"\">"
       							+"<input type=\"hidden\" id=\"upl_req_dept_cd_"+idx+"\" name=\"upl_req_dept_cd\" value=\""+item.req_dept_cd+"\">"
       							+"<input type=\"hidden\" id=\"upl_req_dt_"+idx+"\" name=\"upl_req_dt\" value=\""+item.req_dt+"\">"
       							+"<input type=\"hidden\" id=\"upl_fin_cd_"+idx+"\" name=\"upl_fin_cd\" value=\""+item.fin_cd+"\">"
       							+"<input type=\"hidden\" id=\"upl_save_file_nm_"+idx+"\" name=\"upl_save_file_nm\" value=\""+item.save_file_nm+"\">"
								+"</li>";
							$("#fin_sel_rslt > ul > li > ul > li:last-child > ul").append(source);
							
							//업로드파일 조회 결과 object 배열로 저장
							var dupObjCnt = 0;
							for(var i in f_arrUplFl){
								if(f_arrUplFl[i].id == uplFlId){
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
								f_arrUplFl.push(objUplFl);
							}
							
							//업로드파일 재조회 시 기 입력한 체크여부 유지
							for(var i in f_arrUplFl){
								if(f_arrUplFl[i].chk == '1'){
									$("#chk_"+f_arrUplFl[i].id).prop("checked",true);
								}
							}
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
	var flCmCd = removeSpcChar(cls_cd+req_dept_cd+fin_cd);
	//업로드파일 체크여부 저장
	if($(this).prop("checked") == true){
		for(var i in f_arrUplFl){
			if("chk_"+f_arrUplFl[i].id == $(this).prop('id')){
				f_arrUplFl[i].chk = '1';
			}
		}
	}else{
		for(var i in f_arrUplFl){
			if("chk_"+f_arrUplFl[i].id == $(this).prop('id')){
				f_arrUplFl[i].chk = '0';
				//체크해제한 업로드파일에 대한 분석진행상태object 배열에서 삭제
				for(var j=0; j<f_arrAnlys.length; j++){
					if(f_arrUplFl[i].cls_cd == f_arrAnlys[j].cls_cd
					   && f_arrUplFl[i].req_dept_cd == f_arrAnlys[j].req_dept_cd
					   && f_arrUplFl[i].fin_cd == f_arrAnlys[j].fin_cd
					   && f_arrUplFl[i].req_dt == f_arrAnlys[j].req_dt
					   && f_arrUplFl[i].save_file_nm == f_arrAnlys[j].save_file_nm){
						f_arrAnlys.splice(j, 1);
						j--;
					}
				}
				//체크해제한 업로드파일에 대한 종합결과object 배열에서 삭제
				for(var k=0; k<f_arrTotRslt.length; k++){
					if(f_arrUplFl[i].cls_cd == f_arrTotRslt[k].cls_cd
					   && f_arrUplFl[i].req_dept_cd == f_arrTotRslt[k].req_dept_cd
					   && f_arrUplFl[i].fin_cd == f_arrTotRslt[k].fin_cd
					   && f_arrUplFl[i].req_dt == f_arrTotRslt[k].req_dt){
			   			f_arrTotRslt.splice(k, 1);
					   	k--;
					}
				}
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
	        		$("#tot_anlys_stts_cont > table > tbody > tr[id^=anlys"+flCmCd+"]").remove();
		        	$.each(data, function(idx, item){
		        		var anlysId = removeSpcChar("anlys"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.save_file_nm);
		        		var source = "<tr id=\""+anlysId+"\">"
			        		+"<td>"+item.fin_nm+"</td>"
			        		+"<td>"+addDashDate(item.req_dt)+"</td>"
			        		+"<td>"+item.upl_file_nm+"</td>"
			        		+"<td>"+item.trns_stts_nm+"</td>"
			        		+"</tr>";
		        		$("#tot_anlys_stts_cont > table > tbody").append(source);
		        		
						//분석진행상태 조회결과 object 배열로 저장
		        		var dupObjCnt = 0;
						for(var i in f_arrAnlys){
							if(f_arrAnlys[i].id == anlysId){
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
		 					f_arrAnlys.push(objAnlys);
						}
		        	});
	        		//종합결과 조회
 	        		fn_search_totRslt(arrJsonObj, flCmCd);
	        	}
	         },
	         error       :   function(request, status, error){
	             console.log("AJAX_ERROR");
	         }
		});
	}else{
		$("#tot_anlys_stts_cont > table > tbody > tr[id^=anlys"+flCmCd+"]").remove();
		$("#tot_rslt_cont > table > tbody > tr[id^=totRslt"+flCmCd+"]").remove();
	}
	
	
});

//종합결과 조회
function fn_search_totRslt(pObj, flCmCd){
	$.ajax({
		type: "POST",
        url: "getTotalInspectoinList.do",
        contentType:'application/json; charset=UTF-8',
        data:JSON.stringify(pObj),
        dataType:"json",
        async: false,
        success: function(data) {
        	if(data != ''){
        		$("#tot_rslt_cont > table > tbody > tr[id^=totRslt"+flCmCd+"]").remove();
	        	$.each(data, function(idx, item){
	        		//체크한 파일별 id생성(권역코드+요청부서코드+회사코드+요청일자+상품군코드)
	        		var idStr = removeSpcChar("totRslt"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.prdln_cd);
	        		var source = "<tr id=\""+idStr+"\">"
		        		+"<td>"+item.fin_nm+"</td>"
		        		+"<td>"+addDashDate(item.req_dt)+"</td>"
		        		+"<td>"+item.prdln_nm+"</td>"
		        		+"<td>"+item.auto_avg+"</td>"
		        		+"<td>"+item.manual_avg+"</td>"
		        		+"</tr>";
	        		$("#tot_rslt > #tot_rslt_cont > table > tbody").append(source);
					//종합결과 조회결과 object 배열로 저장
	        		var objTotRslt = {
	        				id : idStr,
							cls_cd : item.cls_cd,
							req_dept_cd : item.req_dept_cd,
							fin_cd : item.fin_cd,
							req_dt : item.req_dt,
							prdln_cd : item.prdln_cd
					}
	        		f_arrTotRslt.push(objTotRslt);
	        	});
        	}
         },
         error       :   function(request, status, error){
             console.log("AJAX_ERROR");
         }
	});
}

//텍스트 변환결과 및 계약별 결과 조회 
$('body').on('dblclick', '#tot_rslt_cont > table > tbody > tr', function(){
	console.log("this id : "+$(this).prop('id'));
	var cls_cd;
	var req_dept_cd;
	var fin_cd;
	var req_dt;
	var prdln_cd;
	var arrSaveFileNm = new Array();
	for(var i in f_arrTotRslt){
		if(f_arrTotRslt[i].id == $(this).prop('id')){
			cls_cd = f_arrTotRslt[i].cls_cd;
			req_dept_cd = f_arrTotRslt[i].req_dept_cd;
			fin_cd = f_arrTotRslt[i].fin_cd;
			req_dt = f_arrTotRslt[i].req_dt;
			prdln_cd = f_arrTotRslt[i].prdln_cd;
		}
	}
	for(var i in f_arrAnlys){
		if(   cls_cd 	  == f_arrAnlys[i].cls_cd
		   && req_dept_cd == f_arrAnlys[i].req_dept_cd
		   && fin_cd 	  == f_arrAnlys[i].fin_cd
		   && req_dt 	  == f_arrAnlys[i].req_dt){
			arrSaveFileNm.push(f_arrAnlys[i].save_file_nm);
		}
	}
	
	var pObj = {
		cls_cd : 	  	cls_cd,
		req_dept_cd : 	req_dept_cd,
		fin_cd : 	  	fin_cd,
		req_dt : 	  	req_dt,
		prdln_cd : 	    prdln_cd,
		arr_save_file_nm : arrSaveFileNm
	}

	$.ajax({
		type: "POST",
        url: "getSttResultList.do",
        data: JSON.stringify(pObj),
        contentType:'application/json; charset=UTF-8',
        dataType:"json",
        async: false,
        success: function(data) {
        	if(data != ''){
        		console.log(data);
        		
        		$("#txt_stt_rslt_cont > table > tbody").empty();
        		$("#ctt_rslt_cont > table > tbody").empty();
        		f_arrCttRslt.splice(0, f_arrCttRslt.length);
	        	$.each(data, function(idx, item){
	        		//체크한 파일별로 tr id(=object id)생성("txtRslt"+권역코드+요청부서코드+회사코드+요청일자+증권번호)
	        		var idStr = removeSpcChar("txtRslt"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.scrts_no);
					var auto_scr = item.auto_scr == null ? 0 : item.auto_scr;
					var manual_scr = item.manual_scr == null ? 0 : item.manual_scr;
	        		var source = "<tr id=\""+idStr+"\">"
		        		+"<td><input type=\"checkbox\"></td>"
		        		+"<td>"+item.fin_nm+"</td>"
		        		+"<td>"+addDashDate(item.req_dt)+"</td>"
		        		+"<td>"+item.prdln_nm+"</td>"
		        		+"<td>"+item.scrts_no+"</td>"
		        		+"<td>"+auto_scr+"</td>"
		        	 	+"<td>"+manual_scr+"</td>"
		        		+"</tr>";
	        		$("#txt_stt_rslt_cont > table > tbody").append(source);
	        		
	        		//체크한 파일별로 tr id(=object id)생성("cttRslt"+권역코드+요청부서코드+회사코드+요청일자+증권번호)
	        		idStr = removeSpcChar("cttRslt"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.scrts_no);
					var source = "<tr id=\""+idStr+"\">"
		        		+"<td>"+item.fin_nm+"</td>"
		        		+"<td>"+addDashDate(item.req_dt)+"</td>"
		        		+"<td>"+item.prdln_nm+"</td>"
		        		+"<td>"+item.scrts_no+"</td>"
		        		+"<td>"+item.prd_nm+"</td>"
		        		+"<td>"+addDashDate(item.ctt_dt)+"</td>"
		        		+"<td>"+item.ctt_stts+"</td>"
		        		+"<td>"+item.cttor_nm+"</td>"
		        		+"<td>"+auto_scr+"</td>"
		        		+"<td>"+manual_scr+"</td>"
		        		+"</tr>";
        			$("#ctt_rslt_cont > table > tbody").append(source);
					
					//조회결과를 object 배열에 저장
	        		var objCttRslt = {
	        				id : idStr,
							cls_cd : item.cls_cd,
							req_dept_cd : item.req_dept_cd,
							fin_cd : item.fin_cd,
							req_dt : item.req_dt,
							scrts_no : item.scrts_no,
							prdln_cd : item.prdln_cd,
							save_file_nm : item.save_file_nm
					}
	        		f_arrCttRslt.push(objCttRslt);
	        	});
        	}
         },
         error       :   function(request, status, error){
             console.log("AJAX_ERROR");
         }
	});
});

//문자열에 yyyy-mm-dd형태로 "-"추가
function addDashDate(str){
	str = str.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	return str;
}

//문자열 내 특수문자 제거
function removeSpcChar(str){
	str = str.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, "");
	return str;
}

//종합결과조회 엑셀 다운로드
function fn_excel_totRslt(){
	var frm = document.getElementById("frm_excel_totRslt");
	for(var i in f_arrAnlys){
		var ipt_cls_cd = document.createElement('input');
		var ipt_req_dept_cd = document.createElement('input');
		var ipt_req_dt = document.createElement('input');
		var ipt_fin_cd = document.createElement('input');
		var ipt_save_file_nm = document.createElement('input');
		
		ipt_cls_cd.setAttribute("type", "hidden");
		ipt_cls_cd.setAttribute("name", "anlysRsltVos["+i+"].cls_cd");
		ipt_cls_cd.setAttribute("value", f_arrAnlys[i].cls_cd);
		ipt_req_dept_cd.setAttribute("type", "hidden");
		ipt_req_dept_cd.setAttribute("name", "anlysRsltVos["+i+"].req_dept_cd");
		ipt_req_dept_cd.setAttribute("value", f_arrAnlys[i].req_dept_cd);
		ipt_req_dt.setAttribute("type", "hidden");
		ipt_req_dt.setAttribute("name", "anlysRsltVos["+i+"].req_dt");
		ipt_req_dt.setAttribute("value", f_arrAnlys[i].req_dt);
		ipt_fin_cd.setAttribute("type", "hidden");
		ipt_fin_cd.setAttribute("name", "anlysRsltVos["+i+"].fin_cd");
		ipt_fin_cd.setAttribute("value", f_arrAnlys[i].fin_cd);
		ipt_save_file_nm.setAttribute("type", "hidden");
		ipt_save_file_nm.setAttribute("name", "anlysRsltVos["+i+"].save_file_nm");
		ipt_save_file_nm.setAttribute("value", f_arrAnlys[i].save_file_nm);
		
		frm.appendChild(ipt_cls_cd);
		frm.appendChild(ipt_req_dept_cd);
		frm.appendChild(ipt_req_dt);
		frm.appendChild(ipt_fin_cd);
		frm.appendChild(ipt_save_file_nm);
	}
	
	frm.submit();
	$('#frm_excel_totRslt').empty();
}

//계약별 결과 엑셀 다운로드
function fn_excel_cttRslt(){
	var frm = document.getElementById("frm_excel_cttRslt");
	
	var ipt_cls_cd = document.createElement('input');
	var ipt_req_dept_cd = document.createElement('input');
	var ipt_req_dt = document.createElement('input');
	var ipt_fin_cd = document.createElement('input');
	var ipt_prdln_cd = document.createElement('input');
	var ipt_scrts_no = document.createElement('input');
	
	ipt_cls_cd.setAttribute("type", "hidden");
	ipt_cls_cd.setAttribute("name", "cls_cd");
	ipt_cls_cd.setAttribute("value", f_arrCttRslt[0].cls_cd);
	ipt_req_dept_cd.setAttribute("type", "hidden");
	ipt_req_dept_cd.setAttribute("name", "req_dept_cd");
	ipt_req_dept_cd.setAttribute("value", f_arrCttRslt[0].req_dept_cd);
	ipt_req_dt.setAttribute("type", "hidden");
	ipt_req_dt.setAttribute("name", "req_dt");
	ipt_req_dt.setAttribute("value", f_arrCttRslt[0].req_dt);
	ipt_fin_cd.setAttribute("type", "hidden");
	ipt_fin_cd.setAttribute("name", "fin_cd");
	ipt_fin_cd.setAttribute("value", f_arrCttRslt[0].fin_cd);
	ipt_prdln_cd.setAttribute("type", "hidden");
	ipt_prdln_cd.setAttribute("name", "prdln_cd");
	ipt_prdln_cd.setAttribute("value", f_arrCttRslt[0].prdln_cd);
	ipt_scrts_no.setAttribute("type", "hidden");
	ipt_scrts_no.setAttribute("name", "scrts_no");
	ipt_scrts_no.setAttribute("value", f_srch_Scrts_no);
	
	frm.appendChild(ipt_cls_cd);
	frm.appendChild(ipt_req_dept_cd);
	frm.appendChild(ipt_req_dt);
	frm.appendChild(ipt_fin_cd);
	frm.appendChild(ipt_prdln_cd);
	frm.appendChild(ipt_scrts_no);
	
	for(var i in f_arrCttRslt){
		console.log(f_arrCttRslt[i].prdln_cd);
		var ipt_save_file_nm = document.createElement('input');
		ipt_save_file_nm.setAttribute("type", "hidden");
		ipt_save_file_nm.setAttribute("name", "arr_save_file_nm["+i+"]");
		ipt_save_file_nm.setAttribute("value", f_arrCttRslt[i].save_file_nm);
// 		arr_save_file_nm[]
		frm.appendChild(ipt_save_file_nm);
	}
	
	frm.submit();
	$('#frm_excel_cttRslt').empty();
}

//계약별결과 조회결과 내 증권번호로 조회
function fn_search_cttRslt(){
	f_srch_Scrts_no = $("#srch_scrts_no").val();
	var arrSaveFileNm = new Array();
	for(var i in f_arrCttRslt){
		arrSaveFileNm.push(f_arrCttRslt[i].save_file_nm);
	}
	var pObj = {
		cls_cd : 	  	   f_arrCttRslt[0].cls_cd,
		req_dept_cd : 	   f_arrCttRslt[0].req_dept_cd,
		fin_cd : 	  	   f_arrCttRslt[0].fin_cd,
		req_dt : 	  	   f_arrCttRslt[0].req_dt,
		prdln_cd : 	       f_arrCttRslt[0].prdln_cd,
		scrts_no : 		   f_srch_Scrts_no,
		arr_save_file_nm : arrSaveFileNm
	}
	
	$.ajax({
		type: "POST",
        url: "getSttResultList.do",
        data: JSON.stringify(pObj),
        contentType:'application/json; charset=UTF-8',
        dataType:"json",
        async: false,
        success: function(data) {
        	if(data != ''){
        		$("#ctt_rslt_cont > table > tbody").empty();
	        	$.each(data, function(idx, item){
					var auto_scr = item.auto_scr == null ? 0 : item.auto_scr;
					var manual_scr = item.manual_scr == null ? 0 : item.manual_scr;
	        		var idStr = removeSpcChar("sttRslt"+item.cls_cd+item.req_dept_cd+item.fin_cd+item.req_dt+item.scrts_no);
					var source = "<tr id=\""+idStr+"\">"
		        		+"<td>"+item.fin_nm+"</td>"
		        		+"<td>"+addDashDate(item.req_dt)+"</td>"
		        		+"<td>"+item.prdln_nm+"</td>"
		        		+"<td>"+item.scrts_no+"</td>"
		        		+"<td>"+item.prd_nm+"</td>"
		        		+"<td>"+addDashDate(item.ctt_dt)+"</td>"
		        		+"<td>"+item.ctt_stts+"</td>"
		        		+"<td>"+item.cttor_nm+"</td>"
		        		+"<td>"+auto_scr+"</td>"
		        		+"<td>"+manual_scr+"</td>"
		        		+"</tr>";
        			$("#ctt_rslt_cont > table > tbody").append(source);
	        	});
        	}
         },
         error       :   function(request, status, error){
             console.log("AJAX_ERROR");
         }
	});
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

//분석 상세 결과 화면 전환
$('body').on('dblclick', '#ctt_rslt_cont > table > tbody > tr', function(){
	console.log("this id : "+$(this).prop('id'));
	for(var i in f_arrCttRslt){
		console.log("arr id : "+f_arrCttRslt[i].id);
		if($(this).prop('id') == f_arrCttRslt[i].id){
			$('#det_cls_cd').val(f_arrCttRslt[i].cls_cd);
			$('#det_req_dept_cd').val(f_arrCttRslt[i].req_dept_cd);
			$('#det_req_dt').val(f_arrCttRslt[i].req_dt);
			$('#det_fin_cd').val(f_arrCttRslt[i].fin_cd);
			$('#det_scrts_no').val(f_arrCttRslt[i].scrts_no);
			$('#det_prdln_cd').val(f_arrCttRslt[i].prdln_cd);
		}
	}
	var frm_goDetail = document.getElementById("frm_goDetail");
	frm_goDetail.submit();
});
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
			<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-03" />
			<c:forEach var="navTitles" items="${sessionScope.navTitles}">
				<c:if test="${navTitles.menu_id eq navMenuId}">
					<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<h3>${sectionTitle}</h3>
		</div>
		<div id="upl_file_sel">
			<form id="frm_getUplList" action="getAnlysRsltList.do" method="post">
			<input type="hidden" id="upl_class_cd" name="upl_class_cd">
			<div id="sel_fin_nm">
				<h5>> 업로드파일 선택</h5>
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="sel_fin_cd" onchange="fn_search_uplFl()">
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
				<div id="tot_anlys_stts_cont">
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
			</div>
			<div id="tot_rslt">
				<h5>> 종합결과 조회</h5>
				<input type="button" value="엑셀" onclick="fn_excel_totRslt()">
				<div id="tot_rslt_cont">
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
			</div>
			<div id="txt_stt_rslt">
				<h5>> 텍스트 변환결과 다운로드</h5>
				<input type="button" value="파일다운">
				<div id="txt_stt_rslt_cont">
					<table>
						<thead>
							<tr>
								<th><input type="checkbox"></th>
								<th>회사명</th>
								<th>요청일</th>
								<th>상품군</th>
								<th>증권번호</th>
								<th>자동점수</th>
								<th>수동점수</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
			<div id="ctt_rslt">
				<h5>> 계약별 결과 조회</h5>
				<div id="srch_ctt_rslt">
					<ul>
						<li>▶</li>
						<li>증권번호</li>
						<li><input type="text" id="srch_scrts_no"></li>
						<li><input type="button" value="조회" onclick="fn_search_cttRslt()"></li>
						<li><input type="button" value="엑셀" onclick="fn_excel_cttRslt()"></li>
					</ul>
				</div>
				<div id="ctt_rslt_cont">
					<table>
						<thead>
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
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<form id="frm_excel_totRslt" method="post" action="getTotalInspectoinList_exl.do"></form>
				<form id="frm_excel_cttRslt" method="post" action="getSttResultList_exl.do"></form>
				<form id="frm_goDetail" method="post" action="getContractInfo.do">
					<input type="hidden" id="det_cls_cd" name="cls_cd">
					<input type="hidden" id="det_req_dept_cd" name="req_dept_cd">
					<input type="hidden" id="det_req_dt" name="req_dt">
					<input type="hidden" id="det_fin_cd" name="fin_cd">
					<input type="hidden" id="det_prdln_cd" name="prdln_cd">
					<input type="hidden" id="det_scrts_no" name="scrts_no">
				</form>
			</div>
		</div>
	</section>
</div>	
</body>
</html>