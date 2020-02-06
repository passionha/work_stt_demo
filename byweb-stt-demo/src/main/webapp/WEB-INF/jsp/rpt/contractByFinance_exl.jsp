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
	<table id="tbl_sbmList" border="1">
		<thead>
			<tr>
				<th>ȸ���</th>
				<th>�������ϸ�</th>
				<th>��û����</th>
				<th>��������</th>
				<th>���ε����ϸ�</th>
				<th>���Ǽ�</th>
				<th>�������ϰǼ�</th>
				<th>���Ī�Ǽ�</th>
				<th>STT�������</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="conList" items="${conList}" begin="0" step="1">
			<fmt:parseDate value="${conList.req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
			<fmt:parseDate value="${conList.sbm_dt}" var="fmt_sbm_dt" pattern="yyyyMMdd"/>
			<tr>
				<td>${conList.fin_nm}</td>
				<td>${conList.sbm_file_nm}</td>
				<td><fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${fmt_sbm_dt}" pattern="yyyy-MM-dd"/></td>
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