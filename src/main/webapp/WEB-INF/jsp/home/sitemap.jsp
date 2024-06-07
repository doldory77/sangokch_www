<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<% pageContext.setAttribute("newLine", "\n"); %>

<!doctype html>
<html lang="ko">
  <head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<link rel="stylesheet" href="/css/font.css">
    <title>${TITLE}</title>
    <style>
		.mMm {
			width:240px;
			margin-bottom: 24px;
			font-family: "GamtanD";
		}
		.mMm a {color: inherit;}
		.mMm ul {padding-left: 10px;}
		.mMm ul li {
			height: 38px;
			line-height: 38px;
		}
		.mMm ul li a {
			color: inherit;
		}
		.bImg {
			position: fixed;
		    display: block;
		    z-index: -1;
		    bottom: 0;
		    left: 0;
		    overflow: hidden;
		    opacity: 0.3;
		    width: 100%;
		}
    </style>
  </head>
  <body>

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-PD22H4MR"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
  
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<!--<c:if test="${not empty HEADER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead" style='position:relative; background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR03}">height:${HEADER_IMG.ATTR03};</c:if>'>
		    <p class="word fs-1" style='color:${empty HEADER_IMG.ATTR04 ? "#fff" : HEADER_IMG.ATTR04}; font-family:HSWinter;'>
		        ${HEADER_IMG.ATTR02}
		    </p>
		</div>
		
	</div>
	</c:if>-->
	
	<div class="container-lg" style="padding-top:68px;">
		<div class="d-flex justify-content-center align-items-center mb-3" style="width:100%; height:100px;">
			<span class="fs-3" style="font-family:'GamtanD';">사이트맵</span>
		</div>
		<div class="d-flex flex-wrap justify-content-center">
		<c:forEach var="mMenu" items="${MENU_LIST}" varStatus="status">
			<div class="mMm">
				<div style="font-size:1.25rem; font-weight:bold; margin-right:20px; border-bottom: 1px solid black;">
					<c:choose>
					<c:when test="${not empty mMenu.URL}"><a href="${mMenu.URL}">${mMenu.MENU_NM}</a></c:when>
					<c:otherwise>${mMenu.MENU_NM}</c:otherwise>
					</c:choose>	
				</div>
				<ul>
					<c:forEach var="sMenu" items="${mMenu.SUB_MENU}" varStatus="statusS">
					<li style="font-size:1.1rem;"><a href="${sMenu.URL}">${sMenu.MENU_NM}</a></li>	
					</c:forEach>
				</ul>
			</div>
		</c:forEach>
		</div>
		
		<img class="bImg" src="https://cdn.pixabay.com/photo/2020/06/02/05/29/church-5249458_1280.png">
		
	</div>
	
  	<script>

  	</script>
  	
  </body>
</html>
