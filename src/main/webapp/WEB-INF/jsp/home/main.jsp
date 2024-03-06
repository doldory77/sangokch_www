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
		<!-- <div class="mainHead">HEAD IMG</div> -->
		<c:out value="${MAIN01.CONTENT}" escapeXml="false"></c:out>
	</div>
	<!-- <div>${applicationScope.ENV['CD0002_05']['VALUE_STR']}</div> -->
	<div class="container-md">
		<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3 mt-4">
			<c:forEach var="item" items="${MAIN02_LIST}" varStatus="status">
				<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
			</c:forEach>
		</div>
	</div>
    
  	<script>
  		var words = ["홈페이지를", "새롭게", "단장하고 있습니다.", " 빠를 시간내에", "선보이겠습니다."],
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
