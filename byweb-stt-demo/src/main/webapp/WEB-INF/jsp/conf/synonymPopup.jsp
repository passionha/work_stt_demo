<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>※동의어 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
var parentSearchYn = false;		//팝업 종료 시 부모창 재조회 여부

$(document).ready(function(){
	//팝업 시 parent창 비활성화
	window.opener.$('#modal_layer').css({'display':'block'});
});

//동의어 수정사항 저장
function fn_save(){
	if($('input[name="chk_kwdNm"]:checked').length == 0){
		var msg = "동의어로 선택하신 키워드가 없습니다. 해당 동의어를 삭제하시겠습니까?"
		fn_delete(msg);
		return;	
	}
	
	if(confirm("수정사항을 저장하시겠습니까?")){
		//동의어명 유효성 검사
		if(!fn_synValid($("#syn_nm").val())){
			$("#syn_nm").focus();
			return;
		}
		
		//동의어명 중복검사
		var objParams = {
			"prdln_cd" : $("#prdln_cd").val(),
			"kwd_spr" : $("#kwd_spr").val(),
			"syn_nm" : $("#syn_nm").val(),
			"org_syn_nm" : $("#org_syn_nm").val(),
	    }
		
		var dupResult = true;
	    $.ajax({
	        url         :   "getSynonymDup.do",
	        dataType    :   "json",
	        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	        type        :   "post",
	        data        :   objParams,
	        async		:   false,
	        success     :   function(data){
	        	if(data > 0){
	        		alert("["+$('#syn_nm').val()+"]은(는) 이미 사용 중인 동의어명입니다.");
	        		dupResult = false;
	        	}
	        },
	        error       :   function(request, status, error){
	            console.log("AJAX_ERROR");
	        }
	    });
		if(!dupResult) return;
		
		//동의어 설정 키워드 간 배점 동일여부 확인
	   	var arrChkedKwd = new Array();
	    var arrUnchkedKwd = new Array();
	    var scrCompare = true;
	    
	    $('input[name="chk_kwdNm"]:checked').each(function(i, element){//체크된 리스트 저장
	    	index = $(element).index("input:checkbox[name=chk_kwdNm]");
	    	if($('input[name="scr"]').val() != $('input[name="listScr"]').eq(index).val()){
	    		alert("동의어 설정 시 기준키워드와 ["+$('input[name="listKwdNm"]').eq(index).val()+"]의 배점이 동일해야합니다.");
	    		scrCompare = false;
	    		return;
	    	}else{
	     		arrChkedKwd.push($(this).val());
	    	}
	    });
	    if(scrCompare){
		    $('input[name="chk_kwdNm"]:not(:checked)').each(function(i){//체크해제 리스트 저장
		   		arrUnchkedKwd.push($(this).val());
		    });
		       
		    var objParams = {
				"syn_nm" : $("#syn_nm").val(),
				"prdln_cd" : $("#prdln_cd").val(),
				"kwd_spr" : $("#kwd_spr").val(),
				"kwd_nm" : $("#kwd_nm").val(),
				"org_syn_nm" : $("#org_syn_nm").val(),
		    	"chkKwds" : arrChkedKwd,
		    	"unchkKwds" : arrUnchkedKwd
		    }
		   
		    $.ajax({
		        url         :   "updateSynonym.do",
		        dataType    :   "json",
		        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
		        type        :   "post",
		        data        :   objParams,
		        success     :   function(retVal){
		        	alert("저장되었습니다.");
					parentSearchYn = true;
		        	$("#org_syn_nm").val($("#syn_nm").val());
		        	/*
		            if(retVal.code == "OK") {
		                alert(retVal.message);
		            } else {
		                alert(retVal.message);
		            }
		            */
		        },
		        error       :   function(request, status, error){
		            console.log("AJAX_ERROR");
		        }
		    });
	    }
	}
}
    
//동의어 삭제
function fn_delete(aMsg){
	var msg = "해당 동의어를 삭제하시겠습니까?";
	if(aMsg){ msg = aMsg; }
	
	if(confirm(msg)){
		var objParams = {
				"syn_nm" : $("#org_syn_nm").val(),
				"prdln_cd" : $("#prdln_cd").val(),
				"kwd_spr" : $("#kwd_spr").val(),
	    }
	    
	    $.ajax({
	        url         :   "updateDelSynonym.do",
	        dataType    :   "json",
	        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	        type        :   "post",
	        data        :   objParams,
	        success     :   function(retVal){
	        	alert("삭제되었습니다.");
				parentSearchYn = true;
	        	self.close();
	        },
	        error       :   function(request, status, error){
	            console.log("AJAX_ERROR");
	        }
	    });
	}
}

//동의어명 유효성 검사
function fn_synValid(val){
	//공백만 입력 검사
	if(!val.trim()){
		alert("동의어를 입력해주세요.");
		return false;
	}
	
	//특수 문자 검사
	var noSpcChar = /[<>]/gi
	if(noSpcChar.test(val)){
		alert("동의어명에 \"<, >\"는 입력할 수 없습니다.");
		return false;
	}

	if(val.length >= 50){
		alert("동의어명은 50자를 초과할 수 없습니다.");
		return false;
	}
    return true;
}


//팝업 종료 시 parent 활성화
function fn_befClosePop(){
	if(parentSearchYn) window.opener.fn_search();			//부모창 재조회
	window.opener.$('#modal_layer').css({'display':'none'});
}
</script>
</head>
<body onbeforeunload="fn_befClosePop();">
	<div id="wrap">
		<div id="popupTitle">
			<h3>※동의어 관리</h3>
		</div> 
		
		<form id="synSetFrm" action="updateSynonym.do" method="post">
			<input type="hidden" id="prdln_cd" name="prdln_cd" value="${prdln_cd}">
			<input type="hidden" id="kwd_spr" name="kwd_spr" value="${kwd_spr}">
			<input type="hidden" id="kwd_nm" name="kwd_nm" value="${kwd_nm}">
			<input type="hidden" id="scr" name="scr" value="${scr}">
			<input type="hidden" id="org_syn_nm" name="org_syn_nm" value="${syn_nm}">
			<div id="btn_synSet">
				<input type="button" id="btn_save" value="저장" onclick="fn_save()">
				<input type="button" id="btn_del" value="삭제" onclick="fn_delete()">
			</div>
			<table border="1">
				<tr>
					<th>동의어</th>
					<td><input type="text" id="syn_nm" name="syn_nm" value="${syn_nm}" maxlength="50"></td>
				</tr>
				<tr>
					<th>기준 키워드</th>
					<td>${kwd_nm}</td>
				</tr>
			</table>
		
		<div id="synSelTitle">
			<h4>□동의어 선택</h4>
		</div>
		
		<table border="1">
			<thead>
				<tr>
					<th>선택</th>
					<th>키워드</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="synList" items="${synList}" begin="0" step="1" varStatus="status">
				<input type="hidden" name="listScr" value="${synList.scr}">
				<input type="hidden" name="listKwdNm" value="${synList.kwd_nm}">
				<tr>
					<td><input type="checkbox" name="chk_kwdNm" value="${synList.kwd_nm}" <c:if test="${synList.chk_sel eq '1'}">checked="checked"</c:if>></td>
					<td>${synList.kwd_nm}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
	</div>
</body>
</html>