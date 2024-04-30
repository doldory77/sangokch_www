<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>코드그룹관리</title>
	
</head>
<body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-items-center p-2">
		    <span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/home.do'">home</span>	
		    <span class="py-1 align-self-baseline">코드관리</span>
	    	<span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/admin/login/logout.do'">logout</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<img src="${applicationScope.ENV['CD0002_05']['VALUE_STR']}" width="22">
			<span class="pth" onclick="javascript:location.href='/admin/main.do'">홈페이지 관리</span>
			<span class="pth">&nbsp;&gt;&nbsp;</span>
			<span class="pth">그룹코드관리</span>
		</div>
	</div>  
	<div class="container-md">
		<form method="POST" action="/admin/code/saveCodeGroup.do">
			<fieldset>
				<div class="mb-3">
					<label for="groupId" class="form-label">그룹코드</label>
					<input type="text" name="GROUP_ID" class="form-control" id="groupId">
					<div class="form-text">세부코드를 구분하는 그룹코드입니다.(예: )</div>
				</div>
				<div class="mb-3">
					<label for="groupNm" class="form-label">그룹코드명</label>
					<input type="text" name="GROUP_NM" class="form-control" id="groupNm">
				</div>
				<div class="text-end"><button type="submit" class="btn btn-primary">생성(수정)</button></div>
			</fieldset>
		</form>
		
		<table class="table caption-top mt-4">
			<caption>그룹코드목록</caption>
			<thead>
				<tr style="background-color:#F3F0CA">
					<th scope="col">#</th>
					<th scope="col">그룸코드ID</th>
					<th scope="col">그룹코드명</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="group" items="${CODE_GROUP}" varStatus="status">
				<tr>
					<th scope="row">${status.count}</th>
					<td><a href="javascript:false;" onclick="selectGroup(this);">${group.GROUP_ID}</a></td>
					<td>${group.GROUP_NM}</td>
					<td><a class="btn btn-secondary btn-sm" href="/admin/code/codeMng.do?GROUP_ID=${group.GROUP_ID}">상세</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>
	
</body>
	<script>
		var selectGroup = function(that) {
			var v_groupId = $(that).text();
			var $tr = $(that).closest('tr');
			//alert(v_groupId + '/' + $tr.children('td:eq(1)').text());
			$('#groupId').val(v_groupId);
			$('#groupNm').val($tr.children('td:eq(1)').text());
		}
	</script>
</html>