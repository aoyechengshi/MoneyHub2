<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MoneyHub - 総資産</title>
<!-- 背景 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/base.css">
<!-- ヘッダー -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<!-- カード -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/card.css">
<!-- モーダル -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/modal.css">


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>

	<header>
		<h1>総資産の確認</h1>
		<form action="/Kakeibo/UserFC" method="post">
			<br>
			<button type="submit" name="buttonId" value="e006" class="back-btn">
				ホーム画面へ戻る</button>
		</form>
	</header>

	<div class="container">

		<form action="/Kakeibo/UserFC" method="post" class="card clickable"
			onclick="this.submit()">
			<input type="hidden" name="buttonId" value="e021"> <i
				class="fas fa-wallet"></i> 総資産 <span>現在の資産合計を確認</span>
		</form>

		<div class="card" onclick="openBalanceAnalysisModal()">
			<i class="fas fa-chart-line"></i> 収支分析 <span>月別・年別で収支を確認</span>
		</div>

		<div class="card" onclick="openExpenseModal()">
			<i class="fas fa-chart-line"></i> 出費分析 <span>月別に予算と実績を確認</span>
		</div>

	</div>
	<!-- ===== 出費分析モーダル ===== -->
	<div id="expenseModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeExpenseModal()">&times;</span>

			<h3>出費分析（月選択）</h3>

			<form action="/Kakeibo/UserFC" method="post">
				<input type="month" name="targetMonth" required>
				<button type="submit" name="buttonId" value="e018">分析する</button>
			</form>
		</div>
	</div>

	<!-- ===== 収支分析モーダル ===== -->
	<div id="balanceModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeBalanceAnalysisModal()">&times;</span>

			<h3>収支分析</h3>

			<div class="analysis-menu">

				<form action="/Kakeibo/UserFC" method="post">
					<input type="hidden" name="buttonId" value="e020"> <input
						type="month" name="targetMonth" value="${targetMonth}" required>
					<button type="submit" class="menu-card">収入に対する支出</button>
				</form>

			</div>
		</div>
	</div>


	<script>
		function openExpenseModal() {
			document.getElementById('expenseModal').style.display = 'block';
		}
		function closeExpenseModal() {
			document.getElementById('expenseModal').style.display = 'none';
		}

		function openBalanceAnalysisModal() {
			document.getElementById('balanceModal').style.display = 'block';
		}
		function closeBalanceAnalysisModal() {
			document.getElementById('balanceModal').style.display = 'none';
		}
	</script>

	<c:if test="${not empty errorMessage}">
		<script>
			window.onload = function() {
				openAnalysisModal();
			};
		</script>
	</c:if>

</body>
</html>
