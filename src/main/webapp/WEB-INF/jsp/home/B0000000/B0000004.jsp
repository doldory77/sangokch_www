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
        .triangle-bottom { border-bottom-color: #071952 }
        .l-year { text-align: right; padding: 16px; border-right: 6px solid #071952; font-size: 1.2rem; font-weight: bold; } 
        .r-month { position: relative; padding: 16px; }
        .r-month a { color:black; }
        .r-month a:hover { color:#071952; }
        .point1 { position: absolute; background-color:#071952; height: 5px; width: 10px; margin-left: -16px; margin-top: 10px; }
        .point2 { width:24px; margin-left:-31px; }
        .base { position: absolute; background-color:#071952; width:20px; height:20px; border-radius: 50%; margin-left: -13px; margin-top: -5px; }
		@media(max-width:480px) {
	    	.img-small {
	    		display:none;
	    	}
	    }
	    @media(min-width:481px) {
	    	.img-large {
	    		display:block;
	    	}
	    }
    </style>    
    
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
	
	
	<div class="container-lg mt-2">
        <div class="row gx-0">
            <div class="col-3 col-sm-3 col-lg-4"></div>
            <div class="col-9 col-sm-9 col-lg-8 position-relative" style="height:40px;">
                <div class="triangle triangle-bottom position-absolute" style="margin-left:-23px;"></div>                    
            </div>
        </div>
        <c:forEach var="item" items="${BODY_LIST}" varStatus="status">
        <div class="row gx-0">
            <div class="col-3 col-sm-3 col-lg-4 l-year">${item.ATTR04}</div>
            <div class="col-7 col-sm-5 col-lg-4 r-month">
                <div class='point1 <c:if test="${not empty item.ATTR04}">point2</c:if>'></div>
                <div>
                	<div>${fn:substring(item.ATTR03,4,8)}월</div>
                	<div style="font-size:1.1rem; font-wight:bold;"><a href="/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}"><strong>${item.SUBJECT}</strong></a></div>
                	<div>${item.ATTR02}</div>
                </div>
            </div>
            <div class="col-2 col-sm-4 col-lg-4">
            	<img loading="lazy" class="img-small img-large rounded" style="height:140px; width:220px; max-height:140px; margin-top:16px; box-shadow: 3px 3px 3px gray;" src="${item.ATTR01}">
            </div>
        </div>        
        </c:forEach>
        <div class="row gx-0">
            <div class="col-3 col-sm-3 col-lg-4"></div>
            <div class="col-9 col-sm-9 col-lg-8 position-relative" style="height:40px;">
                <div class="base"></div>                    
            </div>
        </div>        	
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
