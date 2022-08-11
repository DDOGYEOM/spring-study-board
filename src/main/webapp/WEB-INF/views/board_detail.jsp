<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="template/header.jsp"></jsp:include>
	<body>
		<div class="container">
			<h1 class="pb-3 mx-0">게시판 상세</h1>
			<div class="row mx-1 my-5">
				<div
					class="border-top border-bottom border-dark px-2 py-2 d-flex justify-content-between align-items-center">
					<h3>${boardDetail.title}</h3>
					<span>${boardDetail.postDate}</span>
				</div>
				<div class="border-bottom ps-2 py-2 align-items-center">
					<span>${boardDetail.writer}</span>
				</div>
			</div>
			<div class="row my-2 mx-1">
			
				<div id="content" class="my-3" style="max-height: 500px; overflow-y: scroll">
					${fn:replace(boardDetail.content, newLine, "<br/>")}</div>
			</div>
			<div class="row mt-5 mx-1">
				<div class="d-flex justify-content-between">
					<a class="btn btn-warning" href='javascript: window.history.back();'>뒤로가기</a>
					<div class="d-flex">
						<a id="btn-modify" class="me-1 btn btn-success" href='/board/write?id=${boardDetail.id}'>수정</a> 
						<a id="btn-remove" class="ms-1 btn btn-danger" onclick="boardDelete(${boardDetail.id})" >삭제</a>
					</div>
				</div>
			</div>	
		</div>
	</body>
<jsp:include page="template/footer.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		var loginUser = '<%=session.getAttribute("loginUserInfo")%>';
		var writerId = '${boardDetail.writerId}';
		var loginUserId = '${loginUserId}';
		
		if (loginUser == 'null' || writerId !== loginUserId) {
			$("#btn-modify").addClass('display-none');
			$("#btn-remove").addClass('display-none');
		}
	})
	
	function boardDelete(boardId) {
		console.log(boardId);
		if(confirm("이 글을 삭제하시겠습니까?")) {
			fetch("/board/delete?id="+boardId, {
				 method: "DELETE",
			}).then((res) => {
				location.href="/board";
			})
		}else {
			return;
		}
		
	}
</script>