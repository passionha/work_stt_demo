<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대본파일 다운로드</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
var parentSearchYn = false;		//팝업 종료 시 부모창 재조회 여부

$(document).ready(function(){
	//팝업 시 parent창 비활성화
	window.opener.$('#modal_layer').css({'display':'block'});
});

//팝업 종료 시 parent 활성화
function fn_befClosePop(){
	if(parentSearchYn) window.opener.fn_search();			//부모창 재조회
	window.opener.$('#modal_layer').css({'display':'none'});
}

//대본파일 열기 및 저장(saveSpr - 1:열기, 2:저장)
function fn_saveScrFile(saveSpr){
	if(!$('#file_path').val()){
		alert("대본파일이 존재하지 않습니다.");
		return;
	}
	
	if(saveSpr == '1'){
			
	}else if(saveSpr == '2'){
		
	}
}
</script>
</head>
<body onbeforeunload="fn_befClosePop();">
	<div id="message">
		<p>[${fin_nm}_${file_nm}]</p>
		<p>파일을 다운로드 하시겠습니까?</p>
	</div>
	
	<div id="btns">
		<input type="button" value="열기" onclick="fn_saveScrFile(1)">
		<input type="button" value="저장" onclick="fn_saveScrFile(2)">
		<input type="button" value="취소" onclick="self.close()">
	</div>
	
	<input type="hidden" id="file_path" value="${scrFileInfo.file_path}">
	<input type="hidden" id="file_nm" value="${scrFileInfo.file_nm}">
	
</body>
</html>