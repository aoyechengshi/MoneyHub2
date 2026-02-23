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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/calendar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/modal.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
	<header>
		<div class="header-brand">
			<img class="logo" src="${pageContext.request.contextPath}/images/MoneyHub.png" alt="MoneyHub">
			<h1>MoneyHub</h1>
		</div>
		<p class="header-welcome">
			ようこそ、<c:out value="${sessionScope.loginUser.userName}" />さん
		</p>
	</header>
	<div class="layout">
		<!-- サイドバー -->
		<nav class="sidebar">
			<jsp:include page="SideBar.jsp" />
		</nav>
		<main class="main-content">
			<c:choose>
				<c:when test="${content == 'assets'}">
					<jsp:include page="AnalysisAssets.jsp" />
				</c:when>
				<c:when test="${content == 'assetsExpense'}">
					<jsp:include page="AnalysisExpense.jsp" />
				</c:when>
				<c:when test="${content == 'assetsIncome'}">
					<jsp:include page="BalanceAnalysis.jsp" />
				</c:when>
				<c:otherwise>
					<jsp:include page="Calender.jsp" />
				</c:otherwise>
			</c:choose>
		</main>
	</div>
	<jsp:include page="Modal.jsp" />
	<script>
document.addEventListener('DOMContentLoaded', function () {

    const calendarEl = document.getElementById('calendar');
    if (!calendarEl) return;

    /* ===== 収入イベント ===== */
    const incomeEvents = [
        <c:forEach var="inc" items="${requestScope.incomeList}" varStatus="status">
        {
            title: "${inc.category}：${inc.amount}円",
            start: "${inc.date}",
            allDay: true,
            backgroundColor: '#0d2818',
            borderColor: '#2d9e6a',
            textColor: '#86d4a8',
            extendedProps: {
                incomeId: "${inc.incomeId}",
                amount: "${inc.amount}",
                note: "${inc.note}",
                category: "${inc.category}"
            }
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    /* ===== 支出イベント ===== */
    const expenseEvents = [
        <c:forEach var="exp" items="${requestScope.expenseList}" varStatus="status">
        {
            title: "${exp.name}：${exp.amount}円",
            start: "${exp.date}",
            allDay: true,
            backgroundColor: "${exp.type == '変動費' ? '#2d0c0c' : '#1a0d38'}",
            borderColor: "${exp.type == '変動費' ? '#c05050' : '#7060c0'}",
            textColor: "${exp.type == '変動費' ? '#e8a0a0' : '#b0a0e0'}",
            extendedProps: {
                expenseId: "${exp.expenseId}",
                amount: "${exp.amount}",
                memo: "${exp.memo}",
                categoryName: "${exp.name}"
            }
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const allEvents = incomeEvents.concat(expenseEvents);

    /* ===== カレンダー生成 ===== */
    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        fixedWeekCount: false,
        aspectRatio: 1.8,
        events: allEvents,
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek'
        },

        dateClick: function (info) {
            document.getElementById('incomeDate').value = info.dateStr;
            document.getElementById('expenseDate').value = info.dateStr;
            document.getElementById('expenseDateFix').value = info.dateStr;
            document.getElementById('recordModal').style.display = 'flex';
        },

        eventClick: function (info) {

            /* ===== 出費 ===== */
            if (info.event.extendedProps.expenseId) {
                document.getElementById('editExpenseId').value = info.event.extendedProps.expenseId;
                document.getElementById('editCategory').value = info.event.extendedProps.categoryName;
                document.getElementById('editAmount').value = info.event.extendedProps.amount;
                document.getElementById('editMemo').value = info.event.extendedProps.memo;
                document.getElementById('editDate').value = info.event.startStr;
                document.getElementById('editExpenseModal').style.display = 'flex';
                return;
            }

            /* ===== 収入 ===== */
            if (info.event.extendedProps.incomeId) {
                document.getElementById('editIncomeId').value = info.event.extendedProps.incomeId;
                document.getElementById('editIncomeCategory').value = info.event.extendedProps.category;
                document.getElementById('editIncomeAmount').value = info.event.extendedProps.amount;
                document.getElementById('editIncomeNote').value = info.event.extendedProps.note;
                document.getElementById('editIncomeDate').value = info.event.startStr;
                document.getElementById('editIncomeModal').style.display = 'flex';
            }
        }
    });

    calendar.render();

    /* ===== モーダル閉じる処理 ===== */
    const modal = document.getElementById('recordModal');
    const closeBtn = modal.querySelector('.close');

    closeBtn.onclick = function () {
        modal.style.display = 'none';
        backToStep0();
    };

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
            backToStep0();
        }
    };

});
</script>
	<c:if test="${not empty errorMessage}">
		<script> window.onload = function() { openAnalysisModal(); }; </script>
	</c:if>
	<script src="${pageContext.request.contextPath}/JS/Calender.js"></script>
	<script src="${pageContext.request.contextPath}/JS/Modal.js"></script>
	<script src="${pageContext.request.contextPath}/JS/SideBar.js"></script>
</body>
</html>