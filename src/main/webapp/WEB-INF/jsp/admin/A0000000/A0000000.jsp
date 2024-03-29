<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>홈페이지 메인화면 관리</title>
	
  	<style>

	</style>
  	
  </head>
  <body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-items-center p-2">
		    <span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/home.do'">home</span>	
		    <span class="py-1 align-self-baseline">홈페이지 메인화면 관리</span>
	    	<span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/admin/login/logout.do'">logout</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<img src="${applicationScope.ENV['CD0002_05']['VALUE_STR']}" width="22">
			<span class="pth" onclick="javascript:location.href='/admin/main.do'">홈페이지 관리</span><span class="pth">&nbsp;&gt;&nbsp;</span><span class="pth">홈페이지 메인화면 관리</span>
		</div>
	</div>   
  	<div class="container-fluid">
		<a class="btn btn-sm px-4 my-2" style="background-color: #B80000; color: white;" href="/admin/board/write.do?PAGE=${PAGE}&SCREEN_YN=${SCREEN_YN}&GROUP_ID=${GROUP_ID}">작성</a>
	</div>
	<jsp:include page="/WEB-INF/jspf/adminBoardList.jsp" flush="false" />
	
	<script>
		/*스크립트 작성*/
	</script>
	
  </body>
</html>
