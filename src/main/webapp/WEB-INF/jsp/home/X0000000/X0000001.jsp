<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<% pageContext.setAttribute("newLine", "\n"); %>
<% String W_SIZE = request.getParameter("W_SIZE"); %>

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
		<div class="row g-5 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3 mt-4">
		
			<c:forEach var="item" items="${DISP_Y_LIST}" varStatus="status">
			<div class="col">
				<figure>
				  <figcaption class="fs-5 text-center" style="font-weight:bold; font-family:GamtanD;">${item.SUBJECT}</figcaption>
				  <div>			    
				    <div class="is-gradient" onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
				      <img class="is-rwd" src="${item.ATTR01}">
				    </div>
				    <p style="margin-top:20px; color:#000;font-family:GamtanD;">${fn:replace(item.ATTR02, newLine, '<br>')}
				    <div class="row py-3 px-3">
				    	<div class="col-9">
				    		<input style="height:38px;" class="w-100 d-block" type="text" placeholder="성함" value="${item.ATTR04}" <c:if test="${not empty item.ATTR04}">disabled</c:if>>
				    		<input style="height:38px;" class="w-100 d-block mt-1" type="text" placeholder="연락처" value="${item.ATTR05}" <c:if test="${not empty item.ATTR05}">disabled</c:if>>				    		
				    	</div>
				    	<c:choose>
				    	<c:when test="${empty item.ATTR04}">
				    	<button class="col-3" onclick="purchase(this,'${item.GROUP_ID}',${item.SEQ_NO})">확인</button>
				    	</c:when>
				    	<c:otherwise>
				    	<button class="col-3" onclick="purchase(this,'${item.GROUP_ID}',${item.SEQ_NO})" disabled>확정</button>
				    	</c:otherwise>
				    	</c:choose>
				    </div>
				  </div>
				</figure>			    
			</div>		
			</c:forEach>			
		</div>
		<div class="mt-3 d-flex justify-content-center">
			<c:if test="${1 lt PAGE_CTL.CURR_PAGE}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/${PAGE_CTL.PAGE}.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=1&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
				<span class="material-symbols-outlined">first_page</span>
			</a>	
			</c:if>
			<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/${PAGE_CTL.PAGE}.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
				<span class="material-symbols-outlined">chevron_left</span>
			</a>
			</c:if>
			<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center ${i eq PAGE_CTL.CURR_PAGE ? 'curr_page' : ''}" href="/${PAGE_CTL.PAGE}.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${i}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">${i}</a>
			</c:forEach>
			<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/${PAGE_CTL.PAGE}.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
				<span class="material-symbols-outlined">chevron_right</span>
			</a>
			</c:if>
			<c:if test="${PAGE_CTL.TOTAL_PAGE gt PAGE_CTL.CURR_PAGE}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/${PAGE_CTL.PAGE}.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.TOTAL_PAGE}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
				<span class="material-symbols-outlined">last_page</span>
			</a>	
			</c:if>	
		</div>		
	</div>
	
	<!--<jsp:include page="/WEB-INF/jspf/userBoardGalary.jsp" flush="false">
		<jsp:param name="W_SIZE" value="1024px" />
	</jsp:include>-->

	<c:if test="${not empty FOOTER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead mainHead-b" style='position:relative; background-image:url(${FOOTER_IMG.ATTR01}); <c:if test="${not empty FOOTER_IMG.ATTR04}">background-position-y:${FOOTER_IMG.ATTR04}%;</c:if> <c:if test="${not empty FOOTER_IMG.ATTR03}">height:${FOOTER_IMG.ATTR03}px;</c:if>'>
		    <p class="mainHead-title word fs-1" style='<c:if test="${not empty FOOTER_IMG.ATTR05}">margin-top:${FOOTER_IMG.ATTR05}px;</c:if>'>
		        ${FOOTER_IMG.ATTR02}
		    </p>
		</div>
	</div>
	</c:if>
	
  	<script>
  		function purchase(me, groupId, seqNo) {
  			$me = $(me);
  			$arr = $me.closest('div').find('input');
  			if ($arr[0].value && $arr[1].value) {
  				if (confirm('구매하시겠습니까?')) {
		  			$.ajax({
		  				type: 'POST'
		  				, url: '/bazaarPurchase.do'
		  				, data: JSON.stringify({GROUP_ID: groupId, SEQ_NO: seqNo, NAME:$arr[0].value, CONTACT:$arr[1].value})
		  				, dataType: 'JSON'
		  				, contentType: 'application/json; charset-utf-8'
		  				, success: function(data) {
		  					if(data.result == '0') {
		  						alert('이미 구매확정된 물품입니다.');
		  						$arr[0].value = '';
		  						$arr[1].value = '';
		  					} else {
		  						alert('구매가 완료되었습니다.');
		  					}
		  					$me.text('확정');
		  					$me.prop('disabled', true);
		  					$($arr[0]).prop('disabled', true);
		  					$($arr[1]).prop('disabled', true);
		  				}
		  				, error: function(xhr, status, error) {
		  					console.log(error);
		  				}
		  			}) 
  				}
  			}
  		}
  	</script>
  </body>
</html>
