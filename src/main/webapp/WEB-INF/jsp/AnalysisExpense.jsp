<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MoneyHub - 出費分析</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/base.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/table.css">
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>カテゴリ</th>
				<th>予算（円）</th>
				<th>実績（円）</th>
				<th>差額</th>
				<th>状態</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="exp" items="${requestScope.AnalysisExpenseList}">
				<tr>
					<td class="name">${exp.name}</td>
					<td>${exp.budget}</td>
					<td>${exp.amount}</td>
					<td>${exp.budget - exp.amount}</td>
					<td><c:choose>
							<c:when test="${exp.amount > exp.budget}">
								<span class="over">超過</span>
							</c:when>
							<c:otherwise>
								<span class="ok">OK</span>
							</c:otherwise>
						</c:choose></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


</body>
</html>
