<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
  	
  	<!-- COMMON CSS -->
  	<link href="/css/cmm.css" rel="stylesheet">
  	
  	<!-- GOOGLE Font -->
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  	
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<div class="container-md">
		<form method="POST" action="/admin/code/saveCodeGroup.do">
			<fieldset>
				<legend>그룹코드 등록</legend>
				<div class="mb-3">
					<label for="groupId" class="form-label">그룹코드</label>
					<input type="text" name="GROUP_ID" class="form-control" id="groupId">
					<div class="form-text">세부코드를 구분하는 그룹코드입니다.(예: )</div>
				</div>
				<div class="mb-3">
					<label for="groupNm" class="form-label">그룹코드명</label>
					<input type="text" name="GROUP_NM" class="form-control" id="groupNm">
				</div>
				<button type="submit" class="btn btn-primary">생성</button>
			</fieldset>
		</form>
		
		<table class="table caption-top mt-4">
			<caption>그룹코드목록</caption>
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">그룸코드ID</th>
					<th scope="col">그룹코드명</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="group" items="${CODE_GROUP}" varStatus="status">
				<tr>
					<th scope="row">${status.count}</th>
					<td>${group.GROUP_ID}</td>
					<td>${group.GROUP_NM}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>
</body>
</html>