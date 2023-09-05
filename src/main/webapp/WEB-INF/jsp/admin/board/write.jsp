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
  		#frm {
  			widht: 80%;
  			max-width: 800px;
  			margin: 0 auto;
  		}
  	</style>
  	
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>게시판작성</title>
  </head>
  <body>
  	
  	<form name="frm" id="frm" action="">
  		<div class="form-group mb-2">
  			<label for="title">제목</label>
  			<input type="text" id="title" name="SUBJECT" class="form-control" placeholder="제목을 입력하세요">
  		</div>
  		<div class="form-group mb-2">
  			<label for="groupId">그룹ID</label>
  			<select id="groupId" name="GROUP_ID">
  				<c:forEach var="item" items="${groupIdList}">
  				<option value="${item.MENU_ID}">${item.MENU_NM}</option>
  				</c:forEach>
  			</select>
  		</div>
  		<div class="form-group mb-2">
  			<label for="groupId">화면표시여부</label>
  			<select id="screenYn" name="SCREEN_YN">
  				<c:forEach var="item" items="${YNCodeList}">
  				<option value="${item.CODE}">${item.CODE_NM}</option>
  				</c:forEach>
  			</select>
  		</div>
  		<div class="form-group mb-2">
  			<label for="groupId">사용여부</label>
  			<select id="useYn" name="USE_YN">
  				<c:forEach var="item" items="${YNCodeList}">
  				<option value="${item.CODE}">${item.CODE_NM}</option>
  				</c:forEach>
  			</select>
  		</div>
  		<div class="form-group mb-2">
  			<label for="editor">내용</label>
  			<textarea id="editor" name="CONTENT" class="form-control"></textarea>
  		</div>
	  	<div class="d-flex justify-content-center">
	  		<input type="submit" class="btn btn-primary mt-3 mx-2" value="작성완료" />
	  	</div>
  	</form>
	
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  	<script src="/js/ckeditor.js"></script>
  	<script src="/js/imgUpAdapter.js"></script>
	<script>
		function MyCustomUploadAdapterPlugin( editor ) {
		    editor.plugins.get( 'FileRepository' ).createUploadAdapter = ( loader ) => {
		        // Configure the URL to the upload script in your back-end here!
		        return new MyUploadAdapter( loader );
		    };
		}
		
		ClassicEditor
		    .create( document.querySelector( '#editor' ), {
		    	htmlSupport: {
		    		allow: [
		    			{
		    				name:/.*/,
		    				attributes: true,
		    				classes: true,
		    				styles: true
		    			}
		    		],
		    		disallow: []
		    	},
		    	extraPlugins: [ MyCustomUploadAdapterPlugin ],
		    	
		    } )
		    .then( editor => {
		    	console.log('Editor was initialized');
		    	window.editor = editor;
		    } )
		    .catch( error => {
		        console.error( error );
		    } );
	</script>
	
  </body>
</html>
