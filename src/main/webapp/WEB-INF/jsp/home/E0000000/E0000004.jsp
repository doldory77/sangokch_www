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
	
	<c:if test="${not empty HEADER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead mainHead-b" style='position:relative; background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR04}">background-position-y:${HEADER_IMG.ATTR04}%;</c:if> <c:if test="${not empty HEADER_IMG.ATTR03}">height:${HEADER_IMG.ATTR03}px;</c:if>'>
		    <p class="mainHead-title word fs-1" style='<c:if test="${not empty HEADER_IMG.ATTR05}">margin-top:${HEADER_IMG.ATTR05}px;</c:if>'>
		        ${HEADER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if>
	
	<div class="container-lg">
		<div class="row g-5 justify-content-center row-cols-1 row-cols-md-2 mt-4">
			<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
				<!--<c:out value="${item.CONTENT}" escapeXml="false"></c:out>-->
				<div class="col">
				    <div class="mainItem" style="border-radius: 10px; box-shadow: 3px 3px 3px #6a5858;">
				        <div class="bg-lazy" data-bgimage='${item.ATTR01}' style="cursor:pointer;" onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
							${item.ATTR03}
				        </div>
				        <div style="color:#000;font-family:HSWinter;">
							<c:out value="${item.ATTR02}" escapeXml="false"></c:out>
				        </div>
				    </div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/jspf/userBoardGalary.jsp" flush="false">
		<jsp:param name="W_SIZE" value="1024px" />
	</jsp:include>

	<c:if test="${not empty FOOTER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead mainHead-b bg-lazy" data-bgimage='${FOOTER_IMG.ATTR01}' style='position:relative; <c:if test="${not empty FOOTER_IMG.ATTR04}">background-position-y:${FOOTER_IMG.ATTR04}%;</c:if> <c:if test="${not empty FOOTER_IMG.ATTR03}">height:${FOOTER_IMG.ATTR03}px;</c:if>'>
		    <p class="mainHead-title word fs-1" style='<c:if test="${not empty FOOTER_IMG.ATTR05}">margin-top:${FOOTER_IMG.ATTR05}px;</c:if>'>
		        ${FOOTER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if>
	
  	<script>
  		
  	</script>
  </body>
</html>
