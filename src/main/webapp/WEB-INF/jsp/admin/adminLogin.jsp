<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>코드관리</title>
	<style>
		.login-wrap { positon:relative; }
		.login-wrap .login-form {
			position:absolute;
			top:50%;
			left:50%;
			transform:translate(-50%, -50%);
			width: 320px;
			padding: 20px;
			background-color: #ebebeb;
			border-radius: 5px;
			box-shadow: 1px 1px;
		}
	</style>
</head>
<body>
	<div class="container-md">
		<div class="login-wrap">
			<div class="login-form">
			<form method="POST" action="/admin/login/loginCheck.do">
				<fieldset>
					<legend>로그인</legend>
					<div class="mb-3">
						<label for="userId" class="form-label">사용자 ID</label>
						<input type="text" class="form-control" name="USER_ID" id="userId">
					</div>
					<div class="mb-3">
						<label for="userPW" class="form-label">사용자 PW</label>
						<input type="password" name="USER_PW" class="form-control" id="userPW">
					</div>
					<div class="text-center"><button type="submit" class="btn btn-primary">확인</button></div>
				</fieldset>
			</form>
			</div>
		</div>
	</div>
</body>
	<script>
		var selectCode = function(that) {
			var v_code = $(that).text();
			var $tr = $(that).closest('tr');
			//alert(v_groupId + '/' + $tr.children('td:eq(1)').text());
			$('#code').val(v_code);
			$('#codeNm').val($tr.children('td:eq(3)').text());
			$('#useYn').val($tr.children('td:eq(4)').text()).prop('selected', true);
		}
	</script>
</html>