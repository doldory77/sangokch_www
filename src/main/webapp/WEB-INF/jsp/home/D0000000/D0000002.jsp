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
		.item-badge {
			position: absolute;
		    background-color: #000;
		    /*display: inline-block;*/
		    width: 140px;
		    height: 32px;
		    opacity: 0.3;
		    text-align: center;
		    margin: 5px;
		    right:0;
		    cursor:pointer;
		}
		.item-badge > div:first-child {
			color: white;
    		line-height: 32px;
		}		
    </style>  
  </head>
  <body <c:if test="${not empty BODY_IMG}">style="background: url('${BODY_IMG.ATTR01}')"</c:if>>
  
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
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	
	<div class="container-lg">
		<div class="row gy-3 gx-0 justify-content-center row-cols-1 row-cols-md-2 mt-4">
			<!-- 상시표시 -->
			<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
				<c:choose>
				<c:when test="${not empty item.ATTR04}">
					<div class="col">
						<div class="mainItem mainItem-b">
						<div>
							<iframe width="100%" height="297.5" src="${item.ATTR04}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
						</div>
						<div style="color:#000;font-family:GamtanD;">
				        	<div><strong>${item.SUBJECT}</strong></div>
							<p style="padding-left:5px;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
				        </div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col" style="position:relative;">
						<div class="item-badge hide show" onclick="goDtl(this);"><div>더보기</div></div>
					    <div class="mainItem mainItem-b">
					        <c:choose>
					    	<c:when test="${not empty item.ATTR05}">
					    		<div class="small-width large-width" style='background-image:url(${item.ATTR01}); cursor:pointer; background-size: cover;' onclick="location.href='${item.ATTR05}'"></div>
					    	</c:when>
					    	<c:otherwise>
					        	<div class="small-width large-width" style='background-image:url(${item.ATTR01}); cursor:pointer; background-size: cover;' onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'"></div>
					    	</c:otherwise>
					    	</c:choose>
					        <div style="color:#000;font-family:GamtanD;">
								<div><strong>${item.SUBJECT}</strong></div>
								<!--<c:out value="${item.ATTR02}" escapeXml="false"></c:out>-->
								<p style="padding-left:5px;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
					        </div>
					    </div>
					</div>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 이밴트성 표시 -->
			<c:forEach var="item" items="${DISP_Y_LIST}" varStatus="status">
				<c:choose>
				<c:when test="${not empty item.ATTR04}">
					<div class="col">
						<div class="mainItem mainItem-b">
						<div>
							<iframe width="100%" height="297.5" src="${item.ATTR04}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
						</div>
						<div style="color:#000;font-family:GamtanD;">
				        	<div><strong>${item.SUBJECT}</strong></div>
							<p style="padding-left:5px;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
				        </div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col" style="position:relative;">
						<div class="item-badge hide show" onclick="goDtl(this);"><div>더보기</div></div>
					    <div class="mainItem mainItem-b">
					        <c:choose>
					    	<c:when test="${not empty item.ATTR05}">
					    		<div class="small-width large-width" style='background-image:url(${item.ATTR01}); cursor:pointer; background-size: cover;' onclick="location.href='${item.ATTR05}'"></div>
					    	</c:when>
					    	<c:otherwise>
					        	<div class="small-width large-width" style='background-image:url(${item.ATTR01}); cursor:pointer; background-size: cover;' onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'"></div>
					    	</c:otherwise>
					    	</c:choose>
					        <div style="color:#000;font-family:GamtanD;">
								<div><strong>${item.SUBJECT}</strong></div>
								<!--<c:out value="${item.ATTR02}" escapeXml="false"></c:out>-->
								<p style="padding-left:5px;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
					        </div>
					    </div>
					</div>
				</c:otherwise>
				</c:choose>			
			</c:forEach>
			
		</div>
	</div>

	<c:if test="${not empty FOOTER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead mainHead-b" style='position:relative; background-image:url(${FOOTER_IMG.ATTR01}); <c:if test="${not empty FOOTER_IMG.ATTR04}">background-position-y:${FOOTER_IMG.ATTR04}%;</c:if> <c:if test="${not empty FOOTER_IMG.ATTR03}">height:${FOOTER_IMG.ATTR03}px;</c:if>'>
		    <p class="mainHead-title word fs-4" style='color: #ffffff; text-shadow: 2px 2px 3px #736b6b; padding: 0 10%;<c:if test="${not empty FOOTER_IMG.ATTR05}">margin-top:${FOOTER_IMG.ATTR05}px;</c:if>'>
		        ${fn:replace(FOOTER_IMG.ATTR02, newLine, '<br>')}
		    </p>
		</div>
	</div>
	</c:if>
	    
  	<script>
  		function goDtl(me) {
  			$(me).next().children('div:eq(0)').click();
  		}
  	</script>
  </body>
</html>
