<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - Admin</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style>
body {
	background-color: #5fb6df;
	font-size: 14px;
	color: #fff;
}

.simple-login-container {
	width: 300px;
	max-width: 100%;
	margin: 50px auto;
}

.simple-login-container h2 {
	text-align: center;
	font-size: 20px;
}

.simple-login-container .btn-login {
	background-color: #FF5964;
	color: #fff;
}
</style>
</head>
<body>
	<c:url value="/login" var="loginUrl" />
	<form:form name="loginFrm" action="${loginUrl }" method="post" 
		onsubmit="return LoginCheck();">
		<input type="hidden" name="admin" value="admin" />
		<div class="simple-login-container" style="margin-top: 200px;">

			<div style="margin-bottom: 50px;">
				<h2 style="text-align: center; font-size: 30px;">Parkmoa Admin</h2>
			</div>

			<div class="row">
				<div class="col-md-12 form-group">
					<input type="text" class="form-control" name="m_id" required="required"
						placeholder="ID" value="">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<input type="password" placeholder="Password" name="m_pw" required="required"
						class="form-control" value="">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<input type="submit" class="btn btn-block btn-login" value="로그인">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h2>
						<i class='far fa-angry' style='font-size: 48px; color: red'>경고
						
					</h2>
					</i>
					<p>관리자가 아닌 경우 다른 사용자 일 경우 법적책임을 물을 수 있습니다.</p>
				</div>
			</div>
		</div>
	</form:form>
</body>
</html>