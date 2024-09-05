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
	
	<!-- <c:if test="${not empty HEADER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead" style='position:relative; background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR04}">background-position-y:${HEADER_IMG.ATTR04}%;</c:if> <c:if test="${not empty HEADER_IMG.ATTR03}">height:${HEADER_IMG.ATTR03}px;</c:if>'>
		    <p class="mainHead-title word fs-1" style='<c:if test="${not empty HEADER_IMG.ATTR05}">margin-top:${HEADER_IMG.ATTR05}px;</c:if>'>
		        ${HEADER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if> -->
	
	<c:if test="${not empty ROLLING_IMG}">
	<div style="max-width:1280px; width:100%; padding-top:49px; margin:0 auto;">
		<div id="hImgs" style="width:100%; height:320px; overflow:hidden; position:relative">
			<c:forEach var="item" items="${ROLLING_IMG}" varStatus="status">
			<img style="visibility:hidden; position:absolute; top:-100px; left:0px" src="${item.ATTR01}">
			</c:forEach>
		</div>
	</div>
	</c:if>
	
	<c:if test="${not empty TEXT_LIST}">
	<c:forEach var="item" items="${TEXT_LIST}" varStatus="status">
	<div style="max-width:1280px; width:100%; padding: 30px; margin:20px auto; background-color:#ede3e3;">
		<c:out value="${item.CONTENT}" escapeXml="false"></c:out>
	</div>
	</c:forEach>
	</c:if>
	
	<!-- <div class="d-flex justify-content-center align-items-center">
		<img style="max-width:1280px; max-height:625px; width:100%; margin-top:49px;" src="https://cdn.pixabay.com/photo/2017/06/20/08/12/maintenance-2422172_1280.jpg">
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
			<c:forEach var="item" items="${BOARD_LIST}" varStatus="status">
				<c:choose>
				<c:when test="${not empty item.ATTR04}">
					<div class="col">
						<div class="mainItem mainItem-b">
						<div>
							<iframe width="100%" height="330" src="${item.ATTR04}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
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
  		function anim($elem, idx, mTime) {
  			var $obj = $elem.eq(idx);
  			if ($obj && $obj.length) {
  				$obj.css('visibility','visible');
  				$obj.animate({top:-300, left:-10}, mTime, function(){
  					$obj.css({
  						'visibility':'hidden'
  						, 'top':'-100px'
  						, 'left':'0px'
  					});
  					anim($elem, idx+1, mTime);
  				});
  			} else if (idx > 0) {
  				anim($elem, 0, mTime);
  			}
  		}
  		$(document).ready(function(){
  			/*if ($('#hImgs img:eq(0)').length) {
  				$('#hImgs img:eq(0)').animate({top:-300, left:-300}, 10000, function(){alert('end');});
  			}*/
  			anim($('#hImgs img'), 0, 10000);
  		})
  	</script>
  </body>
</html>
