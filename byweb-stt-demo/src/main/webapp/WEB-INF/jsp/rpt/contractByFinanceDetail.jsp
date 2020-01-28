<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>녹취파일 계약정보</title>
</head>
<body>
	<section>
		<h3>녹취파일 계약정보</h3>
		<form id="frm" action="getContractList.do" method="post">
			<div id="btn_top">
				<input type="button" value="엑셀" onclick="fn_excel()">
				<input type="button" value="조회" onclick="fn_search()">
				<input type="button" value="녹취파일변환" onclick="">
			</div>
			<br>
			<div id="searchBar">
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="" name="">
							<%-- <c:forEach var="finList" items="${finList}" begin="0" step="1">
								<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
							</c:forEach> --%>
						</select>
					</li>
					
					<li>▶</li>
					<li>요청일</li>
					<li>
						<input type="text" value="" readonly>
					</li>
					
					<li>▶</li>
					<li>상품군</li>
					<li>
						<select id="" name="">
							<%-- <c:forEach var="finList" items="${finList}" begin="0" step="1">
								<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
							</c:forEach> --%>
						</select>
					</li>
					
					<li>▶</li>
					<li>증권번호</li>
					<li>
						<input type="text" value="">
					</li>
					
					<li>▶</li>
					<li>계약일</li>
					<li>
						<%-- <fmt:parseDate value="${sdate}" var="sdate_dt" pattern="yyyyMMdd"/>
						<input type="text" id="sdate" name="sdate" <c:if test="${sdate ne ''}">value="<fmt:formatDate value="${sdate_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif"> --%>
					</li>
					<li>~</li>
					<li>
						<%-- <fmt:parseDate value="${edate}" var="edate_dt" pattern="yyyyMMdd"/>
						<input type="text" id="edate" name="edate" <c:if test="${edate ne ''}">value="<fmt:formatDate value="${edate_dt}" pattern="yyyy-MM-dd"/>"</c:if> maxlength="10" onkeyup="fn_addDash(event, this)" onkeypress="fn_addDash(event, this)">
						<img src="/user/images/calendar.gif"> --%>
					</li>
				</ul>
			</div>
		</form>
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
				<%-- 
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
					<td><input type="button" value="업로드" onclick="fn_openUploadPop('${conList.fin_cd}', '${conList.req_dt}')"></td>
					<td>${conList.anly_st}</td>
					<td><input type="button" value="삭제" onclick="fn_delContract('${conList.fin_nm}', '${conList.sbm_dt}', '${conList.fin_cd}', '${conList.req_dt}')"></td>
				</tr>
				</c:forEach>
				 --%>
			</tbody>
		</table>
	</section>
</body>
</html>