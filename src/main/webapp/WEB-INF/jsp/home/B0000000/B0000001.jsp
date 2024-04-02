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
	
	<c:if test="${not empty HEADER_IMG}">
	<div class="container-fluid pt-5 px-0">
			
		<div class="mainHead" style='position:relative; background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR03}">height:${HEADER_IMG.ATTR03};</c:if>'>
		    <p class="word fs-1" style='color:${empty HEADER_IMG.ATTR04 ? "#fff" : HEADER_IMG.ATTR04}; font-family:HSWinter;'>
		        ${HEADER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	
	<!-- col-lg-0 col-lg-12 -->
	<div class="container-lg">
		<div class="row ps-sm-2 mt-5">
			<c:out value="${BODY_IMG.CONTENT}" escapeXml="false"></c:out>
			<div class="col col-sm-7 col-lg-8">
				<div class="row h-100 gy-4 justify-content-center align-items-center row-cols-1 row-cols-lg-3">
					<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
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
