<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>교회소개 관리(산곡교회 연혁)</title>
	
  	<style>

	</style>
  	
  </head>
  <body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-content-end p-2">
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/home.do'">산곡교회</span>
		    <span class="py-1 align-self-baseline">산곡교회 연혁</span>
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/admin/login/logout.do'">로그아웃</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<span onclick="javascript:location.href='/admin/main.do'">홈페이지 관리 홈</span><span>&nbsp;&gt;&nbsp;</span><span>교회소개 관리(산곡교회 연혁)</span>
		</div>
	</div>   
  	<div class="container-fluid">
		<a class="btn btn-sm px-4 my-2" style="background-color: #B80000; color: white;" href="/admin/board/write.do?PAGE=${PAGE}&SCREEN_YN=${SCREEN_YN}&GROUP_ID=${GROUP_ID}">작성</a>
	</div>
	<jsp:include page="/WEB-INF/jspf/adminBoardList.jsp" flush="false" />
	
	<iframe width="100%" height="300px" style="border-top:1px dotted darkgray; margin-top:20px;" src="/admin/adminIfrmPage.do?GROUP_ID=B0000004&SCREEN_YN=N&PAGE=B0000004&TAG_CD=04"></iframe>
	
	<script>
		/*스크립트 작성*/
	</script>
	
  </body>
</html>
