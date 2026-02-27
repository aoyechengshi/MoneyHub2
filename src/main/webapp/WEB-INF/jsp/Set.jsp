<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MoneHub ホーム画面</title>
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
		<h1>設定</h1>
		<form action="/Kakeibo/UserFC" method="post">
		<br>
			<button type="submit" name="buttonId" value="e006" class="back-btn">ホーム画面へ戻る</button>
		</form>
	</header>

	<div class="container">
		<!-- 固定費設定 -->

		<div class="card" onclick="openFixedModal()">
			<i class="fas fa-house"></i> 固定費の設定 <span>家賃・通信費など</span>
		</div>



		<!-- 変動費設定 -->
		<div class="card" onclick="openVariableModal()">
			<i class="fas fa-cart-shopping"></i> 今月の変動費の設定 <span>食費・娯楽費など</span>
		</div>


		<!-- 収入設定 -->
		<div class="card" onclick="openIncomeModal()">
			<i class="fas fa-coins"></i> 収入の設定 <span>給与・ボーナスなど</span>
		</div>

	</div>

	<!-- ===== 固定費設定モーダル ===== -->
	<div id="fixedModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeFixedModal()">&times;</span>
			<h3>固定費の設定</h3>

			<!-- 固定費一覧 -->
			<table>
				<thead>
					<tr>
						<th>カテゴリ</th>
						<th>金額</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cat" items="${requestScope.fixedCategories}">
						<tr>
							<td>${cat.name}</td>
							<td>${cat.budget}円</td>
							<td>
								<form method="post" action="/Kakeibo/UserFC"
									style="display: inline;">
									<input type="hidden" name="categoryId"
										value="${cat.categoryId}">
									<button type="submit" name="buttonId" value="e013"
										onclick="return confirm('この固定費を削除しますか？');">削除</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr>

			<!-- 追加ボタン -->
			<button type="button" onclick="showAddFixedForm()">＋ 固定費を追加
			</button>

			<!-- 追加フォーム（最初は非表示） -->
			<div id="addFixedForm" style="display: none; margin-top: 15px;">
				<h4>固定費を追加</h4>
				<form method="post" action="/Kakeibo/UserFC">
					<label>カテゴリ名</label> <input type="text" name="name" required>

					<label>金額</label> <input type="number" name="budget" required>

					<button type="submit" name="buttonId" value="e012">追加</button>
					<button type="button" onclick="hideAddFixedForm()">キャンセル</button>
				</form>
			</div>
		</div>
	</div>
	<!-- ===== 変動費設定モーダル ===== -->
	<div id="variableModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeVariableModal()">&times;</span>
			<h3>変動費の設定</h3>

			<!-- 変動費一覧 -->
			<!-- 変動費一覧 -->
			<table>
				<thead>
					<tr>
						<th>カテゴリ</th>
						<th>金額</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cat" items="${variableCategories}">
						<tr>
							<td>${cat.name}</td>

							<td>
								<form method="post" action="/Kakeibo/UserFC"
									style="display: inline;">
									<input type="number" name="budget" value="${cat.budget}"
										required> <input type="hidden" name="categoryId"
										value="${cat.categoryId}">
									<button type="submit" name="buttonId" value="e019">更新</button>
								</form>
							</td>

							<td>
								<form method="post" action="/Kakeibo/UserFC"
									style="display: inline;">
									<input type="hidden" name="categoryId"
										value="${cat.categoryId}">
									<button type="submit" name="buttonId" value="e013"
										onclick="return confirm('この変動費を削除しますか？');">削除</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>


			<hr>

			<!-- 追加 -->
			<button type="button" onclick="showAddVariableForm()">＋
				変動費を追加</button>

			<div id="addVariableForm" style="display: none; margin-top: 15px;">
				<h4>変動費を追加</h4>
				<form method="post" action="/Kakeibo/UserFC">
					<label>カテゴリ名</label> <input type="text" name="name" required>

					<label>予算</label> <input type="number" name="budget" required>

					<button type="submit" name="buttonId" value="e014">追加</button>
					<button type="button" onclick="hideAddVariableForm()">キャンセル</button>
				</form>
			</div>
		</div>
	</div>
	<!-- ===== 収入設定モーダル ===== -->
	<!-- ===== 収入カテゴリ設定モーダル ===== -->
	<div id="incomeModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeIncomeModal()">&times;</span>
			<h3>収入カテゴリの設定</h3>

			<!-- 一覧 -->
			<table>
				<thead>
					<tr>
						<th>カテゴリ名</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cat" items="${incomeCategoryList}">
						<tr>
							<td>${cat.category}</td>
							<td>
								<form method="post" action="/Kakeibo/UserFC"
									style="display: inline;">
									<input type="hidden" name="incomeCategoryId"
										value="${cat.incomeCategoryId}">
									<button type="submit" name="buttonId" value="e016"
										onclick="return confirm('この収入カテゴリを削除しますか？');">削除</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr>

			<!-- 追加 -->
			<button type="button" onclick="showAddIncomeForm()">＋
				収入カテゴリを追加</button>

			<div id="addIncomeForm" style="display: none; margin-top: 15px;">
				<h4>収入カテゴリを追加</h4>
				<form method="post" action="/Kakeibo/UserFC">
					<label>カテゴリ名</label> <input type="text" name="category" required>

					<button type="submit" name="buttonId" value="e015">追加</button>
					<button type="button" onclick="hideAddIncomeForm()">キャンセル</button>
				</form>
			</div>
		</div>
	</div>






	<script>
		function openFixedModal() {
			document.getElementById('fixedModal').style.display = 'flex';
		}

		function closeFixedModal() {
			document.getElementById('fixedModal').style.display = 'none';
		}
		function showAddFixedForm() {
			document.getElementById('addFixedForm').style.display = 'block';
		}

		function hideAddFixedForm() {
			document.getElementById('addFixedForm').style.display = 'none';
		}
		function openVariableModal() {
			document.getElementById('variableModal').style.display = 'flex';
		}
		function closeVariableModal() {
			document.getElementById('variableModal').style.display = 'none';
		}
		function showAddVariableForm() {
			document.getElementById('addVariableForm').style.display = 'block';
		}
		function hideAddVariableForm() {
			document.getElementById('addVariableForm').style.display = 'none';
		}
		function openIncomeModal() {
			document.getElementById('incomeModal').style.display = 'flex';
		}
		function closeIncomeModal() {
			document.getElementById('incomeModal').style.display = 'none';
		}
		function showAddIncomeForm() {
			document.getElementById('addIncomeForm').style.display = 'block';
		}
		function hideAddIncomeForm() {
			document.getElementById('addIncomeForm').style.display = 'none';
		}
	</script>

</body>
</html>


