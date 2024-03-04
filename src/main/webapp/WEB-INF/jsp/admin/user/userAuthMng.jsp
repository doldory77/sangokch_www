<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>권한관리</title>
</head>
<body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-content-end p-2">
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/home.do'">산곡교회</span>
		    <span class="py-1 align-self-baseline">권한관리</span>
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/admin/login/logout.do'">LOG-OUT</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<span onclick="javascript:location.href='/admin/main.do'">홈페이지 관리 홈</span>
			<span>&nbsp;&gt;&nbsp;</span>
			<span onclick="javascript:location.href='/admin/user/userMng.do'">사용자관리</span>
			<span>&nbsp;&gt;&nbsp;</span>
			<span>권한관리</span>
		</div>
	</div>
	<div class="container-md">
		
		<table class="table caption-top mt-4">
			<caption><span id="userId">${USER_ID}</span> 권한목록</caption>
			<thead>
				<tr style="background-color:#F3F0CA">
					<th scope="col">#</th>
					<th scope="col">메뉴레벨</th>
					<th scope="col">메뉴ID</th>
					<th scope="col">메뉴명</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="auth" items="${AUTH}" varStatus="status">
				<tr>
					<th scope="row">${status.count}</th>
					<td>${auth.MENU_LEVEL}</td>
					<td>${auth.MENU_ID}</td>
					<td><c:if test="${auth.MENU_LEVEL gt 1}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:if>${auth.PRE_STR} ${auth.MENU_NM}</td>
					<td>
						<select class="form-select">
			  				<option value="Y" <c:if test="${auth.USE_YN eq 'Y'}">selected</c:if>>Y</option>
							<option value="N" <c:if test="${auth.USE_YN eq 'N'}">selected</c:if>>N</option>
			  			</select>					
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="text-center"><a class="btn btn-primary" href="javascript:false;" onclick="saveAuth();">생성(수정)</a></div>
		
	</div>
</body>
	<script>
		//AJAX 통신 시작
		$( document ).ajaxStart(function() {
		    //마우스 커서를 로딩 중 커서로 변경
		    $('html').css("cursor", "wait"); 
		});
		//AJAX 통신 종료
		$( document ).ajaxStop(function() {
		    //마우스 커서를 원래대로 돌린다
		    $('html').css("cursor", "auto"); 
		});
		
		var saveAuth = function() {
			var auth = [];
			$('tbody tr').each(function(index, item){
				var $item = $(item);
				auth.push({ 
							USER_ID: $('#userId').text()
							, MENU_ID: $item.children('td:eq(1)').text()
							, USE_YN: $('tbody tr:eq('+index+') td:eq(3) select option:selected').val()
						 });
			});
			//console.log(auth);
			$.ajax({
				type: 'POST'
				, url: '/admin/user/saveUserAuth.do'
				, data: JSON.stringify(auth)
				, dataType: 'JSON'
				, contentType: 'application/json; charset-utf-8'
				, success: function(rtnData) {
					//console.log(rtnData);
					if (rtnData.result === 'SUCCESS') {
						alert('생성(수정)이 완료되었습니다.');
					}
				}
				, error: function(xhr, status, error) {
					console.log("code: " + xhr.status);
			        console.log("message: " + xhr.responseText);
			        console.log("error: " + error);
					alert('오류가 발생했습니다. 관리자에세 문의바랍니다.');
				}
			}); 
		}
	</script>
</html>