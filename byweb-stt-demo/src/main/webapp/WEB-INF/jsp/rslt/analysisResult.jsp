<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, kr.byweb.stt.demo.cm.model.*" %>
<%
	String sectionTitle = "";
	String sel_req_cd = (String)session.getAttribute("sel_req_cd");
	String contentPage = (String)request.getAttribute("contentPage");
	List<TmCmCdVo> headerTitles = (List<TmCmCdVo>)session.getAttribute("headerTitles");
	List<TmCmCdVo> navTitles = (List<TmCmCdVo>)session.getAttribute("navTitles");
	
	Iterator<TmCmCdVo> hdIt = headerTitles.iterator();
	TmCmCdVo hdTitleInfo;
	while(hdIt.hasNext()){
		hdTitleInfo = hdIt.next();
		if(hdTitleInfo.getMenu_id().equals(sel_req_cd)){
			sectionTitle = hdTitleInfo.getMenu_nm().toString();
		}
	}
	Iterator<TmCmCdVo> navIt = navTitles.iterator();
	TmCmCdVo navTitleInfo;
	while(navIt.hasNext()){
		navTitleInfo = navIt.next();
		if(navTitleInfo.getMenu_id().equals(sel_req_cd.toString()+"-03")){
			sectionTitle += " > "+navTitleInfo.getMenu_nm().toString();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과 확인</title>
<style type="text/css">
	#upl_file_sel {
  		float: left;
  		width: 20%;
  		height: 90%;
  		border: 1px solid blue;
	}
	#sel_fin_nm {
		height: 14%;
	}
	#sel_fin_nm ul {
		border: 3px solid #00b0f0;
	}
	#right_side {
		width: 78%;
		border: 1px solid red;
		float: right;
	}
	#fin_sel_rslt {
		border: 2px solid lightgrey;
	}
	#right_side table {
		width: 100%
	}
	#right_side table, th, td{
		border: 2px solid lightgrey;
	}
	#right_side div input[type="button"] {
 		float: right;
	}
	#right_side div h5, input{
		display: inline;
	}
	#srch_con_rslt ul {
		border: 3px solid #00b0f0;
	}
</style>
</head>
<body>
<div id="wrap">
	<section>
		<h3><%=sectionTitle%></h3>
		<div id="upl_file_sel">
			<div id="sel_fin_nm">
				<h5>> 업로드파일 선택</h5>
				<ul>
					<li>▶</li>
					<li>회사명</li>
					<li>
						<select id="sel_fin_cd" name="sel_fin_cd">
							<option value="SEL" <c:if test="${fin_cd eq ''}">selected</c:if>>선택</option>
							<c:forEach var="finList" items="${finList}" begin="0" step="1">
							<c:if test="${finList.finance_cd ne 'ALL'}">
								<option value="${finList.finance_cd}" <c:if test="${fin_cd eq finList.finance_cd}">selected</c:if>>${finList.finance_name}</option>
							</c:if>
							</c:forEach>
						</select>
					</li>
				</ul>
			</div>
			<div id="fin_sel_rslt">
				<ul>
					<li>file list treeView</li>
				</ul>
			</div>
		</div>
		<div id="right_side">
			<div id="tot_anlys_stts">
				<h5>> 전체 분석 진행상태</h5>
				<input type="button" value="분석">
				<table>
					<tr>
						<th>회사명</th>
						<th>요청일</th>
						<th>파일명</th>
						<th>STT진행상태</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="tot_rslt">
				<h5>> 종합결과 조회</h5>
				<input type="button" value="엑셀">
				<table>
					<tr>
						<th>회사명</th>
						<th>요청일</th>
						<th>상품군</th>
						<th>자동평균</th>
						<th>수동평균</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="txt_stt_rslt">
				<h5>> 텍스트 변환결과 다운로드</h5>
				<input type="button" value="파일다운">
				<table>
					<tr>
						<th><input type="checkbox"></th>
						<th>회사명</th>
						<th>요청일</th>
						<th>상품군</th>
						<th>증권번호</th>
						<th>자동점수</th>
						<th>수동점수</th>
					</tr>
					<tr>
						<td><input type="checkbox"></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="con_rslt">
				<h5>> 계약별 결과 조회</h5>
				<div id="srch_con_rslt">
					<ul>
						<li>▶</li>
						<li>증권번호</li>
						<li><input type="text"></li>
						<li><input type="button" value="조회"></li>
						<li><input type="button" value="엑셀"></li>
					</ul>
				</div>
				<table>
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
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
	</section>
</div>	
</body>
</html>