<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ===== 固定費設定モーダル ===== -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/modal.css">
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
								<input type="hidden" name="categoryId" value="${cat.categoryId}">
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
		<button type="button" onclick="showAddFixedForm()">＋ 固定費を追加</button>

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
								<input type="hidden" name="categoryId" value="${cat.categoryId}">
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
<!-- ======== モーダル: 収入・支出統合 ======== -->
<div id="recordModal" class="modal">
	<div class="modal-content">
		<span class="close">&times;</span>
		<h3>記録登録</h3>

		<!-- Step0: 収入 or 支出 -->
		<div id="step0">
			<p>収入か支出か選択してください:</p>
			<button type="button" onclick="showIncome()">収入</button>
			<button type="button" onclick="showExpense()">支出</button>
		</div>

		<!-- 収入フォーム -->
		<form id="incomeForm" style="display: none;" method="post"
			action="UserFC">
			<input type="hidden" name="incomeDate" id="incomeDate"> <label>カテゴリ:</label>
			<select name="incomeCategoryId">
				<c:forEach var="cat" items="${requestScope.incomeCategoryList}">
					<!-- Income クラスのフィールド名に合わせる -->
					<option value="${cat.incomeCategoryId}">${cat.category}</option>
				</c:forEach>
			</select> <label>金額:</label> <input type="number" name="incomeAmount" required>
			<label>メモ:</label> <input type="text" name="note">
			<button type="submit" name="buttonId" value="e005">登録</button>
			<button type="button" class="modal-btn" onclick="backToStep0()">戻る</button>
		</form>


		<!-- 支出フォーム -->
		<div id="expenseForm" style="display: none;">
			<p>費目を選択してください:</p>
			<button type="button" class="modal-btn" onclick="showVariable()">変動費</button>
			<button type="button" class="modal-btn" onclick="showFixed()">固定費</button>

			<!-- 変動費 -->
			<form id="variableForm" style="display: none;" method="post"
				action="UserFC">
				<input type="hidden" name="date" id="expenseDate"> <label>カテゴリ:</label>
				<select name="categoryId">
					<c:forEach var="cat" items="${requestScope.variableCategories}">
						<option value="${cat.categoryId}">${cat.name}</option>
					</c:forEach>
				</select> <label>金額:</label> <input type="number" name="amount" required>
				<label>メモ:</label> <input type="text" name="memo">
				<button type="submit" name="buttonId" value="e003">登録</button>
				<button type="button" class="modal-btn"
					onclick="backToExpenseStep()">戻る</button>
			</form>

			<!-- 固定費 -->
			<form id="fixedForm" style="display: none;" method="post"
				action="UserFC">
				<input type="hidden" name="date" id="expenseDateFix">
				<p>支払済みにする固定費を選択:</p>
				<table>
					<thead>
						<tr>
							<th>選択</th>
							<th>カテゴリ</th>
							<th>金額</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="cat" items="${requestScope.fixedCategories}">
							<tr>
								<td><input type="checkbox" name="categories"
									value="${cat.categoryId},${cat.name},${cat.budget}"></td>
								<td>${cat.name}</td>
								<td>${cat.budget}円</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="submit" name="buttonId" value="e004">記録</button>
				<button type="button" class="modal-btn"
					onclick="backToExpenseStep()">戻る</button>
			</form>
		</div>
	</div>
</div>
<!-- ===== 出費編集モーダル ===== -->
<div id="editExpenseModal" class="modal">
	<div class="modal-content">
		<span class="close" onclick="closeEditModal()">&times;</span>
		<h3>出費編集</h3>

		<form method="post" action="UserFC">
			<input type="hidden" name="expenseId" id="editExpenseId"> <label>カテゴリ</label>
			<input type="text" id="editCategory" readonly> <label>金額</label>
			<input type="number" name="amount" id="editAmount" required>
			<label>日付</label> <input type="date" name="date" id="editDate"
				required> <label>メモ</label> <input type="text" name="memo"
				id="editMemo">

			<button type="submit" name="buttonId" value="e007">更新</button>
			<button type="submit" name="buttonId" value="e008"
				onclick="return confirm('この出費を削除しますか？');">削除</button>
		</form>
	</div>
</div>

<!-- ===== 収入編集モーダル ===== -->
<div id="editIncomeModal" class="modal">
	<div class="modal-content">
		<span class="close" onclick="closeEditIncomeModal()">&times;</span>
		<h3>収入編集</h3>

		<form method="post" action="UserFC">
			<input type="hidden" name="incomeId" id="editIncomeId"> <label>カテゴリ</label>
			<input type="text" id="editIncomeCategory" readonly> <label>金額</label>
			<input type="number" name="incomeAmount" id="editIncomeAmount"
				required> <label>日付</label> <input type="date"
				name="incomeDate" id="editIncomeDate" required> <label>メモ</label>
			<input type="text" name="note" id="editIncomeNote">

			<button type="submit" name="buttonId" value="e009">更新</button>
			<button type="submit" name="buttonId" value="e010"
				onclick="return confirm('この収入を削除しますか？');">削除</button>
		</form>
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

<!-- ===== 資産記録モーダル ===== -->
		<div id="assetsModal" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeModal()">&times;</span>
				<h2>資産を記録</h2>

				<form action="/Kakeibo/UserFC" method="post">

					<!-- カテゴリ選択 -->
					<label>資産カテゴリ</label> <select name="assetsCategoryId" required>
						<c:forEach var="c" items="${catgoryName}">
							<option value="${c.assetsCategoryId}">${c.categoryName}</option>
						</c:forEach>
					</select>

					<!-- 金額入力 -->
					<label>金額（円）</label> <input type="number" name="amount" required
						min="0" step="1">

					<!-- 日付（※Actionで使ってるので必須） -->
					<label>記録日</label> <input type="date" name="recordDate" required>

					<!-- ボタン -->
					<div class="modal-buttons">
						<button type="submit" name="buttonId" value="e022">記録する</button>
						<button type="button" class="cancel-btn" onclick="closeModal()">キャンセル</button>
					</div>

				</form>

			</div>
		</div>
		<!-- ===== 資産カテゴリ追加モーダル ===== -->
		<div id="categoryModal" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeCategoryModal()">&times;</span>
				<h2>資産項目を追加</h2>

				<form action="/Kakeibo/UserFC" method="post">
					<!-- アクション識別 -->
					<input type="hidden" name="buttonId" value="e023">

					<!-- 項目名 -->
					<label>項目名</label> <input type="text" name="categoryName" required
						maxlength="30" placeholder="例：暗号資産、タンス預金">

					<!-- ボタン -->
					<div class="modal-buttons">
						<button type="submit" class="submit-btn" value="e023">登録する</button>
						<button type="button" class="cancel-btn"
							onclick="closeCategoryModal()">キャンセル</button>
					</div>
				</form>
			</div>
		</div>

