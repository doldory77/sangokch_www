<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String IS_SUB_BOARD = request.getParameter("IS_SUB_BOARD");
%>
<c:set var="IS_SUB_BOARD" value="<%=IS_SUB_BOARD%>"/>

	<div class="container-fluid">
		<div class="d-flex flex-wrap justify-content-start">
		<c:forEach var="item" items="${BOARD_LIST}">  
			<div class="board-frame p-1" onclick="location.href='/admin/board/write.do?PAGE=${PAGE_CTL.PAGE}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&CURR_PAGE=${PAGE_CTL.CURR_PAGE}&GROUP_ID=${item.GROUP_ID}&SEQ_NO=${item.SEQ_NO}'">
				<div class="board-frame-background" style='background-image: url(${item.ATTR01});'></div>
				<div><span class="sub1">${item.GROUP_NM}</span></div>
				<div><span class="title ps-2">${item.SUBJECT}</span></div>
				<div class="d-flex justify-content-between align-items-center">
					<span class="sub2">${item.TAG_NM}</span>
					<span class="sub1">${item.REG_DT}</span>
				</div>
			</div>
		</c:forEach>
		</div>
		<div class="d-flex">
		<c:choose>
			<c:when test="${not empty IS_SUB_BOARD && IS_SUB_BOARD eq 'Y'}">
				<c:if test="${1 lt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=1&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">first_page</span>
				</a>	
				</c:if>
				<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">chevron_left</span>
				</a>
				</c:if>
				<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center ${i eq PAGE_CTL.CURR_PAGE ? 'curr_page' : ''}" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${i}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">${i}</a>
				</c:forEach>
				<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">chevron_right</span>
				</a>
				</c:if>
				<c:if test="${PAGE_CTL.TOTAL_PAGE gt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.TOTAL_PAGE}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">last_page</span>
				</a>	
				</c:if>	
			</c:when>
			<c:otherwise>
				<c:if test="${1 lt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=1&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">first_page</span>
				</a>	
				</c:if>
				<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">chevron_left</span>
				</a>
				</c:if>
				<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center ${i eq PAGE_CTL.CURR_PAGE ? 'curr_page' : ''}" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${i}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}">${i}</a>
				</c:forEach>
				<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">chevron_right</span>
				</a>
				</c:if>
				<c:if test="${PAGE_CTL.TOTAL_PAGE gt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.TOTAL_PAGE}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">last_page</span>
				</a>	
				</c:if>			
			</c:otherwise>
		</c:choose>	
		</div>
	</div>
