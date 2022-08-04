<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="template/header.jsp"></jsp:include>
<div class="container">
	<c:choose>
		<c:when test="${not empty boardDetail }">
			<h1 class="mb-2 pb-2">게시글 수정</h1>
			<form id="update-form">
				<table class="table mt-5 text-center align-middle">
					<tbody>
						<tr>
							<th>제목</th>
							<th><input type="text" name="title"
								value="${boardDetail.title}" /></th>

						</tr>
						<tr>
							<th>상세</th>
							<th><textarea name="content">${boardDetail.content}</textarea></th>

						</tr>
					</tbody>
				</table>
			</form>
		</c:when>
		<c:otherwise>
			<h1 class="mb-2 pb-2 px-3">게시글 작성</h1>
			<form id="add-form" class="d-flex justify-content-center">
				<table class="table my-5 align-middle" style="width: 90%;">
					<tbody>
						<tr class="border-1">
							<th class="ps-5">제목</th>
							<th><input type="text" name="title" /></th>

						</tr>
						<tr>
							<th class="ps-5">상세</th>
							<th><textarea name="content"></textarea></th>

						</tr>
					</tbody>
				</table>
			</form>
		</c:otherwise>
	</c:choose>

	<div class="mode mt-4 px-2 mx-auto" style="width: 90%;">
		<a class="btn btn-warning float-start"
			href='javascript: window.history.back();'>뒤로가기</a>
		<button class="btn btn-primary float-end" id="btn-save">저장</button>
	</div>
</div>
</body>
<style>
input, textarea {
	width: 90%;
	margin: 10px 5px;
}

textarea {
	min-height: 80px;
}

tr>th:first-child {
	width: 10%;
}

tr>th:last-child {
	width: 85%;
}

tr>th:last-child>* {
	float: right;
}
</style>
<script>
		let isUpdate = false;
		let urlParam = new URLSearchParams(location.search).get("id");
		
		$(document).ready(function() {
			if (urlParam) {
				isUpdate = true;
			}
			
			if(isUpdate) {
				var writerId = '${boardDetail.writerId}';
				var loginUserId = '${loginUserId}';
				console.log(loginUserId);
				
				if(loginUserId !== writerId || loginUserId === 'null') {
					alert("작성자만 수정 가능합니다.");
					history.back();
				}
			}
		})

	$('#btn-save').click(
			function() {
				let queryString = "";
				let apiUrl = "";

				// serialize는 form의 <input> 요소들의 name이 배열형태로 그 값이 인코딩되어 URL query string으로 하는 메서드
				if (isUpdate) {
					queryString = $('#update-form').serialize() + "&boardId="
							+ urlParam;
					apiUrl = "/board/update";
				} else {
					queryString = $('#add-form').serialize();
					console.log($('#add-form'));
					apiUrl = "/board/write";
				}

				$.ajax({
					url : apiUrl,
					type : "POST",
					dataType : "json",
					data : queryString,
					success : function(result) {
						console.log(result);
						console.log("성공!");

						window.location.href = "/board";
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);

					}
				})

			})
</script>
<jsp:include page="template/footer.jsp"></jsp:include>


