<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
	String filename = (String)request.getAttribute("filename");
	filename = new String(filename.getBytes("euc-kr"), "ISO-8859-1");
    response.setHeader("Content-Disposition","attachment;filename=\""+filename+"\"");
    response.setHeader("Content-Description", "JSP Generated Data"); 
%>
<html>
<body>
	<table id="tbl_sbmList" border="1">
			<thead>
				<tr>
					<th>회사명</th>
					<th>상품군</th>
					<th>증권번호</th>
					<th>상품명</th>
					<th>계약일</th>
					<th>계약상태</th>
					<th>계약상태발생일</th>
					<th>계약자명</th>
					<th>대리점명</th>
					<th>대리점등록번호</th>
					<th>모집점포명</th>
					<th>모집채널</th>
					<th>STT진행상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="conList" items="${conList}" begin="0" step="1">
				<fmt:parseDate value="${conList.ctt_dt}" var="fmt_ctt_dt" pattern="yyyyMMdd"/>
				<fmt:parseDate value="${conList.ctt_stts_efdt}" var="fmt_ctt_stts_efdt" pattern="yyyyMMdd"/>
				<tr>
					<td>${conList.fin_nm}</td>
					<td>${conList.prdln_nm}</td>
					<td>${conList.scrts_no}</td>
					<td>${conList.prd_nm}</td>
					<td><fmt:formatDate value="${fmt_ctt_dt}" pattern="yyyy-MM-dd"/></td>
					<td>${conList.ctt_stts}</td>
					<td><fmt:formatDate value="${fmt_ctt_stts_efdt}" pattern="yyyy-MM-dd"/></td>
					<td>${conList.cttor_nm}</td>
					<td>${conList.ga_nm}</td>
					<td>${conList.ga_rno}</td>
					<td>${conList.rcrt_sto_nm}</td>
					<td>${conList.rcrt_chnl}</td>
					<td>${conList.anly_st}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>