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
  <body <c:if test="${not empty BODY_IMG}">style="background: url('${BODY_IMG.ATTR01}')"</c:if>>
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<div class="container-fluid pt-5 px-0">
		<!--<c:if test="${not empty HEADER_IMG}">
			<c:out value="${HEADER_IMG.CONTENT}" escapeXml="false"></c:out>
		</c:if>-->
		<div class="mainHead" style='background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR03}">height:${HEADER_IMG.ATTR03};</c:if>'>
		    <p class="word fs-1" style="color:#000; font-family:HSWinter;">
		        ${HEADER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	<div class="container-md">
		<div class="row gy-0 gx-0 justify-content-center row-cols-1 row-cols-sm-2 row-cols-lg-3 mt-4">
			<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
				<!--<c:out value="${item.CONTENT}" escapeXml="false"></c:out>-->
				<div class="col">
				    <div class="mainItem">
				        <div style="background-image:url('${item.ATTR01}'); cursor:pointer;" onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
							${item.ATTR03}
				        </div>
				        <p style="color:#000;font-family:HSWinter;">
							${item.ATTR02}
				        </p>
				    </div>
				</div>
			</c:forEach>
		</div>
	</div>

	<c:if test="${not empty FOOTER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead" style='background-image:url(${FOOTER_IMG.ATTR01}); <c:if test="${not empty FOOTER_IMG.ATTR03}">height:${FOOTER_IMG.ATTR03};</c:if>'>
		    <p class="word fs-1" style="color:#fff; font-family:HSWinter;">
		        ${FOOTER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if>
	    
  	<script>
  		
  	</script>
  </body>
</html>
