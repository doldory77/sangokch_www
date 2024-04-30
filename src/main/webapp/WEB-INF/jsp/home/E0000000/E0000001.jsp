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
    <style>
    	.b0002-photo {
    		min-width: 200px;
    		width: 50%;
    	}
    </style>
  </head>
  <body>
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<div class="container-fluid pt-5 px-0">
		<c:if test="${not empty HEADER_IMG}">
			<c:out value="${HEADER_IMG.CONTENT}" escapeXml="false"></c:out>
		</c:if>
		
		<c:if test="${not empty BOARD_LIST}">
		<div class="row">
			<iframe src="${BOARD_LIST[0].ATTR05}" style="margin:0 auto; width:1494px; height:804px;"></iframe>
		</div>
		</c:if>
	</div>
	
	
	
	<jsp:include page="/WEB-INF/jspf/userBoardList.jsp" flush="false">
		<jsp:param name="W_SIZE" value="1024px" />
	</jsp:include>
    
  </body>
</html>
