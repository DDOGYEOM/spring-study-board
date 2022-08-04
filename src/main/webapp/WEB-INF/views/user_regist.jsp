<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="template/header.jsp"></jsp:include>
<body>
	<div class="container">
		<h2 class="mb-4 ms-1">회원가입</h2>
		<div class="mx-auto" style="width: 80%;">
			<form method="post" id="regist-form"
				class="border border-dark border-radius p-4 mb-3"
				style="text-align: center;">
				<span><b>양식 작성</b></span>
				<div class="row my-4 mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">id</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input name="userId" placeholder="id를 입력하세요" />
					</div>
				</div>
				<div class="row my-4 mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">비밀번호</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input class="m-0 border border-0" name="password" type="password"
							placeholder="비밀번호를 입력하세요" />
					</div>
				</div>
				<div class="row my-4 mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">이름</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input class="m-0 border border-0" name="name"
							placeholder="이름을 입력하세요" />
					</div>
				</div>
				<div class="row my-4 mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">나이</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input class="m-0 border border-0" name="age"
							placeholder="나이를 입력하세요" />
					</div>
				</div>
				<div class="row my-4 mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">전화번호</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input class="m-0 border border-0" name="phone"
							placeholder="전화번호를 입력하세요" />
					</div>
				</div>
				<div class="row my-4 mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">주소</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input class="m-0 border border-0" name="address"
							placeholder="주소를 입력하세요" />
					</div>
				</div>
				<div class="row mx-auto border border-dark">
					<div class="col-2 py-2 px-2 border-end">
						<span class="px-2">이메일</span>
					</div>
					<div class="col-9 py-2 ps-4">
						<input class="m-0 border border-0" name="email"
							placeholder="이메일을 입력하세요" />
					</div>
				</div>
	
			</form>
			<div class="float-end me-2">
				<a class="btn btn-outline-danger" onclick="cancel()">취소</a>
				<button id="btn-regist" class="btn btn-outline-success">등록</button>
			</div>
		</div>
	
	</div>
</body>
<script>
	function cancel() {
		alert("회원가입 취소! 이전 화면으로 돌아갑니다.");
		history.back();
	}

	$('#btn-regist').click(
			function() {

				let queryString = $('#regist-form').serialize();
				let apiUrl = "/user/regist";

				$.ajax({
					url : apiUrl,
					type : "POST",
					dataType : "json",
					data : queryString,
					success : function(result) {
						alert("회원가입이 완료되었습니다! 로그인 화면으로 이동합니다!")
						window.location.href = "/user/login";
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