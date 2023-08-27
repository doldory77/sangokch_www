<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
  	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
  	
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  	
  	
	
  	<style>
  		/*
  		.ck.ck-editor {
  			widht: 80%;
  			max-width: 800px;
  			margin: 0 auto;
  		}
  		*/
  		#frm {
  			widht: 80%;
  			max-width: 800px;
  			margin: 0 auto;
  		}
  		.ck-editor__editable {
  			height: 80vh;
  		}
  	</style>
  	
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>Hello, world!</title>
  </head>
  <body>
  	
  	<form name="frm" id="frm" action="">
  		<div class="form-group">
  			<label for="title">제목</label>
  			<input type="text" name="subject" class="form-control" placeholder="제목을 입력하세요">
  		</div>
  		<div class="form-group">
  			<label for="content">내용</label>
  			<textarea id="editor" name="content" class="form-control"></textarea>
  		</div>
	  	<div class="d-flex justify-content-center">
	  		<!-- <input type="button" class="btn btn-secondary mt-3 mx-2" value="작성취소" /> -->
	  		<input type="submit" class="btn btn-primary mt-3 mx-2" value="작성완료" />
	  	</div>
  	</form>
	
    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/12.4.0/classic/ckeditor.js"></script>
  	<script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
	<script>
		ClassicEditor
		.create(document.querySelector('#editor'), {
			
			ckfinder: {
				uploadUrl: '/ckeditor5/imageUpload.do'
			}
		})
		.then(editor => {
			console.log('Editor was initialized');
		})
		.catch(error => {
			console.error(error);
		});
	</script>
	
  </body>
</html>
