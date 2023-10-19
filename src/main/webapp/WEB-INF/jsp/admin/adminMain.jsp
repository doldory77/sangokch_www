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
	<div class="container-fluid">
		<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3">
			<div class="col">
				<div>
					<div class="d-flex justify-content-between bg-primary">
						<span class="text-light">MENU1</span>
						<span><input onclick="" class="d-none" id="menu1" type="checkbox"><label for="menu1">+/-</label></span>
					</div>
					<ul>
						<li>MENU1-1</li>
						<li>MENU1-2</li>
						<li>MENU1-3</li>
						<li>MENU1-4</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		
	</script>
	
  </body>
</html>
