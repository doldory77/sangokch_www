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
		<div class="mainHead mainHead-b mainHead-small mainHead-large" style='position:relative; background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR04}">background-position-y:${HEADER_IMG.ATTR04}%;</c:if>'>
		    <div class="mainHead-title word fs-1">
		        ${HEADER_IMG.ATTR02}
		    </div>
		</div>
	</div>
	</c:if>
	
	<div class="container-lg">

		<div class="row mt-3">
			<div class="col-12 col-md-6">
				<div class="row gy-3 ps-0 ps-md-2">
					<c:forEach var="item" items="${BODY_IMG}" varStatus="status">
					<div class="col-12">
						<img src="${item.ATTR01}" style="width:100%">
					</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-12 col-md-6 d-flex align-items-center">
				<div class="row gy-2 gy-md-5">
					<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
					<div class="col-12 pt-3 pt-md-0 text-center">
						<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
