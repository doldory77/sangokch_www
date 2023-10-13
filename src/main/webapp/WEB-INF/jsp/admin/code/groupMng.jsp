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
		<form action="" method="POST">
			<fieldset>
				<legend>그룹코드 등록</legend>
				<div class="mb-3">
					<label for="" class="form-label">그룹코드</label>
					<input type="text" class="form-control" id="">
					<div class="form-text">세부코드를 구분하는 그룹코드입니다.(예: )</div>
				</div>
				<div class="mb-3">
					<label for="" class="form-label">그룹코드명</label>
					<input type="text" class="form-control" id="">
				</div>
				<button type="submit" class="btn btn-primary">생성</button>
			</fieldset>
		</form>
		
		<div class="row row-cols-2">
			<div class="col">AB000000</div>
			<div class="col">여부코드</div>
		</div>
		
	</div>
</body>
</html>