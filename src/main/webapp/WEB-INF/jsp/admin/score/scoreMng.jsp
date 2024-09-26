<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"	   uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>${TITLE}</title>
	
  	<style>

	</style>

  </head>
  <body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-items-center p-2">
		    <span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/home.do'">home</span>	
		    <span class="py-1 align-self-baseline">${TITLE}</span>
	    	<span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/admin/login/logout.do'">logout</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<img src="${applicationScope.ENV['CD0002_05']['VALUE_STR']}" width="22">
			<span class="pth" onclick="javascript:location.href='/admin/main.do'">홈페이지 관리</span><span class="pth">&nbsp;&gt;&nbsp;</span><span class="pth">${TITLE}</span>
		</div>
	</div>   
  	<div class="container-fluid">
  		<form action="/admin/score/scoreMng.do">
  		<div class="d-flex align-items-center p-2">
	  		<div>
	  			<label for="P_SUBJECT">제목</label>
	  			<input name="SUBJECT" id="P_SUBJECT" type="text" style="width:300px; height:36px;" value="${PAGE_CTL.SUBJECT}">
	  		</div>
	  		<div class="ps-2">
	  			<label for="P_S_KEY">조성</label>
	  			<select name="S_KEY" id="P_S_KEY" style="width:80px; height:38px; text-align:center;">
					<option value="" <c:if test="${empty PAGE_CTL.S_KEY}">selected</c:if>>전체</option>
					<option value="C" <c:if test="${PAGE_CTL.S_KEY eq 'C'}">selected</c:if>>C</option>
					<option value="D" <c:if test="${PAGE_CTL.S_KEY eq 'D'}">selected</c:if>>D</option>
					<option value="E" <c:if test="${PAGE_CTL.S_KEY eq 'E'}">selected</c:if>>E</option>
					<option value="F" <c:if test="${PAGE_CTL.S_KEY eq 'F'}">selected</c:if>>F</option>
					<option value="G" <c:if test="${PAGE_CTL.S_KEY eq 'G'}">selected</c:if>>G</option>
					<option value="A" <c:if test="${PAGE_CTL.S_KEY eq 'A'}">selected</c:if>>A</option>
					<option value="B" <c:if test="${PAGE_CTL.S_KEY eq 'B'}">selected</c:if>>B</option>
				</select>
	  		</div>
	  		<div class="ps-2"><input type="submit" value="조회" style="height:36px; width:80px;"></div>
  		</div>	
  		</form>
	</div>
	
	<!-- 목록 시작 -->
	<div class="container-fluid">
		<div class="d-flex flex-wrap justify-content-start">
		<c:forEach var="item" items="${SCORE_LIST}">  
			<div class="d-flex flex-column justify-content-between board-frame p-1" >
				<c:if test="${not empty item.URL}"><div class="board-frame-background" style="background-image: url('${item.URL}');"></div></c:if>
				<div class="d-flex justify-content-between align-items-center">
					<span class="sub1">${item.S_KEY}</span>
				</div>
				<div class="d-flex align-items-center">
					<c:if test="${sessionScope.USER_INFO.admYn eq 'Y'}"><a href="#" onclick="delScore(${item.SEQ_NO}, '${item.SUBJECT}'); return false;" class="btn btn-sm" style="background-color: #B80000; color: white;">삭제</a></c:if>
					<span class="title ps-2" onclick="window.open('${item.URL}')">${item.SUBJECT}</span>
				</div>
			</div>
		</c:forEach>
		</div>
		<div class="mt-2 py-2 d-flex justify-content-center border-top">
		
		<c:if test="${1 lt PAGE_CTL.CURR_PAGE}">
		<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/score/scoreMng.do?CURR_PAGE=1&SUBJECT=${PAGE_CTL.SUBJECT}&S_KEY=${PAGE_CTL.S_KEY}">
			<span class="material-symbols-outlined">first_page</span>
		</a>	
		</c:if>
		<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
		<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/score/scoreMng.do?CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&SUBJECT=${PAGE_CTL.SUBJECT}&S_KEY=${PAGE_CTL.S_KEY}">
			<span class="material-symbols-outlined">chevron_left</span>
		</a>
		</c:if>
		<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
		<a class="d-flex m-1 paging-btn justify-content-center align-items-center ${i eq PAGE_CTL.CURR_PAGE ? 'curr_page' : ''}" href="/admin/score/scoreMng.do?CURR_PAGE=${i}&SUBJECT=${PAGE_CTL.SUBJECT}&S_KEY=${PAGE_CTL.S_KEY}">${i}</a>
		</c:forEach>
		<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
		<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/score/scoreMng.do?CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&SUBJECT=${PAGE_CTL.SUBJECT}&S_KEY=${PAGE_CTL.S_KEY}">
			<span class="material-symbols-outlined">chevron_right</span>
		</a>
		</c:if>
		<c:if test="${PAGE_CTL.TOTAL_PAGE gt PAGE_CTL.CURR_PAGE}">
		<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/score/scoreMng.do?CURR_PAGE=${PAGE_CTL.TOTAL_PAGE}&SUBJECT=${PAGE_CTL.SUBJECT}&S_KEY=${PAGE_CTL.S_KEY}">
			<span class="material-symbols-outlined">last_page</span>
		</a>	
		</c:if>			
		</div>
	</div>
	<!-- 목록 끝 -->
	
	<div class="container-fluid mt-3">
		<form name="frm" method="POST" action="/admin/score/save.do" enctype="multipart/form-data" onsubmit="return false;">
		<div class="row align-items-center mt-1 p-1">
			<div class="col fs-4">등록
			</div>
		</div>
		<div class="row align-items-center mt-1 p-1">
			<div class="col-2">
				<label for="SUBJECT">제목 :</label>
			</div>
			<div class="col">
				<input type="text" name="SUBJECT" id="SUBJECT" style="width:60%;">
			</div>
		</div>	
		<div class="row align-items-center mt-1 p-1">
			<div class="col-2">
				<label for="S_KEY">조성 :</label>
			</div>
			<div class="col">
				<select name="S_KEY" id="S_KEY" style="width:80px; height:38px; text-align:center;">
					<option value="C">C</option>
					<option value="D">D</option>
					<option value="E">E</option>
					<option value="F">F</option>
					<option value="G" selected>G</option>
					<option value="A">A</option>
					<option value="B">B</option>
				</select>
			</div>
		</div>
		<div class="row align-items-center mt-1 p-1">
			<div class="col-2">
				<label for="URL">URL :</label>
			</div>
			<div class="col">
				<input type="text" name="URL" id="URL" style="width:80%;">
			</div>
		</div>			
		<div class="row align-items-center mt-1 p-1">
			<div class="col-2">
				<label for="FILE">파일 :</label>
			</div>
			<div class="col">
				<input type="file" name="FILE" id="FILE" style="width:40%;">
			</div>
		</div>			
		<div class="row align-items-center mt-4">
			<div class="col" style="text-align:center;">
				<button class="btn btn-primary" onclick="goSubmit()">등록</button>
			</div>
		</div>
		</form>
	</div>
	
	<script>
		function goSubmit() {
			var ptn = /.*[0-9]{8}[.]html$/;
			var frm = document.frm;
			if (!document.frm.SUBJECT.value) {
				alert('제목은 필수입니다.');
				return;
			}
			const fileInput = document.getElementById('FILE')
			const files = fileInput.files;
			if (!document.frm.URL.value && files.length === 0) {
				alert('파일선택 또는 URL입력, 둘중 하나는 필수입니다.');
				return;
			}
			frm.submit();
		}
		function delScore(seqNo, subject){
			if (confirm('[' + subject + ']을(를) 완전히 삭제하시겠습니까?')) {
				location.href="/admin/score/delete.do?SEQ_NO="+seqNo+"&CURR_PAGE="+${empty PAGE_CTL.CURR_PAGE}+"&SUBJECT="+'${PAGE_CTL.SUBJECT}'+"&S_KEY="+'${PAGE_CTL.S_KEY}';
			}
		}  	
	</script>
	
  </body>
</html>
