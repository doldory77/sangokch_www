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
	<div style="max-width:1280px; width:100%; padding-top:49px; margin:0 auto;">
		<div id="hImgs" style="width:100%; height:320px; overflow:hidden; position:relative">
			<img style="visibility:hidden; position:absolute; top:-100px; left:-200px" src="http://life.sls.or.kr/user/saveDir/awd/P/0/slideImage_48320_43829.85188309374_0.jpg">
			<img style="visibility:hidden; position:absolute; top:-100px; left:-200px" src="http://life.sls.or.kr/user/saveDir/awd/P/0/slideImage_48320_722861.3680279801_0.jpg">
			<img style="visibility:hidden; position:absolute; top:-100px; left:-200px" src="http://life.sls.or.kr/user/saveDir/awd/P/0/slideImage_48320_780593.1756324916_0.jpg">
			<img style="visibility:hidden; position:absolute; top:-100px; left:-200px" src="http://life.sls.or.kr/user/saveDir/awd/P/0/slideImage_48320_592865.6863081582_0.jpg">
		</div>
	</div>
	
	<div style="max-width:1280px; width:100%; padding: 30px; margin:20px auto; background-color:#ede3e3;">
		<h4>표어</h4>
		<p>우리는 하나님의 가능성입니다. 무엇을 보는지, 무엇을 듣는 지에 따라 그 인생은 달라집니다. 삼일교회 중등부는 영원한 하나님 나라의 가치관을 가지고 가정과 교회, 그리고 학교에서 살아가는 예배와 문화 중심 공동체입니다. 삼일교회 3대 비전을 중심으로, 우리를 향한 하나님의 부르심에 초점을 맞추어 성장하는 중학생들입니다.</p>
	</div>
	
	<!-- <div class="d-flex justify-content-center align-items-center">
		<img style="max-width:1280px; max-height:625px; width:100%; margin-top:49px;" src="https://cdn.pixabay.com/photo/2017/06/20/08/12/maintenance-2422172_1280.jpg">
	</div> -->
	
	<!-- <div class="container-md">
		<div class="row gy-0 gx-0 justify-content-center row-cols-1 row-cols-sm-2 row-cols-lg-3 mt-4">
			<c:forEach var="item" items="${BODY_LIST}" varStatus="status">
				<div class="col">
				    <div class="mainItem">
				        <div style="background-image:url('${item.ATTR01}'); cursor:pointer;" onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
							${item.ATTR03}
				        </div>
				        <div style="color:#000;font-family:HSWinter;">
							<c:out value="${item.ATTR02}" escapeXml="false"></c:out>
				        </div>
				    </div>
				</div>
			</c:forEach>
			
			<c:forEach var="item" items="${DISP_Y_LIST}" varStatus="status">
			<div class="col">
			    <div class="mainItem">
			        <div style='background-image:url(${item.ATTR01}); background-size:cover; cursor:pointer;' onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
			            ${item.SUBJECT}
			        </div>
			        <div style="color:#000;font-family:HSWinter;">
						<c:out value="${item.ATTR02}" escapeXml="false"></c:out>
			        </div>
			    </div>
			</div>			
			</c:forEach>
			
		</div>
	</div>

	<c:if test="${not empty FOOTER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead mainHead-b" style='position:relative; background-image:url(${FOOTER_IMG.ATTR01}); <c:if test="${not empty FOOTER_IMG.ATTR04}">background-position-y:${FOOTER_IMG.ATTR04}%;</c:if> <c:if test="${not empty FOOTER_IMG.ATTR03}">height:${FOOTER_IMG.ATTR03}px;</c:if>'>
		    <p class="mainHead-title word fs-1" style='<c:if test="${not empty FOOTER_IMG.ATTR05}">margin-top:${FOOTER_IMG.ATTR05}px;</c:if>'>
		        ${FOOTER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if> -->
	    
  	<script>
  		function anim($elem, idx, mTime) {
  			var $obj = $elem.eq(idx);
  			if ($obj && $obj.length) {
  				$obj.css('visibility','visible');
  				$obj.animate({top:-300, left:-300}, mTime, function(){
  					$obj.css({
  						'visibility':'hidden'
  						, 'top':'-100px'
  						, 'left':'-200px'
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
