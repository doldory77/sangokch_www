<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>화면구성</title>
	
  	<style>

	</style>
  	
  </head>
  <body>
  	<div class="container-fluid">
	  	<div class="fs-4"><span class="material-symbols-outlined">local_florist</span><span>${BOARD_TITLE}</span></div>
		<a class="btn btn-sm btn-secondary" href="/admin/board/write.do">작성</a>
	</div>
	<jsp:include page="/WEB-INF/jspf/boardList.jsp" flush="false" />
	
	<script>
		/*스크립트 작성*/
	</script>
	
  </body>
</html>
