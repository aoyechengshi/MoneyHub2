<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

		<!-- 収支を記録 -->
		<form action="/Kakeibo/UserFC" method="post">
			<button type="submit" name="buttonId" value="e006" class="side-item">
				<i class="fas fa-coins"></i> <span>収支を記録</span>
			</button>
		</form>

		<!-- 設定（親） -->
		<div id="settingToggle" class="side-item setting-parent" style="cursor: pointer;">
			<i class="fas fa-cog"></i> <span>設定</span>
		</div>

		<!-- 設定サブカテゴリ -->
		<div id="settingSub" class="setting-sub">
			<button type="button" class="side-item sub-item" onclick="openFixedModal()">
				<i class="fas fa-house"></i> <span>固定費の設定</span>
			</button>
			<button type="button" class="side-item sub-item" onclick="openVariableModal()">
				<i class="fas fa-cart-shopping"></i> <span>変動費の設定</span>
			</button>
			<button type="button" class="side-item sub-item" onclick="openIncomeModal()">
				<i class="fas fa-coins"></i> <span>収入の設定</span>
			</button>
		</div>

		<!-- 総資産確認（親） -->
		<div id="assetToggle" class="side-item setting-parent" style="cursor: pointer;">
			<i class="fas fa-chart-line"></i> <span>総資産確認</span>
		</div>

		<!-- 総資産サブカテゴリ（formをdivの外に出す） -->
		<div id="assetSub" class="setting-sub">
			<form action="/Kakeibo/UserFC" method="post">
				<button type="submit" class="side-item sub-item" name="buttonId" value="e021">
					<i class="fas fa-wallet"></i><span>総資産</span>
				</button>
			</form>
			<button type="button" class="side-item sub-item" onclick="openBalanceAnalysisModal()">
				<i class="fas fa-chart-bar"></i> <span>収支分析</span>
			</button>
			<button type="button" class="side-item sub-item" onclick="openExpenseModal()">
				<i class="fas fa-receipt"></i> <span>出費分析</span>
			</button>
		</div>

		<!-- スペーサー（ログアウトを下部に固定） -->
		<div class="sidebar-spacer"></div>

		<!-- ログアウト -->
		<form action="/Kakeibo/UserFC" method="post">
			<button type="submit" name="buttonId" value="e002" class="side-item logout-btn">
				<i class="fas fa-right-from-bracket"></i> <span>ログアウト</span>
			</button>
		</form>
