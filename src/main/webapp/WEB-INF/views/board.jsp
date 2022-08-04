<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="template/header.jsp"></jsp:include>
<div class="container">
	<h1 class="mb-2 ms-1">게시판 목록</h1>
	<a href="/board/write" id="btn-write"
		class="btn btn-primary float-end mb-3 me-1">작성</a>
	<table class="table table-hover text-center table-bordered">
		<thead class="table-success">
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody class="table-light">
			<c:choose>
				<c:when test="${fn: length(boardList) != 0}">
					<c:forEach var="item" items="${boardList}" varStatus="status">
						<tr onclick="goToDetail(${item.id})">
							<td style="width:10%;">${item.id}</td>
							<td style="width:75%;">${item.title}</td>
							<td style="width:15%;">${item.writer}</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</tbody>
	</table>

	<div class="mt-3 mb-4 d-flex justify-content-center">
		<ul class="pagination">
			<li id="prev-page" class="page-item"><a class="page-link"
				href="/board?page=${pagination.curPage - 1}">&lt;</a></li>
			<c:forEach var="i" begin="${pagination.startPage}"
				end="${pagination.endPage}" step="1">
				<li class="page-item"><a class="page-link"
					href="/board?page=${i}">${i}</a></li>
			</c:forEach>
			<li id="next-page" class="page-item"><a class="page-link"
				href="/board?page=${pagination.curPage + 1}">&gt;</a></li>
		</ul>
	</div>
</div>
</body>
<jsp:include page="template/footer.jsp"></jsp:include>
<script>
		$(document).ready(function() {
			 let urlParams = new URL(window.location.href).searchParams;
			 var curPage = urlParams.get('page') 
			 if(curPage === null) {
				curPage = '1';
			 }
			 
			 $(".page-link").each(function(idx, item) {		
				 if(curPage == $(this).text()) {
					 $(this).addClass('active');
				 }
			 });
			 
			 if(curPage == ${pagination.startPage}) {
				 $("#prev-page").addClass('disabled');	 
			 }else if(curPage == ${pagination.endPage}) {
				 $("#next-page").addClass('disabled'); 
			 }
			 
			 
			 
			 var loginUser = '<%=session.getAttribute("loginUserInfo")%>';
			 if(loginUser === 'null') {
				 $("#btn-write").addClass('display-none');
			 }
		})
		function goToDetail(id) {
			window.location.href = '/board/detail?id=' + id;
		}
	</script>
</html>