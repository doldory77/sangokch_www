<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String W_SIZE = request.getParameter("W_SIZE");
%>
<c:set var="W_SIZE" value="<%=W_SIZE%>"/>
	
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
	
	<div class="container-lg">

		<div class="row g-5 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3 mt-4">
		
			<c:forEach var="item" items="${DISP_Y_LIST}" varStatus="status">
			<div class="col">
				<figure>
				  <figcaption class="fs-5 text-center" style="font-weight:bold; font-family:GamtanD;">${item.SUBJECT}</figcaption>
				  <div>			    
				    <div class="is-gradient" onclick="location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}'">
				      <img loading="lazy" class="is-rwd" src="${item.ATTR01}">
				    </div>
				    <p style="margin-top:20px; color:#000;font-family:GamtanD;">${fn:replace(item.ATTR02, newLine, '<br>')}</p>
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
	
	<script>

	</script>
