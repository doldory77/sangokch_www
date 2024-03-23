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
		/*img {
		  width: 50vw;
		  vertical-align: middle;
		}*/
		
		img.is-rwd {
		  width: 100%;
		  height: auto;
		}
		
		.is-wood {
		  width: 100%;
		  border: 20px solid #dca56b;
		  border-image: url("/images/wood_frame.png") 50 64;
		  box-shadow: 3px 3px 3px #6a5858;
		  cursor:pointer;
		}
		
		.is-gradient {
		  width: 100%;
		  border: 20px solid #f98b14;
		  border-image: linear-gradient(-45deg, #00b9e9, #f98b14, #503370) 20;
		}    
    </style>
  </head>
  <!-- <body style="background: url('https://cdn.pixabay.com/photo/2017/02/15/11/05/texture-2068283_1280.jpg')"> -->
  <body <c:if test="${not empty BODY_IMG}">style="background: url('${BODY_IMG.ATTR01}')"</c:if>>
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
			    <!-- <div class="mainItem" style="background-color: white; border-radius: 10px; box-shadow: 5px 6px 3px #737373;">
			        <div style='background-image:url(${item.ATTR01}); cursor:pointer;' onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
			            ${item.SUBJECT}
			        </div>
			        <p style="color:#000;font-family:HSWinter;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
			    </div>-->
				<figure>
				  <figcaption class="fs-5 text-center">${item.SUBJECT}</figcaption>
				  <div>			    
				    <div class="is-wood" onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
				      <img class="is-rwd" src="${item.ATTR01}">
				    </div>
				    <p style="margin-top:20px; color:#000;font-family:HSWinter;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
				  </div>
				</figure>			    
			</div>		
			</c:forEach>
						
		</div>
		
	</div>

    
  	<script>
  		
  	</script>
  </body>
</html>
