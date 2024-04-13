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
  		.require {color:red; font-weight:bold;}
  		.sub1 {font-size: 0.7rem;}
  	</style>
  	
</head>
<body>
  	<div>
  	<c:if test="${isAdminIfrmPage ne 'Y'}">
		<div class="admin-header fs-3 d-flex justify-content-between align-items-center p-2">
		    <span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/home.do'">home</span>
		    <span class="py-1 align-self-baseline">${not empty SEQ_NO ? '게시판(상세)' : '게시판(작성)'}</span>
		    <span class="material-symbols-outlined hbtn" onclick="javascript:location.href='/admin/login/logout.do'">logout</span>
		</div>
		
		<div class="mb-2 ps-2 py-1">
			<img src="${applicationScope.ENV['CD0002_05']['VALUE_STR']}" width="22">
			<span class="pth" onclick="javascript:location.href='/admin/main.do'">홈페이지 관리 홈</span>
			<c:if test="${not empty TITLE}">
			<span>&nbsp;&gt;&nbsp;</span>
			<span class="pth" onclick="javascript:location.href='/admin/adminPage.do?GROUP_ID=${GROUP_ID}&SCREEN_YN=${SCREEN_YN}&PAGE=${PAGE}'">${TITLE eq 'HOME' ? '메인화면 관리' : TITLE}</span>	
			</c:if>
		</div>
	</c:if>
	</div>
	<div class="container-fluid">
  		
		<form name="frm" method="POST" id="frm" action="/admin/board/save.do" onsubmit="return false;">
			<fieldset>
				<legend></legend>
			
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">그룹ID<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(분류)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<select class="form-select" id="groupId" name="GROUP_ID">
			  				<c:forEach var="item" items="${groupIdList}">
			  				<option value="${item.MENU_ID}" 
			  					<c:if test="${not empty BOARD_DTL && item.MENU_ID eq BOARD_DTL.GROUP_ID}">selected="selected"</c:if>
			  					<c:if test="${not empty GROUP_ID && item.MENU_ID eq GROUP_ID}">selected="selected"</c:if>
			  				><c:choose><c:when test="${item.MENU_LEVEL eq '2'}">&nbsp;&nbsp;</c:when><c:otherwise></c:otherwise></c:choose>${item.MENU_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  		
			  		<div class="col-md-1  mb-md-2">
			  			<label for="title"><span class="require sub1">*&nbsp;</span>제목</label>
			  		</div>
			  		<div class="col mb-2">
			  			<input type="text" id="title" name="SUBJECT" class="form-control" placeholder="제목을 입력하세요" value="${not empty BOARD_DTL ? BOARD_DTL.SUBJECT : ''}">
			  		</div>
			  	</div>
		  	
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">화면표시<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(꾸밈요소)</small></label>
			  		</div>
				  	<div class="col-md-3 mb-2">
			  			<select class="form-select" id="screenYn" name="SCREEN_YN">
			  				<c:forEach var="item" items="${YNCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.SCREEN_YN}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
				  	</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">순번<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(정렬순서)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="ordNo" name="ORD_NO" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ORD_NO : ''}">
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="groupId">사용여부<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(조회여부)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<select class="form-select" id="useYn" name="USE_YN">
			  				<c:forEach var="item" items="${YNCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.USE_YN}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  	</div>
			  	
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="title">TAG<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(요소성격)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<select class="form-select" id="useYn" name="TAG_CD">
			  				<c:forEach var="item" items="${TagCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.TAG_CD}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="mainDispYn">메인노출<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(HOME 노출여부)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<select class="form-select" id="mainDispYn" name="MAIN_DISP_YN">
			  				<c:forEach var="item" items="${YNCodeList}">
			  				<option value="${item.CODE}" <c:if test="${not empty BOARD_DTL && item.CODE eq BOARD_DTL.MAIN_DISP_YN}">selected="selected"</c:if>>${item.CODE_NM}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr01">속성1<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(썸네일|이미지)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="attr01" name="ATTR01" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR01 : ''}">
			  		</div>
			  	</div>
			  	
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr02">속성2<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(조금긴문장)</small></label>
			  		</div>
			  		<div class="col mb-2">
			  			
			  			<textarea name="ATTR02" id="attr02" style="width:100%">${not empty BOARD_DTL ? BOARD_DTL.ATTR02 : ''}</textarea>
			  		</div>
			  	</div>
			  	
			  	<div class="row align-items-center mb-2">
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr03">속성3<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(날짜)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="attr03" name="ATTR03" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR03 : ''}">
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr04">속성4<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(youtube 링크)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="attr04" name="ATTR04" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR04 : ''}">
			  		</div>
			  		<div class="col-md-1 mb-md-2">
			  			<label for="attr05">속성5<small class="require sub1 d-md-none d-xl-inline"><br class="d-none d-xl-inline"/>(게시판 링크)</small></label>
			  		</div>
			  		<div class="col-md-3 mb-2">
			  			<input type="text" id="attr05" name="ATTR05" class="form-control" value="${not empty BOARD_DTL ? BOARD_DTL.ATTR05 : ''}">
			  		</div>
			  	</div>

		  		<div class="d-flex justify-content-between align-items-center mb-2">
	  				<span>내용</span>
	  				<div>
		  				<span style="font-size:0.6rem;">
			  				<span>그룹ID : [${not empty BOARD_DTL ? BOARD_DTL.GROUP_ID : ''}]</span>
			  				<span>/ 일련번호 : [${not empty BOARD_DTL ? BOARD_DTL.SEQ_NO : ''}]</span>
		  				</span>
		  				<button class="btn btn-primary mx-2" onclick="goSubmit()">작성완료</button>
	  				</div>
		  		</div>
		  		
		  		<textarea id="editor" name="CONTENT" class="form-control"></textarea>
		  	
			  	<!-- <div class="row align-items-center">
				  	<div class="col text-center">
				  		<button class="btn btn-primary mt-3 mx-2" onclick="goSubmit()">작성완료</button>
				  	</div>
			  	</div> -->
		  	
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
		function goSubmit() {
			var frm = document.frm;
			if (!frm.SUBJECT.value) {
				alert('제목은 필수 입력값 입니다.');
				return;
			} else {
				frm.submit();
			}
		}
		
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
