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
	<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
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

	<div class="container-fluid pt-5 px-0">
		<div style='padding:40px 10px 10px 10px; margin:auto; <c:if test="${not empty W_SIZE}">max-width:${W_SIZE};</c:if>'>
			<div class="ck-content" id="editor">
				<c:out value="${BODY.CONTENT}" escapeXml="false"></c:out>
			</div>
			<!--<c:if test="${BODY.TAG_CD ne '04'}">
			</c:if>
			<c:if test="${BODY.TAG_CD eq '04'}">
				<div id="editor"></div>
			</c:if>-->
		</div>
	</div>
	

    
  	<!-- <script src="/js/ckeditor.js"></script>
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
	</script> -->
	
	<script>
	    document.querySelectorAll( 'oembed[url]' ).forEach( element => {
	        // Create the <a href="..." class="embedly-card"></a> element that Embedly uses
	        // to discover the media.
	        const anchor = document.createElement( 'a' );
	
	        anchor.setAttribute( 'href', element.getAttribute( 'url' ) );
	        anchor.className = 'embedly-card';
	
	        element.appendChild( anchor );
	    } );
	</script>
	
	
  </body>
</html>
