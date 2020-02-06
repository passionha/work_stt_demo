<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#left_side {
		float: left;
	}
	
	#div_sttRslt {
		float: right;
	}
	
	table, th, td {
		border: 2px solid lightgrey;
	}
	
	input[type="button"], input[type="checkbox"], label {
		float: right;
	}
	
	table {
		clear: both;
	}
	
	#div_omsEsnKwd {
		float: left;
	}
	
	h5 {
		display: inline;
	}
	
	p {
		display: inline;
		font-size: 11px;
		color: red;
	}
	
	#div_refRcdFl {
		float: right;
	}
	
	#txt_sttRslt {
		white-space:nowrap;
		overflow: auto;
		width: 600px;
		height: 300px;
	}
</style>
</head>
<body>
<div id="wrap">
	<section>
		<div>
			<c:forEach var="headerTitles" items="${sessionScope.headerTitles}">
				<c:if test="${headerTitles.menu_id eq sessionScope.sel_req_cd}">
					<c:set var="hdTitle" value="${headerTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<c:set var="navMenuId" value="${sessionScope.sel_req_cd}-03-01" />
			<c:forEach var="navTitles" items="${sessionScope.navTitles}">
				<c:if test="${navTitles.menu_id eq navMenuId}">
					<c:set var="sectionTitle" value="${hdTitle} > ${navTitles.menu_nm}"></c:set>
				</c:if>
			</c:forEach>
			<h3>${sectionTitle}</h3>
		</div>
		<div>
			<h5>> 계약정보</h5>
			<table>
				<thead>
					<tr>
						<td>회사명</td>
						<td>상품군</td>
						<td>증권번호</td>
						<td>상품명</td>
						<td>계약일</td>
						<td>계약상태</td>
						<td>계약자명</td>
						<td>자동점수</td>
						<td>수동점수</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${cttInfo.fin_nm}</td>
						<td>${cttInfo.prdln_nm}</td>
						<td>${cttInfo.scrts_no}</td>
						<td>${cttInfo.prd_nm}</td>
						<td>${cttInfo.ctt_dt}</td>
						<td>${cttInfo.ctt_stts}</td>
						<td>${cttInfo.cttor_nm}</td>
						<td>${cttInfo.auto_scr}</td>
						<td>${cttInfo.manual_scr}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div id="div_inspcRslt">
			<h5>> 검수결과</h5>
			<input type="button" value="저장">
			<c:set var="addManualInspcSpr" value="true"/>
			<c:set var="missellYnChk" value="false"/>
			<c:forEach var="inspcList" items="${inspcList}">
				<c:if test="${inspcList.inspc_spr eq '2'}">
					<c:set var="addManualInspcSpr" value="false"/>
				</c:if>
				<c:if test="${inspcList.missell_yn eq 'Y'}">
					<c:set var="chkMissellYn" value="true"/>
				</c:if>
			</c:forEach>
			<input type="checkbox" id="chk_missellYn" name="chk_missellYn" <c:if test="${chkMissellYn}">checked</c:if>>
			<label for="chk_missellYn">불완전판매 여부</label>
			<table>
				<thead>
					<tr>
						<td>검수결과 점수</td>
						<td>필수키워드</td>
						<td>누락키워드</td>
						<td>필수키워드 점수</td>
						<td>금지어</td>
						<td>금지어 점수</td>
						<td>검수구분</td>
					</tr>
				</thead>
				<tbody>	
					<c:forEach var="inspcList" items="${inspcList}">
						<c:if test="${inspcList.inspc_spr eq '1'}">
							<tr>
								<td>${inspcList.scr}</td>
								<td>${inspcList.esn_kwd_num}</td>
								<td>${inspcList.omsn_kwd_num}</td>
								<td>${inspcList.esn_kwd_scr}</td>
								<td>${inspcList.bnwd_cnt}</td>
								<td>${inspcList.bnwd_scr}</td>
								<td>${inspcList.inspc_spr_nm}</td>
							</tr>
						</c:if>
						<c:choose>
							<c:when test="${addManualInspcSpr}">
								<tr>
									<td><input type="text" name="scr"></td>
									<td><input type="text" name="esn_kwd_num"></td>
									<td><input type="text" name="omsn_kwd_num"></td>
									<td><input type="text" name="esn_kwd_scr"></td>
									<td><input type="text" name="bnwd_cnt"></td>
									<td><input type="text" name="bnwd_scr"></td>
									<td>수동</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:if test="${inspcList.inspc_spr eq '2'}">
									<tr>
										<td><input type="text" name="scr" value="${inspcList.scr}"></td>
										<td><input type="text" name="esn_kwd_num" value="${inspcList.esn_kwd_num}"></td>
										<td><input type="text" name="omsn_kwd_num" value="${inspcList.omsn_kwd_num}"></td>
										<td><input type="text" name="esn_kwd_scr" value="${inspcList.esn_kwd_scr}"></td>
										<td><input type="text" name="bnwd_cnt" value="${inspcList.bnwd_cnt}"></td>
										<td><input type="text" name="bnwd_scr" value="${inspcList.bnwd_scr}"></td>
										<td>${inspcList.inspc_spr_nm}</td>
									</tr>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="left_side">
			<div id="div_esnKwdUse">
				<h5>> 필수키워드 사용</h5>
				<p>키워드 더블클릭 시 텍스트 검색, 출현시간 더블클릭 시 녹취파일 재생</p>
				<table>
					<thead>
						<tr>
							<td>파일명</td>
							<td>키워드</td>
							<td colspan="3">출현시간</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>testRcd_1.wav</td>
							<td>보험</td>
							<td>00:00:01</td>
							<td>00:00:02</td>
							<td>00:00:03</td>
						</tr>
						<tr>
							<td>testRcd_1.wav</td>
							<td>만기</td>
							<td>00:00:01</td>
							<td>00:00:02</td>
							<td>00:00:03</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div id="div_banKwdUse">
				<h5>> 금지어 사용</h5>
				<p>키워드 더블클릭 시 텍스트 검색, 출현시간 더블클릭 시 녹취파일 재생</p>
				<table>
					<thead>
						<tr>
							<td>파일명</td>
							<td>키워드</td>
							<td colspan="3">출현시간</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>testRcd_1.wav</td>
							<td>대출</td>
							<td>00:00:01</td>
							<td>00:00:02</td>
							<td>00:00:03</td>
						</tr>
						<tr>
							<td>testRcd_1.wav</td>
							<td>감면</td>
							<td>00:00:01</td>
							<td>00:00:02</td>
							<td>00:00:03</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div id="div_omsEsnKwd">
				<h5>> 누락된 필수키워드</h5>
				<table>
					<thead>
						<tr>
							<td>필수키워드</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>상환</td>
						</tr>
						<tr>
							<td>상해</td>
						</tr>
						<tr>
							<td>요양</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div id="div_refRcdFl">
				<h5>> 관련 녹취파일</h5>
				<input type="button" value="재생">
				<table>
					<thead>
						<tr>
							<td>파일명</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>testRcd_1.wav</td>
						</tr>
						<tr>
							<td>testRcd_2.wav</td>
						</tr>
						<tr>
							<td>testRcd_3.wav</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div id="div_sttRslt">
			<h5>> 텍스트 변환 결과</h5>
			<div>
				<input type="text">
				<input type="button" value="저장">
				<input type="button" value="검색">
			</div>
			<textarea id="txt_sttRslt">여보세요.</textarea>
		</div>
		
	</section>
</div>
</body>
</html>