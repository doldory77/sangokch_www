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
			<div class="d-flex flex-column justify-content-between board-frame p-1" >
				<div class="board-frame-background" style='background-image: url(${item.ATTR01});'></div>
				<div class="d-flex justify-content-between align-items-center">
					<span class="sub1">${item.GROUP_NM}</span>
					<span class="sub2 text-danger"><c:choose><c:when test="${item.USE_YN eq 'Y'}">(사용)</c:when><c:otherwise>(미사용)</c:otherwise></c:choose></span>
				</div>
				<div class="d-flex align-items-center">
					<c:if test="${sessionScope.USER_INFO.admYn eq 'Y'}"><a href="#" onclick="delBoard('${PAGE_CTL.PAGE}','${PAGE_CTL.CURR_PAGE}','${item.GROUP_ID}','${item.SEQ_NO}','${item.SUBJECT}'); return false;" class="btn btn-sm" style="background-color: #B80000; color: white;">삭제</a></c:if>
					<span class="title ps-2" onclick="location.href='/admin/board/write.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE}&GROUP_ID=${item.GROUP_ID}&SEQ_NO=${item.SEQ_NO}'">${item.SUBJECT}</span>
				</div>
				<div class="d-flex justify-content-between align-items-center">
					<span class="sub2">${item.TAG_NM}</span>
					<span class="sub2 text-danger"><c:choose><c:when test="${item.SCREEN_YN eq 'Y'}">(꾸밈요소)</c:when><c:otherwise></c:otherwise></c:choose></span>
					<span class="sub1">${item.REG_DT}</span>
				</div>
			</div>
		</c:forEach>
		</div>
		<div class="mt-2 py-2 d-flex justify-content-center border-top">
		<c:choose>
			<c:when test="${not empty IS_SUB_BOARD && IS_SUB_BOARD eq 'Y'}">
				<c:if test="${1 lt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=1&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">first_page</span>
				</a>	
				</c:if>
				<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">chevron_left</span>
				</a>
				</c:if>
				<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center ${i eq PAGE_CTL.CURR_PAGE ? 'curr_page' : ''}" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${i}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">${i}</a>
				</c:forEach>
				<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">chevron_right</span>
				</a>
				</c:if>
				<c:if test="${PAGE_CTL.TOTAL_PAGE gt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminIfrmPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.TOTAL_PAGE}&GROUP_ID=${PAGE_CTL.GROUP_ID}&TAG_CD=${PAGE_CTL.TAG_CD}">
					<span class="material-symbols-outlined">last_page</span>
				</a>	
				</c:if>	
			</c:when>
			<c:otherwise>
				<c:if test="${1 lt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=1&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">first_page</span>
				</a>	
				</c:if>
				<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">chevron_left</span>
				</a>
				</c:if>
				<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center ${i eq PAGE_CTL.CURR_PAGE ? 'curr_page' : ''}" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${i}&GROUP_ID=${PAGE_CTL.GROUP_ID}">${i}</a>
				</c:forEach>
				<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">chevron_right</span>
				</a>
				</c:if>
				<c:if test="${PAGE_CTL.TOTAL_PAGE gt PAGE_CTL.CURR_PAGE}">
				<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/adminPage.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.TOTAL_PAGE}&GROUP_ID=${PAGE_CTL.GROUP_ID}">
					<span class="material-symbols-outlined">last_page</span>
				</a>	
				</c:if>			
			</c:otherwise>
		</c:choose>	
		</div>
	</div>
	<script>
	function delBoard(page, currPage, groupId, seqNo, subject){
		if (confirm('[' + subject + ']을(를) 완전히 삭제하시겠습니까?')) {
			location.href="/admin/board/delete.do?PAGE="+page+"&CURR_PAGE="+currPage+"&GROUP_ID="+groupId+"&SEQ_NO="+seqNo;
		}
	}	
	</script>
