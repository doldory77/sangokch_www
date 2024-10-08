<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String IS_SUB_BOARD = request.getParameter("IS_SUB_BOARD");
%>
<c:set var="IS_SUB_BOARD" value="<%=IS_SUB_BOARD%>"/>

	<div class="container-fluid">
		<div class="d-flex flex-wrap justify-content-start">
		<c:forEach var="item" items="${BOARD_LIST}">  
			<div class="d-flex flex-column justify-content-between board-frame p-1" >
				<c:if test="${not empty item.ATTR01}"><div class="board-frame-background" style='background-image: url(${item.ATTR01});'></div></c:if>
				<div class="d-flex justify-content-between align-items-center">
					<span class="sub1">${item.GROUP_NM}</span>
					<c:if test="${fn:length(item.ATTR03) le 8}"><span class="sub1">${item.ATTR03}</span></c:if>
					<!-- <span class="sub2 text-danger">
						<c:choose><c:when test="${item.USE_YN eq 'Y'}">(사용)</c:when><c:otherwise>(미사용)</c:otherwise></c:choose>
					</span> -->
					<c:if test="${sessionScope.USER_INFO.admYn eq 'Y'}">
					<fieldset>
					  <span class="sub2 text-danger" style="vertical-align: super;">사용</span>
					  <label class="swlabel">
					    <input role="switch" id="sw_${item.SEQ_NO}" onclick="toggleBoard('${PAGE_CTL.PAGE}','${PAGE_CTL.CURR_PAGE}','${item.GROUP_ID}','${item.SEQ_NO}','${item.SUBJECT}'); return false;" type="checkbox" ${item.USE_YN eq 'Y' ? 'checked' : ''} />
					    <span></span>
					  </label>
					</fieldset>
					</c:if>
				</div>
				<div class="d-flex align-items-center">
					<c:if test="${sessionScope.USER_INFO.admYn eq 'Y'}">
						<!-- <a href="#" onclick="delBoard('${PAGE_CTL.PAGE}','${PAGE_CTL.CURR_PAGE}','${item.GROUP_ID}','${item.SEQ_NO}','${item.SUBJECT}'); return false;" class="btn btn-sm" style="background-color: #B80000; color: white;">삭제</a> -->
						<span style="color:red; cursor:pointer;" onclick="delBoard('${PAGE_CTL.PAGE}','${PAGE_CTL.CURR_PAGE}','${item.GROUP_ID}','${item.SEQ_NO}','${item.SUBJECT}'); return false;" class="material-symbols-outlined">delete_forever</span>
					</c:if>
					<span class="title ps-2" onclick="location.href='/admin/board/write.do?PAGE=${PAGE_CTL.PAGE}&CURR_PAGE=${PAGE_CTL.CURR_PAGE}&GROUP_ID=${item.GROUP_ID}&SEQ_NO=${item.SEQ_NO}'">${item.SUBJECT}</span>
					
					<c:if test="${sessionScope.USER_INFO.admYn eq 'Y'}">
					<fieldset style="text-align:end;">
					  <span class="sub2 text-danger" style="display:block; text-align:center;">메인노출</span>
					  <label class="swlabel">
					    <input role="switch2" id="sw2_${item.SEQ_NO}" onclick="toggleShowBoard('${PAGE_CTL.PAGE}','${PAGE_CTL.CURR_PAGE}','${item.GROUP_ID}','${item.SEQ_NO}','${item.SUBJECT}'); return false;" type="checkbox" ${item.MAIN_DISP_YN eq 'Y' ? 'checked' : ''} />
					    <span></span>
					  </label>
					</fieldset>
					</c:if>					
										
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
	
	function toggleBoard(page, currPage, groupId, seqNo, subject){
		var $swbtn = $('#sw_'+seqNo);
		var useYnFlag =  $swbtn.prop('checked');
		var useYn = useYnFlag == true ? 'Y' : 'N'
		var msg = '';
		
		if (useYnFlag) {
			msg = '[' + subject + ']을(를) 활성화 합니다.';
		} else {
			msg = '[' + subject + ']을(를) 비활성화 합니다.';
		}
		if (confirm(msg)) {
			location.href="/admin/board/useYn.do?PAGE="+page+"&CURR_PAGE="+currPage+"&GROUP_ID="+groupId+"&SEQ_NO="+seqNo+"&USE_YN="+useYn;
		}
	}
	
	function toggleShowBoard(page, currPage, groupId, seqNo, subject){
		
		var $swbtn = $('#sw2_'+seqNo);
		var showYnFlag =  $swbtn.prop('checked');
		var showYn = showYnFlag == true ? 'Y' : 'N'
		var msg = '';
		
		if (showYnFlag) {
			msg = '[' + subject + ']을(를) 보이게 합니다.';
		} else {
			msg = '[' + subject + ']을(를) 보이지 않게 합니다.';
		}
		if (confirm(msg)) {
			location.href="/admin/board/showYn.do?PAGE="+page+"&CURR_PAGE="+currPage+"&GROUP_ID="+groupId+"&SEQ_NO="+seqNo+"&MAIN_DISP_YN="+showYn;
		}
	}
	</script>
