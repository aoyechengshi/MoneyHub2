<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MoneyHub ログイン</title>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400&display=swap"
	rel="stylesheet">
<!-- 背景 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
<!-- ログイン画面特有CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

</head>
<body>
	<div class="login-card">
	<!-- ロゴをヘッダー内に入れる -->
    <img class="logo" src="${pageContext.request.contextPath}/images/MoneyHub.png" alt="MoneyHub アイコン">
		<h2>MoneyHub Login</h2>

		<div class="error">
			<c:out value="${requestScope.errorMessage}" />
			<c:forEach var="message" items="${requestScope.errorMessageList}">
				<c:out value="${message}" />
				<br>
			</c:forEach>
		</div>

		<form action="/Kakeibo/UserFC" method="post">
			<input type="number" name="userId" value="${param.userId}"
				placeholder="ユーザーID"> <input type="password" name="password"
				value="${param.password}" 　 placeholder="パスワード">
			<button type="submit" name="buttonId" value="e001">Login</button>
			<input type="hidden" name="buttonId" value="e002">
		</form>
	</div>
</body>
</html>

