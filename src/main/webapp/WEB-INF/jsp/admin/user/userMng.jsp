<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>사용자관리</title>
	
</head>
<body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-content-end p-2">
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/home.do'">산곡교회</span>
		    <span class="py-1 align-self-baseline">사용자관리</span>
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/admin/login/logout.do'">LOG-OUT</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<span onclick="javascript:location.href='/admin/main.do'">홈페이지 관리 홈</span>
			<span>&nbsp;&gt;&nbsp;</span>
			<span>사용자관리</span>
		</div>
	</div>
	<div class="container-md">
		<form method="POST" action="/admin/user/saveUser.do">
			<fieldset>
				<legend></legend>
				<div class="mb-3">
					<label for="userId" class="form-label">사용자 ID</label>
					<input type="text" name="ID" class="form-control" id="userId">
					<div class="form-text">사용자ID</div>
				</div>
				<div class="mb-3">
					<label for="userPw" class="form-label">사용자 패스워드</label>
					<input type="password" name="PW" class="form-control" id="userPw">
				</div>
				<div class="mb-3">
					<label for="admYn" class="form-label">관리자여부</label>
					<select id="admYn" name="ADM_YN" class="form-control">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
				<div class="mb-3">
					<label for="useYn" class="form-label">사용여부</label>
					<select id="useYn" name="USE_YN" class="form-control">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
				<div class="mb-3">
					<label for="attr01" class="form-label">기타속성</label>
					<input type="text" name="ATTR01" class="form-control" id="attr01">
					<div class="form-text">기타</div>
				</div>
				<div class="text-end"><button type="submit" class="btn btn-primary">생성(수정)</button></div>
			</fieldset>
		</form>
		
		<table class="table caption-top mt-4">
			<caption>사용자목록</caption>
			<thead>
				<tr style="background-color:#F3F0CA">
					<th scope="col">#</th>
					<th scope="col">사용자ID</th>
					<th scope="col">관리자여부</th>
					<th scope="col">사용여부</th>
					<th scope="col">기타속성</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${USER_LIST}" varStatus="status">
				<tr>
					<th scope="row">${status.count}</th>
					<td><a href="javascript:false;" onclick="selectUser(this);">${user.ID}</a></td>
					<td>${user.ADM_YN}</td>
					<td>${user.USE_YN}</td>
					<td>${user.ATTR01}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>
	
</body>
	<script>
		var selectUser = function(that) {
			var v_userId = $(that).text();
			var $tr = $(that).closest('tr');
			//alert(v_groupId + '/' + $tr.children('td:eq(1)').text());
			$('#userId').val(v_userId);
			$('#admYn').val($tr.children('td:eq(1)').text()).prop('selected', true);
			$('#useYn').val($tr.children('td:eq(2)').text()).prop('selected', true);
			$('#attr01').val($tr.children('td:eq(3)').text());
			
		}
	</script>
</html>