<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>다음세대(어린이부)</title>
	
  	<style>

	</style>
  	
  </head>
  <body>
 
  	<div class="container-fluid">
		<a class="btn btn-sm px-4 my-2" style="background-color: #EAD196; color: black;" href="/admin/board/write.do?PAGE=${PAGE}&SCREEN_YN=${SCREEN_YN}&GROUP_ID=${GROUP_ID}&TAG_CD=${TAG_CD}">작성</a>
	</div>
	<jsp:include page="/WEB-INF/jspf/adminBoardList.jsp" flush="false">
		<jsp:param name="IS_SUB_BOARD" value="Y" />
	</jsp:include>
	
  </body>
</html>
