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
				<td>회사명</td>
				<td>상품군</td>
				<td>증권번호</td>
				<td>요청일</td>
				<td>업로드파일명</td>
				<td>녹취파일명</td>
				<td>파일등록일</td>
				<td>오류내역</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="rList" items="${rcdRsltList}" begin="0" step="1">
			<tr>
				<td>${rList.fin_nm}</td>
				<td>${rList.prdln_nm}</td>
				<td>${rList.scrts_no}</td>
				<fmt:parseDate value="${rList.req_dt}" var="fmt_req_dt" pattern="yyyyMMdd"/>
				<td><fmt:formatDate value="${fmt_req_dt}" pattern="yyyy-MM-dd"/></td>
				<td>${rList.upl_file_nm}</td>
				<td>${rList.file_nm}</td>
				<td>${rList.reg_dt}</td>
				<td>${rList.err_nm}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>