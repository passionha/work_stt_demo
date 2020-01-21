<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String filename = (String)request.getAttribute("filename");
	filename = new String(filename.getBytes("euc-kr"), "ISO-8859-1");
    response.setHeader("Content-Disposition","attachment;filename=\""+filename+"\"");
    response.setHeader("Content-Description", "JSP Generated Data"); 
//     response.setContentType("application/vnd.ms-word");
%>
<html>
<body>
	<table id="tbl_sbmList" border="1">
		<thead>
			<tr>
				<th>회사명</th>
				<th>제출파일명</th>
				<th>요청일자</th>
				<th>제출일자</th>
				<th>업로드파일명</th>
				<th>계약건수</th>
				<th>녹취파일건수</th>
				<th>비매칭건수</th>
				<th>STT진행상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="conList" items="${conList}" begin="0" step="1">
			<tr>
				<td>${conList.fin_nm}</td>
				<td>${conList.sbm_file_nm}</td>
				<td>${conList.req_dt}</td>
				<td>${conList.sbm_dt}</td>
				<td>${conList.upl_file_nm}</td>
				<td>${conList.ctt_cnt}</td>
				<td>${conList.file_cnt}</td>
				<td>${conList.mismatch_cnt}</td>
				<td>${conList.anly_st}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>