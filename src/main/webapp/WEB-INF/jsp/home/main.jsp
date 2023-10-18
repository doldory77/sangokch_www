<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>

    <title>Main</title>
  </head>
  <body>
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<div class="container-fluid pt-5 px-0">
		<!-- <div class="mainHead">HEAD IMG</div> -->
		<c:out value="${MAIN01.CONTENT}" escapeXml="false"></c:out>
	</div>
	<div class="container-md">
		<div class="row gy-4 justify-content-center row-cols-1 row-cols-sm-2 row-cols-md-3 mt-4">
			<c:out value="${MAIN02.CONTENT}" escapeXml="false"></c:out>
			<!-- <div class="col">
				<div class="mainItem">
					<div>IMG1</div>
					<p>저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 모든 국민은 능력에 따라 균등하게 교육을 받을 권리를 가진다. 국회는 헌법개정안이 공고된 날로부터 60일 이내에 의결하여야 하며, 국회의 의결은 재적의원 3분의 2 이상의 찬성을 얻어야 한다.</p>
				</div>
			</div>
			<div class="col">
				<div class="mainItem">
					<div>IMG2</div>
					<p>언론·출판에 대한 허가나 검열과 집회·결사에 대한 허가는 인정되지 아니한다.</p>
				</div>
			</div>
			<div class="col">
				<div class="mainItem">
					<div>IMG3</div>
					<p>전직대통령의 신분과 예우에 관하여는 법률로 정한다. 모든 국민은 종교의 자유를 가진다. 국회의원은 법률이 정하는 직을 겸할 수 없다. 혼인과 가족생활은 개인의 존엄과 양성의 평등을 기초로 성립되고 유지되어야 하며, 국가는 이를 보장한다.</p>
				</div>
			</div> -->
		</div>
	</div>
	
  	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  	<script>
  	
  	</script>
  </body>
</html>
