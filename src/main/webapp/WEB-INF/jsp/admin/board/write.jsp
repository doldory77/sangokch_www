<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String isAdminIfrmPage = request.getHeader("referer").contains("adminIfrmPage.do") ? "Y" : "N";
%>
<c:set var="isAdminIfrmPage" value="<%=isAdminIfrmPage%>"/>

<!doctype html>
<html lang="ko">
<head>
  	<%@ include file="/WEB-INF/jspf/head.jspf" %>
	<title>게시판</title>
	
  	<style>
  		.ck.ck-editor__editable {
  			min-height: 250px; 
  		}
  		.ck.ck-editor__editable > .ck-placeholder::before {
  			color: red;
  			font-family: Georgia;
  		}
  	</style>
  	
</head>
<body>
  	<div>
  	<c:if test="${isAdminIfrmPage ne 'Y'}">
		<div class="admin-header fs-3 d-flex justify-content-between align-content-end p-2">
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/home.do'">산곡교회</span>
		    <span class="py-1 align-self-baseline">${not empty SEQ_NO ? '게시판(상세)' : '게시판(작성)'}</span>
		    <span class="py-1 fs-5 align-self-baseline" onclick="javascript:location.href='/admin/login/logout.do'">LOG-OUT</span>
		</div>
		
		<div class="mb-2 ps-2 py-1">
			<span onclick="javascript:location.href='/admin/main.do'">홈페이지 관리 홈</span>
			<c:if test="${not empty TITLE}">
			<span>&nbsp;&gt;&nbsp;</span>
			<span onclick="javascript:location.href='/admin/adminPage.do?GROUP_ID=${GROUP_ID}&SCREEN_YN=${SCREEN_YN}&PAGE=${PAGE}'">${TITLE eq 'HOME' ? '메인화면 관리' : TITLE}</span>	
			</c:if>
		</div>
	</c:if>
	</div>
	<div class="container-fluid">
  		
		<form name="frm" method="POST" id="frm" action="/admin/board/save.do">
			<fieldset>
				<legend></legend>
			
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1">
			  			<label for="title">제목</label>
			  		</div>
			  		<div class="col">
			  			<input type="text" id="title" name="SUBJECT" class="form-control" placeholder="제목을 입력하세요" value="${not empty BOARD_DTL ? BOARD_DTL.SUBJECT : ''}">
			  		</div>
			  	</div>
		  	
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">그룹ID</label>
			  		</div>
			  		<div class="col-md-2 mb-2">
			  			<select class="form-select" id="groupId" name="GROUP_ID">
			  				<c:forEach var="item" items="${groupIdList}">
			  				<option value="${item.MENU_ID}" 
			  					<c:if test="${not empty BOARD_DTL && item.MENU_ID eq BOARD_DTL.GROUP_ID}">selected="selected"</c:if>
			  					<c:if test="${not empty GROUP_ID && item.MENU_ID eq GROUP_ID}">selected="selected"</c:if>
			  				>${item.MENU_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">화면표시</label>
			  		</div>
				  	<div class="col-md-2 mb-2">
			  			<select class="form-select" id="screenYn" name="SCREEN_YN">
			  				<c:forEach var="item" items="${YNCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.SCREEN_YN}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
				  	</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">순번</label>
			  		</div>
			  		<div class="col-md-2 mb-2">
			  			<input type="text" id="ordNo" name="ORD_NO" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ORD_NO : ''}">
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">사용여부</label>
			  		</div>
			  		<div class="col-md-2 mb-2">
			  			<select class="form-select" id="useYn" name="USE_YN">
			  				<c:forEach var="item" items="${YNCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.USE_YN}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  	</div>
			  	
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="title">TAG</label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<select class="form-select" id="useYn" name="TAG_CD">
			  				<c:forEach var="item" items="${TagCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.TAG_CD}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr02">속성2</label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="attr02" name="ATTR02" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR02 : ''}">
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr03">속성3</label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="attr03" name="ATTR03" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR03 : ''}">
			  		</div>
			  		
			  	</div>
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr04">속성4</label>
			  		</div>
			  		<div class="col-md-5 mb-2">
			  			<input type="text" id="attr04" name="ATTR04" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR04 : ''}">
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr05">속성5</label>
			  		</div>
			  		<div class="col-md-5 mb-2">
			  			<input type="text" id="attr05" name="ATTR05" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR05 : ''}">
			  		</div>
			  	</div>

		  		<div class="d-flex justify-content-between align-items-center mb-2">
	  				<span>내용</span>
	  				<span style="font-size:0.6rem;">
		  				<span>그룹ID : [${not empty BOARD_DTL ? BOARD_DTL.GROUP_ID : ''}]</span>
		  				<span>/ 일련번호 : [${not empty BOARD_DTL ? BOARD_DTL.SEQ_NO : ''}]</span>
	  				</span>
		  		</div>
		  		
		  		<textarea id="editor" name="CONTENT" class="form-control"></textarea>
		  	
			  	<div class="row align-items-center">
				  	<div class="col text-center">
				  		<input type="submit" class="btn btn-primary mt-3 mx-2" value="작성완료" />
				  	</div>
			  	</div>
		  	
			  	<input type="hidden" name="CURR_PAGE" value="${not empty CURR_PAGE ? CURR_PAGE : ''}">
			  	<input type="hidden" name="DEL_YN" value="N">
			  	<input type="hidden" name="SEQ_NO" value="${not empty BOARD_DTL ? BOARD_DTL.SEQ_NO : '0'}">
			  	<input type="hidden" name="DEPTH_NO" value="${not empty BOARD_DTL ? BOARD_DTL.DEPTH_NO : '0.0'}">
			  	<input type="hidden" name="PAGE" value="${not empty PAGE ? PAGE : ''}">
			  	<input type="hidden" name="IS_ADMIN_IFRM_PAGE" value="${isAdminIfrmPage}">
		  		
		  	</fieldset>
	  	</form>
	  	
	  </div>
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  	<!-- <script src="https://cdn.ckeditor.com/ckeditor5/41.1.0/decoupled-document/ckeditor.js"></script> -->
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
		    	
		    	<c:if test="${not empty BOARD_DTL}">editor.setData('${BOARD_DTL.CONTENT}')</c:if>
		    } )
		    .catch( error => {
		        console.error( error );
		    } );	
		
	</script>
	
</body>
</html>
