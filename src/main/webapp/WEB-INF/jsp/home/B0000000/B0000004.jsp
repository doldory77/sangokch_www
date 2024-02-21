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
	<div class="container-lg mt-2">
		<c:forEach var="item" items="${MAIN02_LIST}" varStatus="status">
			<div class="row gy-0">
				<div class="col-2"><div class="fs-1 text-end">${item.ATTR02}</div></div>
				<div class="col-4 border-start border-5">
					<div class="fs-5">${fn:substring(item.ATTR03,4,8)}월</div>
					<div class="fs-4">
						<a href="/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}">${item.SUBJECT}</a>
					</div>
				</div>
				<div class="col-6 p-1"><img class="rounded" width="200" src="${item.ATTR04}"></div>
			</div>
		</c:forEach>
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
