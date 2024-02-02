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
	<link rel="stylesheet" href="/css/font.css">
    <title>${TITLE}</title>
  </head>
  <body>
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<div class="container-fluid pt-5 px-0">
		<c:if test="${not empty MAIN01}">
			<c:out value="${MAIN01.CONTENT}" escapeXml="false"></c:out>
		</c:if>
	</div>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	
	<div class="container-lg">
		<div class="row ps-sm-2">
			<div class="col-sm-6 col-lg-0 mt-4" style="background-image:url(https://cdn.pixabay.com/photo/2020/04/09/05/37/resurrection-5019777_640.jpg); background-position: center center;"></div>
			<div class="col-sm-6 col-lg-12">
				<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-1 row-cols-lg-3 mt-4">
					<c:forEach var="item" items="${MAIN02_LIST}" varStatus="status">
						<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
