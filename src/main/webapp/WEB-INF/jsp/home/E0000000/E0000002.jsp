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
  <body style="background: url('https://cdn.pixabay.com/photo/2017/02/15/11/05/texture-2068283_1280.jpg')">
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<div class="container-fluid pt-5 px-0">
		<c:if test="${not empty HEADER_IMG}">
			<c:out value="${HEADER_IMG.CONTENT}" escapeXml="false"></c:out>
		</c:if>
	</div>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	<div class="container-fluid">
		<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3 mt-4">
			<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
				<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
			</c:forEach>
			
			<c:forEach var="item" items="${DISP_Y_LIST}" varStatus="status">
			<div class="col">
			    <div class="mainItem" style="background-color: white; border-radius: 10px; box-shadow: 5px 6px 3px #737373;">
			        <div style='background-image:url(${item.ATTR01}); cursor:pointer;' onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
			            ${item.SUBJECT}
			        </div>
			        <p style="color:#000;font-family:HSWinter;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
			    </div>
			</div>			
			</c:forEach>
						
		</div>
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
