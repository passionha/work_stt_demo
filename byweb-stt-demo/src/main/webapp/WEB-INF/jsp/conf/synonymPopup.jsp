<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>※동의어 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function fn_save(){
    $("#btn_save").click(function() {
    	var chkedKwds = [];
        var unchkedKwds = [];
        
        $('input[name="kwdNm"]:checked').each(function(i){//체크된 리스트 저장
        	chkedKwds.push($(this).val());
        });
        $('input[name="kwdNm"]:not(:checked)').each(function(i){//체크해제 리스트 저장
        	unchkedKwds.push($(this).val());
        });
        
        var objParams = {
			"syn_nm" : $("#syn_nm").val(),
			"prdln_cd" : $("#prdln_cd").val(),
			"kwd_spr" : $("#kwd_spr").val(),
			"kwd_nm" : $("#kwd_nm").val(),
			"org_syn_nm" : $("#org_syn_nm").val(),
            "chkKwds" : chkedKwds,
            "unchkKwds" : unchkedKwds
        };
        
        $.ajax({
            url         :   "updateSynonym",
            dataType    :   "json",
            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
            type        :   "post",
            data        :   objParams,
            success     :   function(retVal){
            	window.opener.fn_search();
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
    })
});
// ing
$("#btn_save").click(function() {
	if(confirm('해당 동의어를 삭제하시겠습니까?')){
		
	}
    var chkedKwds = [];
    var unchkedKwds = [];
    
    $('input[name="kwdNm"]:checked').each(function(i){//체크된 리스트 저장
    	chkedKwds.push($(this).val());
    });
    $('input[name="kwdNm"]:not(:checked)', false).each(function(i){//체크해제 리스트 저장
    	unchkedKwds.push($(this).val());
    });
    
    var objParams = {
		"syn_nm" : $("#syn_nm").val(),
		"prdln_cd" : $("#prdln_cd").val(),
		"kwd_spr" : $("#kwd_spr").val(),
        "chkKwds" : chkedKwds,
        "unchkKwds" : unchkedKwds
    };
    
    $.ajax({
        url         :   "updateSynonym",
        dataType    :   "json",
        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
        type        :   "post",
        data        :   objParams,
        success     :   function(retVal){
        	window.opener.fn_search();
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
})

</script>
</head>
<body>
	<div id="wrap">
		<div id="popupTitle">
			<h3>※동의어 관리</h3>
		</div> 
		
		<form id="synSetFrm" action="updateSynonym" method="post">
			<input type="hidden" id="prdln_cd" name="prdln_cd" value="${prdln_cd}">
			<input type="hidden" id="kwd_spr" name="kwd_spr" value="${kwd_spr}">
			<input type="hidden" id="kwd_nm" name="kwd_nm" value="${kwd_nm}">
			<input type="hidden" id="org_syn_nm" name="org_syn_nm" value="${syn_nm}">
			<div id="btn_synSet">
				<input type="button" id="btn_save" value="저장">
				<input type="button" id="btn_del" value="삭제">
			</div>
			<table border="1">
				<tr>
					<th>동의어</th>
					<td><input type="text" id="syn_nm" name="syn_nm" value="${syn_nm}"></td>
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
				<tr>
					<td><input type="checkbox" name="kwdNm" value="${synList.kwd_nm}" <c:if test="${synList.chk_sel eq '1'}">checked="checked"</c:if>></td>
					<td>${synList.kwd_nm}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
	</div>
</body>
</html>