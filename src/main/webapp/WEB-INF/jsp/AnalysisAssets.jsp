<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MoneyHub - 資産分析</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/base.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/table.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/modal.css">
<!-- Chart.js -->
<script defer src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
.chart-area {
	max-width: 900px;
	margin: 24px auto;
	background: var(--bg);
	border-radius: var(--radius-xl);
	padding: 30px;
	border: 1px solid var(--border);
	box-shadow: 0 1px 4px rgba(15, 23, 42, 0.06);
}

.chart-wrapper {
	width: 320px;
	height: 320px;
	margin: 0 auto 30px;
}

.table-area {
	max-width: 720px;
	margin: 0 auto;
}
</style>
</head>

<body>

	<div class="chart-area">

		<!-- ===== 円グラフ ===== -->
		<div class="chart-wrapper">
			<canvas id="assetsPieChart"></canvas>
		</div>

		<!-- ===== 表 ===== -->
		<div class="table-area">
			<table>
				<thead>
					<tr>
						<th>カテゴリ</th>
						<th>金額</th>
						<th>割合</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="grandTotal" value="0" />
					<c:forEach var="a" items="${catgoryTotalAmount}">
						<c:set var="grandTotal" value="${grandTotal + a.amount}" />
					</c:forEach>

					<c:forEach var="a" items="${catgoryTotalAmount}">
						<c:set var="rate" value="${(a.amount * 100.0) / grandTotal}" />
						<tr>
							<td class="name">${a.categoryName}</td>

							<td class="amount"><fmt:formatNumber value="${a.amount}"
									type="number" /> 円</td>

							<td class="rate"><fmt:formatNumber value="${rate}"
									maxFractionDigits="1" /> %
								<div class="rate-bar">
									<span style="width:${rate}%"></span>
								</div></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>



		</div>

		<button type="button" class="action-btn.primary" onclick="openModal()">
			＋ 記録する</button>

		<button type="button" class="action-btn.primary"
			onclick="openCategoryModal()">⚙ 登録する</button>
		<script>
window.onload = function () {

    const labels = [];
    const values = [];
    let total = 0;

    <c:forEach var="a" items="${catgoryTotalAmount}">
        labels.push('${a.categoryName}');
        values.push(Number('${a.amount}') || 0);
        total += Number('${a.amount}') || 0;
    </c:forEach>

    const chartColors = [
        '#2563eb',
        '#22c55e',
        '#f59e0b',
        '#ef4444',
        '#8b5cf6',
        '#06b6d4'
    ];

    /* 中央テキスト */
    const centerTextPlugin = {
        id: 'centerText',
        afterDraw(chart) {
            const { ctx, chartArea:{width,height} } = chart;
            ctx.save();
            ctx.font = 'bold 18px Inter, sans-serif';
            ctx.fillStyle = '#0f172a';
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
            ctx.fillText(
                total.toLocaleString() + ' 円',
                width / 2,
                height / 2
            );
        }
    };

    new Chart(document.getElementById('assetsPieChart'), {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: chartColors,
                borderWidth: 0,
                hoverOffset: 8
            }]
        },
        options: {
            cutout: '72%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: '#64748b',
                        padding: 14
                    }
                },
                tooltip: {
                    callbacks: {
                        label: ctx => {
                            const value = ctx.parsed;
                            const percent = ((value / total) * 100).toFixed(1);
                            return `${ctx.label}: ${value.toLocaleString()} 円（${percent}%）`;
                        }
                    }
                }
            }
        },
        plugins: [centerTextPlugin]
    });
};
</script>
</body>
</html>

