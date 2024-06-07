<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>화면구성</title>
	
  	<style>

	</style>
  	
  </head>
  <body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-items-center p-2">
		    <span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/home.do'">home</span>	
		    <span class="py-1 align-self-baseline">홈페이지 관리</span>
	    	<span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/admin/login/logout.do'">logout</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<img src="${applicationScope.ENV['CD0002_05']['VALUE_STR']}" width="22">
			<span class="pth">홈페이지 관리</span>
		</div>
	</div>  
	<div class="container-fluid">
		<div class="d-flex justify-content-center align-items-center my-4">
			<div><span>오눌 방문자 수: </span><strong>${COUNT_LIST[0].CNT_TODAY}</strong></div>
			<div class="ms-2"><span>당월 방문자 누적수: </span><strong>${COUNT_LIST[0].CNT_MONTH}</strong></div>
		</div>
		<div class="row g-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3">
			<c:forEach var="mainMenu" items="${MENU_LIST}" varStatus="status">
			<c:if test="${sessionScope.USER_INFO.authMap[mainMenu.MENU_ID] eq 'Y'}">
			<div class="col">
				<div class="group-menu-wrapper" onclick="mainMenuClick(event)">
					<div class="group-menu d-flex justify-content-between align-items-center bg-primary px-2">
					<c:choose>
						<c:when test="${not empty mainMenu.MNG_URL}">
						<a href="${mainMenu.MNG_URL}">
							<span class="group-main-menu">${mainMenu.MENU_NM}<small class="ms-2">(${mainMenu.MENU_ID})</small></span>
						</a>
						</c:when>
						<c:otherwise>
							<span class="group-main-menu">${mainMenu.MENU_NM}<small class="ms-2">(${mainMenu.MENU_ID})</small></span>
						</c:otherwise>
					</c:choose>
					<c:if test="${empty mainMenu.MNG_URL}">
						<span style="border: 1px solid white;">
							<input class="d-none" id="menu${status.count}" type="checkbox">
							<label style="color: white; cursor: pointer;" for="menu${status.count}"><span class="material-symbols-outlined">expand_more</span></label>
						</span>
					</c:if>
					</div>
					
					<ul>
						<c:forEach var="sumMenu" items="${mainMenu.SUB_MENU}">
						<c:if test="${sessionScope.USER_INFO.authMap[sumMenu.MENU_ID] eq 'Y'}">
						<li onclick="subMenuClick(event)">
							<a href="${sumMenu.MNG_URL}"><span class="menu-nm">ㄴ ${sumMenu.MENU_NM}</span><span style="font-size:0.8rem;">${sumMenu.MENU_ID}</span></a>
						</li>
						</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
			</c:if>
			</c:forEach>
		</div>
		
	</div>
	
	<script>
		function mainMenuClick(event) {
			//console.log(event.target);
			$a = $(event.target).find('a:eq(0)');
			$input = $(event.target).find('input:eq(0)');
			if ($a.text()) {
				location.href = $a.attr('href');
			}
			if ($input.val()) {
				$input.trigger('click');
			}
			event.stopPropagation();
		}
		
		function subMenuClick(event) {
			//console.log(event.target);
			$a = $(event.target).children('a:eq(0)');
			location.href = $a.attr('href');
			event.stopPropagation();
		}
	</script>
	
  </body>
</html>
