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
		a.youtube, a.youtube:hover {color:red}
	</style>
	
	<div class="container-lg mt-4">
		<!-- <div class="d-flex flex-wrap justify-content-start">
		<c:forEach var="item" items="${BOARD_LIST}">  
			<div class="board-frame p-1" onclick="location.href='/admin/board/write.do?PAGE=${PAGE_CTL.PAGE}&SCREEN_YN=${PAGE_CTL.SCREEN_YN}&CURR_PAGE=${PAGE_CTL.CURR_PAGE}&GROUP_ID=${item.GROUP_ID}&SEQ_NO=${item.SEQ_NO}'">
				<div class="board-frame-background" style='background-image: url(${item.ATTR01});'></div>
				<div><span class="sub1">${item.GROUP_NM}</span></div>
				<div><span class="title ps-2">${item.SUBJECT}</span></div>
				<div class="text-end"><span class="sub1">${item.REG_DT}</span></div>
			</div>
		</c:forEach>
		</div> -->
		<c:forEach var="item" items="${BOARD_LIST}">
			<div class="row border-bottom py-2">
				<div class="col-md-3 text-center d-none d-md-block"><img src=${item.ATTR01} style="max-width:180px; max-height:142px;"></div>
				<div class='<c:if test="${not empty item.ATTR04}">col-md-7 col-9</c:if><c:if test="${empty item.ATTR04}">col</c:if>' onclick="goUrl('${item.SEQ_NO}','${item.GROUP_ID}', '${item.W_SIZE}', '${item.ATTR05}')" style="cursor:pointer;">
					<div><span class="fs-4" style="font-family:HSWinter;">${item.SUBJECT}</span><c:if test="${not empty item.ATTR02}"><span class="fs-6"> (${fn:substring(item.ATTR02,0,4)}-${fn:substring(item.ATTR02,4,6)}-${fn:substring(item.ATTR02,6,8)})</span></c:if></div>
					<c:if test="${not empty item.ATTR03}"><div class="border-top fs-5 text-md-end pt-2">${item.ATTR03}</div></c:if>
				</div>
				<c:if test="${not empty item.ATTR04}">
				<div class="col-md-2 col-3 d-flex justify-content-center align-items-center">
					<a href="${item.ATTR04}" target="blank" class="youtube">
						<span class="material-symbols-outlined" style="vertical-align: middle;">smart_display</span>
						<span style="vertical-align: middle; margin-left: 3px;">YouTube</span>
					</a>
				</div>
				</c:if>
			</div>
		</c:forEach>
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
		// javascript: location.href='/boardDtlView.do?SEQ_NO=${item.SEQ_NO}&GROUP_ID=${item.GROUP_ID}<c:if test="${not empty W_SIZE}">&W_SIZE=${W_SIZE}</c:if>'
		function goUrl(seqNo, groupId, wSize, link) {
			var urlStr = '';
			if (link) {
				urlStr = link;
			} else {
				urlStr = '/boardDtlView.do?SEQ_NO='+seqNo+'&GROUP_ID='+groupId;
				if (wSize) {
					urlStr = urlStr + ('&W_SIZE=' + wSize);
				}
				
			}
			location.href=urlStr;
			//window.open(urlStr);
		}
	</script>
