
/* ===== モーダル open/close ===== */
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

/* ===== サイドバー トグル ===== */
document.addEventListener('DOMContentLoaded', function() {

	// 「設定」トグル
	document.getElementById('settingToggle').addEventListener('click', () => {
		document.getElementById('settingSub').classList.toggle('open');
	});

	// 「総資産確認」トグル
	document.getElementById('assetToggle').addEventListener('click', () => {
		document.getElementById('assetSub').classList.toggle('open');
	});

});