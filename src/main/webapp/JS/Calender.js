    calendar.render();

    // モーダル閉じる
    const modal = document.getElementById('recordModal');
    modal.querySelector('.close').onclick = closeModal;
    window.onclick = function(event) { if(event.target==modal) closeModal(); }

    function closeModal() {
        modal.style.display='none';
        backToStep0();
    }
   


// --- モーダル Step 切替 ---
function backToStep0() {
    document.getElementById("step0").style.display="block";
    document.getElementById("incomeForm").style.display="none";
    document.getElementById("expenseForm").style.display="none";
}

function showIncome() {
    document.getElementById("step0").style.display="none";
    document.getElementById("incomeForm").style.display="block";
    document.getElementById("expenseForm").style.display="none";
}

function showExpense() {
    document.getElementById("step0").style.display="none";
    document.getElementById("incomeForm").style.display="none";
    document.getElementById("expenseForm").style.display="block";
    showVariable();
}

function backToExpenseStep() {
    document.getElementById("variableForm").style.display="none";
    document.getElementById("fixedForm").style.display="none";
    document.getElementById("expenseForm").style.display="block";
}

function showVariable() {
    document.getElementById("variableForm").style.display="block";
    document.getElementById("fixedForm").style.display="none";
}

function showFixed() {
    document.getElementById("variableForm").style.display="none";
    document.getElementById("fixedForm").style.display="block";
}

function closeEditModal() {
document.getElementById('editExpenseModal').style.display = 'none';
}

function closeEditIncomeModal() {
	  document.getElementById('editIncomeModal').style.display = 'none';
	}

