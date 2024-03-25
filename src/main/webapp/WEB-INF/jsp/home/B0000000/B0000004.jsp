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
		<c:if test="${not empty HEADER_IMG}">
			<c:out value="${HEADER_IMG.CONTENT}" escapeXml="false"></c:out>
		</c:if>
	</div>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	<div class="container-lg mt-2">
		<div class="row gy-0">
			<div class="col" style="background:url('/images/tree_top.png'); height:195px; background-repeat: no-repeat;"></div>
			
		</div>
		<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
			<div class="row gy-0">
				<div class="col-2" style="background:url('/images/tree_body.png'); background-repeat: y-repeat;">
					<div class="fs-1 text-start">${item.ATTR04}</div>
				</div>
				<div class="col-4" style="background-color:transparent;">
					<div class="fs-5">${fn:substring(item.ATTR03,4,8)}월</div>
					<div class="fs-4">
						<a href="/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}">${item.SUBJECT}</a>
					</div>
					<div class="ps-2"><pre>${item.ATTR02}</pre></div>
				</div>
				<div class="col p-1"><img class="rounded" width="200" src="${item.ATTR01}"></div>
			</div>
		</c:forEach>
		<div class="row gy-0">
			<div class="col" style="background:url('/images/tree_bottom.png'); height:77px; background-repeat: no-repeat;"></div>
			
		</div>		
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
