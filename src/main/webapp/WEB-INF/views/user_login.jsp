<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="template/header.jsp"></jsp:include>
<body>
	<div class="container">
		<div class="mx-auto" style="width: 80%;">
			<h2 class="mb-3 ms-1">로그인</h2>
			<form method="post" id="login-form"
				class="border border-dark rounded p-4 mb-3"
				style="text-align: center;">
				<span><b>id, 비밀번호를 입력해주세요</b></span>
				<div class="row my-4 mx-auto border border-success rounded">
					<div class="col-2 py-2 px-2 border-end border-success">
						<span class="px-2">id</span>
					</div>
					<div class="col-10 py-1">
						<input class="m-0 border border-0" style="height: 100%;"
							name="userId" placeholder="id를 입력하세요" />
					</div>
				</div>
				<div class="row my-4 mx-auto border border-success rounded">
					<div class="col-2 py-2 px-2 border-end border-success">
						<span class="px-2">비밀번호</span>
					</div>
					<div class="col-10 py-1">
						<input class="m-0 border border-0" style="height: 100%;"
							name="password" type="password" placeholder="비밀번호를 입력하세요" />
					</div>
				</div>
				<button id="btn_login" class="btn btn-outline-success" type="button">로그인</button>
			</form>
		</div>
	</div>
</body>
<jsp:include page="template/footer.jsp"></jsp:include>
<script>
	$('#btn_login').click(
			function() {

				let queryString = $('#login-form').serialize();
				let apiUrl = "/user/login";

				$.ajax({
					url : apiUrl,
					type : "POST",
					dataType : "json",
					data : queryString,
					success : function(result) {

						if (result.loginUserInfo) {
							alert("로그인에 성공하였습니다!")
							window.location.href = "/board";
						} else {
							alert("로그인에 실패하였습니다! 다시 시도해주십시오.")
							window.location.href = "/user/login";
						}

						console.log("성공!");
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);

					}
				})

			})
</script>
</html>