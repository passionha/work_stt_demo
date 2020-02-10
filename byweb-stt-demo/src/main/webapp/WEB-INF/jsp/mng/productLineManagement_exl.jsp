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
				<td>권역</td>
				<td>구분</td>
				<td>상품군</td>
				<td>상품군코드</td>
				<td>사용여부</td>
				<td>등록일</td>
				<td>등록자</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pList" items="${prdlnList}" begin="0" step="1">
			<tr>
				<td>${pList.req_dept_nm}</td>
				<td>${pList.cls_cd_nm}</td>
				<td>${pList.prdln_nm}</td>
				<td>${pList.prdln_cd}</td>
				<td>${pList.use_yn}</td>
				<td>${pList.reg_dt}</td>
				<td>${pList.emp_nm}(${pList.emp_no})</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>