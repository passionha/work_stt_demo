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
					<th>��ǰ��</th>
					<th>���ǹ�ȣ</th>
					<th>��ǰ��</th>
					<th>�����</th>
					<th>������</th>
					<th>�����¹߻���</th>
					<th>����ڸ�</th>
					<th>�븮����</th>
					<th>�븮����Ϲ�ȣ</th>
					<th>����������</th>
					<th>����ä��</th>
					<th>STT�������</th>
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