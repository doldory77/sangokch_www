<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="ko">
  <head>
	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<link rel="stylesheet" href="/css/font.css">
	<link rel="stylesheet" href="/css/ckcontent.css">
    <title>${TITLE}</title>
    <style>
		.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) {  
	        border:0px !important;  
	    }
    </style>
  </head>
  <body>
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>

	<div class="container-fluid pt-5 px-0">
		<div style='padding:40px 10px 10px 10px; margin:auto; <c:if test="${not empty W_SIZE}">max-width:${W_SIZE};</c:if>'>
			<c:if test="${BODY.TAG_CD ne '04'}">
			<div class="ck-content" id="editor">
				<c:out value="${BODY.CONTENT}" escapeXml="false"></c:out>
			</div>
			</c:if>
			<c:if test="${BODY.TAG_CD eq '04'}">
				<div id="editor"></div>
			</c:if>
		</div>
	</div>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
    
  	<script src="/js/ckeditor.js"></script>
  	<script src="/js/imgUpAdapter.js"></script>
	<script>
		<c:if test="${BODY.TAG_CD eq '04'}">
		ClassicEditor
		    .create( document.querySelector( '#editor' ), {
		    	
		    } )
		    .then( editor => {
		    	console.log('Editor was initialized');
		    	editor.ui.view.toolbar.element.style.display = 'none';
		    	window.editor = editor;
		    	<c:if test="${not empty BODY}">
		    		editor.setData(`<c:out value="${BODY.CONTENT}" escapeXml="false"></c:out>`);
		    	</c:if>
		    	editor.enableReadOnlyMode('xxx');
		    } )
		    .catch( error => {
		        console.error( error );
		    } );
		</c:if>    
	</script>
  </body>
</html>
