<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script type="text/javascript">
		$(document).ready(function() {
			 var loginUser = '<%=session.getAttribute("loginUserInfo")%>';
			if (loginUser !== 'null') {
				$(".not-sign-in").addClass('display-none');
			} else {
				$(".sign-in").addClass('display-none');
			}
		})
		
		function logout() {
			if(window.confirm("정말로 로그아웃 하시겠습니까?")) {
				window.location.href="/user/logout"	
			}
			 
		}
	</script>
</html>