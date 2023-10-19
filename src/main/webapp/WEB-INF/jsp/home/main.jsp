<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>

    <title>Main</title>
  </head>
  <body>
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<div class="container-fluid pt-5 px-0">
		<!-- <div class="mainHead">HEAD IMG</div> -->
		<c:out value="${MAIN01.CONTENT}" escapeXml="false"></c:out>
	</div>
	<div class="container-md">
		<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3 mt-4">
			<c:forEach var="item" items="${MAIN02_LIST}" varStatus="status">
				<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
			</c:forEach>
		</div>
	</div>
    
  	<script>
  	
  	</script>
  </body>
</html>
