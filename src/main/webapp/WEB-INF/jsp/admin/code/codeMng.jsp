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
</head>
<body>
  	<div>
		<div class="admin-header fs-3 d-flex justify-content-between align-content-end p-2">
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/home.do'">산곡교회</span>
		    <span class="py-1 align-self-baseline">코드관리</span>
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/admin/login/logout.do'">LOG-OUT</span>
		</div>
		<div class="mb-2 ps-2 py-1">
			<span onclick="javascript:location.href='/admin/main.do'">홈페이지 관리 홈</span>
			<span>&nbsp;&gt;&nbsp;</span>
			<span onclick="javascript:location.href='/admin/code/groupMng.do'">그룹코드관리</span>
			<span>&nbsp;&gt;&nbsp;</span>
			<span>세부코드관리</span>
		</div>
	</div>
	<div class="container-fluid">
		<form method="POST" action="/admin/code/saveCode.do">
			<fieldset>
				<legend></legend>
				<div class="mb-3">
					<label for="groupId" class="form-label">그룹코드</label>
					<div>
						<input style="display:inline-block; width:auto" type="text" name="GROUP_ID" readonly class="form-control-plaintext" id="groupId" value="${GROUP_ID}">
					</div>
					<div class="form-text">세부코드를 구분하는 그룹코드입니다.(예: )</div>
				</div>
				<div class="mb-3">
					<label for="code" class="form-label">코드</label>
					<input type="text" name="CODE" class="form-control" id="code">
					<div class="form-text">세부코드</div>
				</div>
				<div class="mb-3">
					<label for="codeNm" class="form-label">코드명</label>
					<input type="text" name="CODE_NM" class="form-control" id="codeNm">
				</div>
				<div class="mb-3">
					<label for="useYn" class="form-label">사용여부</label>
					<select class="form-select" name="USE_YN" id="useYn">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
				<div class="text-end"><button type="submit" class="btn btn-primary">생성(수정)</button></div>
			</fieldset>
		</form>
		
		<table class="table caption-top mt-4">
			<caption>세부코드목록</caption>
			<thead>
				<tr style="background-color:#F3F0CA">
					<th scope="col">#</th>
					<th scope="col">그룸코드ID</th>
					<th scope="col">그룹코드명</th>
					<th scope="col">세부코드</th>
					<th scope="col">세부코드명</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="code" items="${CODE}" varStatus="status">
				<tr>
					<th scope="row">${status.count}</th>
					<td>${code.GROUP_ID}</td>
					<td>${code.GROUP_NM}</td>
					<td><a href="javascript:false;" onclick="selectCode(this);">${code.CODE}</a></td>
					<td>${code.CODE_NM}</td>
					<td>${code.USE_YN}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
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