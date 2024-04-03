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
        .triangle { display:inline-block; border:20px solid transparent }
        .triangle-bottom { border-bottom-color: red }
        .l-year { text-align: right; padding: 16px; border-right: 6px solid red; font-size: 1.2rem; font-weight: bold; } 
        .r-month { position: relative; padding: 16px; }
        .r-month a { color:black; }
        .r-month a:hover { color:red; }
        .point1 { position: absolute; background-color:red; height: 5px; width: 10px; margin-left: -16px; margin-top: 10px; }
        .point2 { width:24px; margin-left:-31px; }
        .base { position: absolute; background-color:red; width:20px; height:20px; border-radius: 50%; margin-left: -13px; margin-top: -5px; }
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
	</div>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	<!-- <div class="container-lg mt-2">
		<div class="row gy-0">
			<div class="col-2" style="background:url('/images/tree_top_left.webp'); height:210px; background-repeat: no-repeat; background-position: right;"></div>
			<div class="col"  style="background:url('/images/tree_top_right.webp'); height:210px; background-repeat: no-repeat;"></div>
		</div>
		<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
			<div class="row gy-0">
				<div class="col-2">
					<div class="fs-2 text-end">${item.ATTR04}</div>
				</div>
				<div class="col-4 ps-5" style="background:url('/images/tree_body.webp'); background-repeat: y-repeat;">
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
			<div class="col-2"></div>
			<div class="col" style="background:url('/images/tree_bottom.webp'); height:60px; background-repeat: no-repeat;"></div>
		</div>		
	</div> -->
	
	<div class="container-lg mt-2">
        <div class="row gx-0">
            <div class="col-3"></div>
            <div class="col-9 position-relative" style="height:40px;">
                <div class="triangle triangle-bottom position-absolute" style="margin-left:-22px;"></div>                    
            </div>
        </div>
        <c:forEach var="item" items="${BODY_LIST}" varStatus="status">
        <div class="row gx-0">
            <div class="col-3 l-year">${item.ATTR04}</div>
            <div class="col-5 r-month">
                <div class='point1 <c:if test="${not empty item.ATTR04}">point2</c:if>'></div>
                <div>
                	<div>${fn:substring(item.ATTR03,4,8)}월</div>
                	<div style="font-size:1.1rem; font-wight:bold;"><a href="/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}">${item.SUBJECT}</a></div>
                	<div>${item.ATTR02}</div>
                </div>
            </div>
            <div class="col-4"><img class="rounded" width="100" src="${item.ATTR01}"></div>
        </div>        
        </c:forEach>
        <div class="row gx-0">
            <div class="col-3"></div>
            <div class="col-9 position-relative" style="height:40px;">
                <div class="base"></div>                    
            </div>
        </div>        	
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
