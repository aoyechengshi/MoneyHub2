
	function openExpenseModal() {
		document.getElementById('expenseModal').style.display = 'flex';
	}
	function closeExpenseModal() {
		document.getElementById('expenseModal').style.display = 'none';
	}

	function openBalanceAnalysisModal() {
		document.getElementById('balanceModal').style.display = 'flex';
	}
	function closeBalanceAnalysisModal() {
		document.getElementById('balanceModal').style.display = 'none';
	}
	function openModal() {
	    document.getElementById('assetsModal').style.display = 'flex';
	}

	function closeModal() {
	    document.getElementById('assetsModal').style.display = 'none';
	}
	function openCategoryModal() {
	    document.getElementById('categoryModal').style.display = 'flex';
	}

	function closeCategoryModal() {
	    document.getElementById('categoryModal').style.display = 'none';
	}

	/* ===== 分析モーダルを開く（errorMessage時に呼ばれる） ===== */
	function openAnalysisModal() {
		openBalanceAnalysisModal();
	}
