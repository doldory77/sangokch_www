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
    	.footer {
    		background-color:#071952; 
    		color:#F2F7A1;
    		position: fixed;
    		bottom: 0px;
    		width: 100%;
    		height: 56px;
    	}
    </style>
  </head>
  <body>
  
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<c:if test="${not empty HEADER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<c:out value="${HEADER_IMG.CONTENT}" escapeXml="false"></c:out>
	</div>
	</c:if>
	
	<c:if test="${not empty ROLL_IMG_LIST}">
	<div id="carouselSlides" class="carousel slide" data-bs-ride="carousel">
	  <div class="carousel-indicators">
	  <c:forEach var="item" items="${ROLL_IMG_LIST}" varStatus="status">
	    <button type="button" data-bs-target="#carouselSlides" data-bs-slide-to="${status.index}" <c:if test="${status.index eq 0}">class="active" aria-current="true"</c:if> aria-label="Slide ${status.count}"></button>
	  </c:forEach>
	  </div>		
	  <div class="carousel-inner">
	  	<c:forEach var="item" items="${ROLL_IMG_LIST}" varStatus="status">
	    <div class='carousel-item <c:if test="${status.index eq 0}">active</c:if>'>
	      <img src="${item.CONTENT}" class="d-block w-100" alt="...">
	      <div class="carousel-caption d-none d-md-block">
	        <h4 style="color:#fff;font-family:HSWinter;">빠른시간에 홈페이지 오픈 예정입니다.</h4>
	      </div>
	    </div>
	    </c:forEach>
	  </div>
	</div>	
	</c:if>
	
	<!-- <div>${applicationScope.ENV['CD0002_05']['VALUE_STR']}</div> -->
	<div class="container-md" style="margin-bottom: 80px;">
		<div class="row gy-0 gx-0 justify-content-center row-cols-1 row-cols-sm-2 mt-4">
			<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
				<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
			</c:forEach>
		</div>
	</div>
	
	<div class="footer d-flex justify-content-center align-items-center">
		<span class="material-symbols-outlined">map</span>
		<div class="ps-1">인천광역시 부평구 길주로326번길 13</div>
		<span class="material-symbols-outlined ps-3">call</span>
		<div class="ps-1">032-512-2504</div>
	</div>
  	<script>
  		var words = ["홈페이지를", "새롭게", "단장하고 있습니다.", " 빠른 시간내에", "선보이겠습니다."],
		    part,
		    i = 0,
		    offset = 0,
		    len = words.length,
		    forwards = true,
		    skip_count = 0,
		    skip_delay = 15,
		    speed = 70;
	
		var wordflick = function () {
		  setInterval(function () {
		    if (forwards) {
		      if (offset >= words[i].length) {
		        ++skip_count;
		        if (skip_count == skip_delay) {
		          forwards = false;
		          skip_count = 0;
		        }
		      }
		    }
		    else {
		      if (offset == 0) {
		        forwards = true;
		        i++;
		        offset = 0;
		        if (i >= len) {
		          i = 0;
		        }
		      }
		    }
		    part = words[i].substr(0, offset);
		    if (skip_count == 0) {
		      if (forwards) {
		        offset++;
		      }
		      else {
		        offset--;
		      }
		    }
		    $(".word").text(part);
		  },speed);
		};
		
		$(document).ready(function () {
		  wordflick();
		});
  	</script>
  </body>
</html>
