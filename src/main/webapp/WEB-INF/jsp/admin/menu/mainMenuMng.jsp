<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>메인메뉴관리</title>
	
</head>
<body>
	<div class="container-md">
		<form method="POST" action="/admin/code/saveCodeGroup.do">
			<fieldset>
				<legend>메인메뉴관리<a href="/admin/main.do">관리자 메인</a></legend>
				<div class="mb-3">
					<label for="menuId" class="form-label">메뉴ID</label>
					<input type="text" name="MENU_ID" class="form-control" id="menuId">
					<div class="form-text">하위메뉴를 구분하는 상위메뉴입니다.(예: )</div>
				</div>
				<div class="mb-3">
					<label for="menuNm" class="form-label">그룹코드명</label>
					<input type="text" name="MENU_NM" class="form-control" id="menuNm">
				</div>
				<div class="text-end"><button type="submit" class="btn btn-primary">수정</button></div>
			</fieldset>
		</form>
		
		<table class="table caption-top mt-4">
			<caption>메인메뉴목록</caption>
			<thead>
				<tr style="background-color:#F3F0CA">
					<th scope="col">#</th>
					<th scope="col">메뉴ID</th>
					<th scope="col">메뉴명</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="menu" items="${MAIN_MENU}" varStatus="status">
				<tr>
					<th scope="row">${menu.count}</th>
					<td><a href="javascript:false;" onclick="selectMenu(this);">${menu.MENU_ID}</a></td>
					<td>${menu.MENU_NM}</td>
					<td><a class="btn btn-secondary btn-sm" href="/admin/menu/subMenuMng.do?PARENT_MENU_ID=${menu.MENU_ID}">하위메뉴</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>
	
</body>
	<script>
		var selectMenu = function(that) {
			var v_groupId = $(that).text();
			var $tr = $(that).closest('tr');
			//alert(v_groupId + '/' + $tr.children('td:eq(1)').text());
			$('#menuId').val(v_groupId);
			$('#menuNm').val($tr.children('td:eq(1)').text());
		}
	</script>
</html>