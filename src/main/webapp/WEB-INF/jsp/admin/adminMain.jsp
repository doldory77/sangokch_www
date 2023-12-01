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
  		.group-menu {
  			height: 34px;
  		}
  		.group-menu span:nth-of-type(2) {
  			height: 24px;
  			color: white;
  		}
		.group-menu + ul {
			border: 1px solid #c2c2c2;
			overflow: hidden;
		}
		.group-menu + ul li {
			height: 0px;
			opacity: 0;
			transition: all .35s;
		}
		.group-menu input[type="checkbox"]:checked + label span:nth-child(1) {
			transform: rotate( 180deg );
		}
		.group-menu:has(input[type="checkbox"]:checked) + ul li {
			height: 34px;
			opacity: 1;
		}
		.group-menu-wrapper:hover {
			box-shadow: 3px 3px 3px gray;
		}
		.group-main-menu {
			color: white;
			display: inline-block;
			width: 120px;
			
		}
		/*.group-main-menu:hover {
			color: white;
		}
		.group-main-menu+span {
			color: white;
		}*/
		.menu-nm {
			display: inline-block;
			width: 120px;
		}
		
	</style>
  	
  </head>
  <body>
	<div class="container-fluid">
		<div class="fs-4"><span>메뉴별 페이지 관리</span></div>
		<div class="row g-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3">
			<c:forEach var="mainMenu" items="${MENU_LIST}" varStatus="status">
			<div class="col">
				<div class="group-menu-wrapper">
					<div class="group-menu d-flex justify-content-between align-items-center bg-primary px-1">
					<c:choose>
						<c:when test="${not empty mainMenu.MNG_URL}">
						<a href="${mainMenu.MNG_URL}">
						</c:when>
						<c:otherwise>
						<a>
						</c:otherwise>
					</c:choose>	
							<span class="group-main-menu">${mainMenu.MENU_NM}</span>
							<span style="font-size:0.8rem;">${mainMenu.MENU_ID}</span>
						</a>
						<span>
							<input class="d-none" id="menu${status.count}" type="checkbox">
							<label style="color: white; cursor: pointer;" for="menu${status.count}"><span class="material-symbols-outlined">expand_more</span></label>
						</span>
					</div>
					<ul>
						<c:forEach var="sumMenu" items="${mainMenu.SUB_MENU}">
						<li style="cursor: pointer;"><a href="${sumMenu.MNG_URL}"><span class="menu-nm">${sumMenu.MENU_NM}</span><span style="font-size:0.8rem;">${sumMenu.MENU_ID}</span></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
	
	<script>
		
	</script>
	
  </body>
</html>
