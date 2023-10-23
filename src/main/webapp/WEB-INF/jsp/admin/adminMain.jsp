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
		
	</style>
  	
  </head>
  <body>
	<div class="container-fluid">
		<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3">
			<c:forEach var="mainMenu" items="${MENU_LIST}" varStatus="status">
			<div class="col">
				<div>
					<div class="group-menu d-flex justify-content-between align-items-center bg-primary px-1">
						<span class="text-light">${mainMenu.MENU_NM}</span>
						<span>
							<input class="d-none" id="menu${status.count}" type="checkbox">
							<label for="menu${status.count}"><span class="material-symbols-outlined">expand_more</span></label>
						</span>
					</div>
					<ul>
						<c:forEach var="sumMenu" items="${mainMenu.SUB_MENU}">
						<li>${sumMenu.MENU_NM}</li>
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
