<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
		<a class="btn btn-sm px-4 my-2" style="background-color: #B80000; color: white;" href="/admin/board/write.do?PAGE=${PAGE}&SCREEN_YN=${SCREEN_YN}&GROUP_ID=${GROUP_ID}">작성</a>
	</div>
	
	<jsp:include page="/WEB-INF/jspf/adminBoardList.jsp" flush="false" />
	
	<div class="container-fluid mt-3">
		<form name="frm" method="POST" action="/admin/weekly/save.do" enctype="multipart/form-data" onsubmit="return false;">
		<div class="row align-items-center mt-1">
			<div class="col-3">
				<label for="wFileNm">주보파일 <span style="color:red;">(예: 20240303.html)</span></label>
			</div>
			<div class="col">
				<input type="file" name="W_FILE_NM" id="wFileNm">
			</div>
		</div>	
		<div class="row align-items-center mt-1">
			<div class="col-3">
				<label for="wStylNm">주보 스타일시트 <span style="color:red;">(예: 20240303_style.css)</span></label>
			</div>
			<div class="col">
				<input type="file" name="W_STYL_NM" id="wStylNm">
			</div>
		</div>
		<div class="row  align-items-center mt-1">
			<div class="col">
				<button class="btn btn-primary" onclick="goSubmit()">전송</button>
			</div>
		</div>
		<input type="hidden" name="GROUP_ID" value="${GROUP_ID}">	
		<input type="hidden" name="PAGE" value="${PAGE}">	
		</form>
	</div>
	
	<script>
		function goSubmit() {
			var ptn = /.*[0-9]{8}[.]html$/;
			var frm = document.frm;
			if (!document.frm.W_FILE_NM.value) {
				alert('주보파일(html)은 필수입니다.');
				return;
			}
			if (!ptn.test(document.frm.W_FILE_NM.value)) {
				console.log(document.frm.W_FILE_NM.value);
				alert('주포파일(html) 파일명 형식이 일치하지 않습니다.\n형식:예)20240317.html');
				return;
			}
			if (!document.frm.W_STYL_NM.value) {
				alert('주보 스타일시트(css) 파일은 필수입니다.');
				return;
			}
			frm.submit();
		}
	</script>
	
  </body>
</html>
