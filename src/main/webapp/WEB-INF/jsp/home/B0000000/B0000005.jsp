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
  
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-PD22H4MR"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->  
  
	<div class="wrapper">
  		<%@ include file="/WEB-INF/jspf/menu.jspf" %>
	</div>
	
	<c:if test="${not empty HEADER_IMG}">
	<div class="container-fluid pt-5 px-0">
		<div class="mainHead mainHead-b mainHead-small mainHead-large" style='position:relative; background-image:url(${HEADER_IMG.ATTR01}); <c:if test="${not empty HEADER_IMG.ATTR04}">background-position-y:${HEADER_IMG.ATTR04}%;</c:if>'>
		    <div class="mainHead-title word fs-1">
		        ${HEADER_IMG.ATTR02}
		    </div>
		</div>
	</div>
	</c:if>
	
	<!-- <div class="pageBodyW container-fluid">
		<div class="readyDiv">
			<img class="readyImg" src="http://beautifulseodang.1937.co.kr/images/ready.jpg">
		</div>
	</div> -->
	
	<div class="container-fluid px-0">
		<div style="padding:10px 10px 10px 10px;">
			<div class="ck-content" id="editor"><c:out value="${BODY.CONTENT}" escapeXml="false"></c:out></div>
		</div>
	</div>

    
  	<!-- <script src="/js/ckeditor.js"></script>
  	<script src="/js/imgUpAdapter.js"></script> -->
	<script>
		
		/*ClassicEditor
		    .create( document.querySelector( '#editor' ), {
		    	
		    } )
		    .then( editor => {
		    	console.log('Editor was initialized');
		    	editor.ui.view.toolbar.element.style.display = 'none';
		    	window.editor = editor;
		    	
		    	<c:if test="${not empty BODY}">
		    		editor.setData(<c:out value="`${BODY.CONTENT}`" escapeXml="false"></c:out>);
		    	</c:if>
		    	editor.enableReadOnlyMode('xxx');
		    } )
		    .catch( error => {
		        console.error( error );
		    } );*/
	</script>
  </body>
</html>
