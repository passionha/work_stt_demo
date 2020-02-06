<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr" pageEncoding="euc-kr"%>
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
	<table border="1">
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
		<tbody>
			<c:forEach var="cList" items="${cttRsltList}" begin="0" step="1">
			<fmt:parseDate value="${cList.req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
			<fmt:parseDate value="${cList.ctt_dt}" var="fmt_ctt_dt" pattern="yyyyMMdd"/>
			<tr>
				<td>${cList.fin_nm}</td>
				<td><fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/></td>
				<td>${cList.prdln_nm}</td>
				<td>${cList.scrts_no}</td>
				<td>${cList.prd_nm}</td>
				<td><fmt:formatDate value="${fmt_ctt_dt}" pattern="yyyy-MM-dd"/></td>
				<td>${cList.ctt_stts}</td>
				<td>${cList.cttor_nm}</td>
				<td>${cList.auto_scr}</td>
				<td><c:choose><c:when test="${cList.manual_scr eq null}">0</c:when><c:otherwise>${cList.manual_scr}</c:otherwise></c:choose></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>