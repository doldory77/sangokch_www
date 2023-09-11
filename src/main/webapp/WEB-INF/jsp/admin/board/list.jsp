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
  	
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	
  	<style>
  		/*스타일 작성*/
		.board-frame {
			width:260px;
			border:1px dotted #c2c2c2;
			margin:2px;
		}
		.board-frame .title {
			font-size: 1.4rem;
			font-weight: bold;
		}
		.board-frame .sub1 {
			font-size: 0.8rem;
		}
		.paging-btn {
			border:1px dotted #c2c2c2;
			width:48px;
			height:48px;
		}
  	</style>
  	
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>게시판 목록</title>
  </head>
  <body>
	<div class="container-fluid">
		<div class="d-flex flex-wrap justify-content-start">
		<c:forEach var="item" items="${BOARD_LIST}">  
			<div class="board-frame p-1">
				<div><span class="sub1">${item.GROUP_NM}</span></div>
				<div><span class="title ps-2">${item.SUBJECT}</span></div>
				<div class="text-end"><span class="sub1">${item.REG_DT}</span></div>
			</div>
		</c:forEach>
		</div>
		<div class="d-flex">
			<c:if test="${1 le PAGE_CTL.CURR_PAGE-1}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/board/list.do?CURR_PAGE=${PAGE_CTL.CURR_PAGE-1}&GROUP_ID=">-</a>
			</c:if>
			<c:forEach var="i" begin="${PAGE_CTL.BLOCK_START}" end="${PAGE_CTL.BLOCK_END}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/board/list.do?CURR_PAGE=${i}&GROUP_ID=">${i}</a>
			</c:forEach>
			<c:if test="${PAGE_CTL.TOTAL_PAGE ge PAGE_CTL.CURR_PAGE+1}">
			<a class="d-flex m-1 paging-btn justify-content-center align-items-center" href="/admin/board/list.do?CURR_PAGE=${PAGE_CTL.CURR_PAGE+1}&GROUP_ID=">+</a>
			</c:if>
		</div>
	</div>
	
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    
	<script>
		/*스크립트 작성*/
	</script>
	
  </body>
</html>
