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
			<th>ȸ���</th>
			<th>��û��</th>
			<th>��ǰ��</th>
			<th>�ڵ����</th>
			<th>�������</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var="tList" items="${totRsltList}" begin="0" step="1">
			<fmt:parseDate value="${tList.req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
			<tr>
				<td>${tList.fin_nm}</td>
				<td><fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/></td>
				<td>${tList.prdln_nm}</td>
				<td>${tList.auto_avg}</td>
				<td>${tList.manual_avg}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>