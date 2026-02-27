<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>収支分析</title>

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/base.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">

<!-- Chart.js -->
<script defer src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
.charts-wrapper {
	display: flex;
	justify-content: center;
	gap: 20px;
	flex-wrap: wrap;
	margin: 24px auto;
	max-width: 1000px;
	padding: 0 16px;
}

.chart-container {
	background: var(--bg);
	border-radius: var(--radius-xl);
	padding: 20px;
	border: 1px solid var(--border);
	box-shadow: 0 1px 4px rgba(15, 23, 42, 0.06);
	display: flex;
	justify-content: center;
	align-items: center;
}

.chart-container.bar {
	width: 460px;
	height: 340px;
}

.chart-container.pie {
	width: 260px;
	height: 260px;
}

.summary {
	max-width: 720px;
	margin: 24px auto;
	background: var(--bg);
	border-radius: var(--radius-xl);
	padding: 20px 28px;
	text-align: center;
	border: 1px solid var(--border);
	box-shadow: 0 1px 4px rgba(15, 23, 42, 0.06);
	color: var(--text-primary);
}

.summary p {
	margin-top: 10px;
	font-size: 1.1em;
	font-weight: 700;
	color: var(--accent);
}
</style>
</head>

<body>

	<!-- ===== グラフ ===== -->
	<div class="charts-wrapper">

		<div class="chart-container bar">
			<canvas id="balanceChart"></canvas>
		</div>

		<div class="chart-container pie">
			<canvas id="expenseRatioChart"></canvas>
		</div>

		<div class="chart-container pie">
			<canvas id="categoryExpenseChart"></canvas>
		</div>

	</div>

	<!-- ===== サマリー ===== -->
	<div class="summary">
		総収入：${income.sumIncomeAmount} 円<br> 固定費：${analysis.fixedExpense}
		円<br> 変動費：${analysis.variableExpense} 円<br>
		<p>収支： ${income.sumIncomeAmount
      - analysis.fixedExpense
      - analysis.variableExpense}
			円</p>
	</div>

	<script>
window.onload = function () {

  /* ===== 数値（完全NaN対策） ===== */
  const income   = Number('${income.sumIncomeAmount}') || 0;
  const fixed    = Number('${analysis.fixedExpense}') || 0;
  const variable = Number('${analysis.variableExpense}') || 0;

  const expense = fixed + variable;
  const remain  = income - expense;

  const chartColors = [
    '#2563eb',
    '#22c55e',
    '#f59e0b',
    '#ef4444',
    '#8b5cf6',
    '#06b6d4'
  ];

  const legendStyle = { position: 'bottom', labels: { color: '#64748b', padding: 12 } };

  /* ===== 棒グラフ：収支全体 ===== */
  new Chart(document.getElementById('balanceChart'), {
    type: 'bar',
    data: {
      labels: ['総収入', '総支出', '残り'],
      datasets: [{
        data: [income, expense, remain],
        backgroundColor: [
          '#22c55e', // 収入
          '#ef4444', // 支出
          '#2563eb'  // 残り
        ],
        borderWidth: 0,
        borderRadius: 6
      }]
    },
    options: {
      plugins: { legend: { display: false } },
      scales: {
        y: {
          beginAtZero: true,
          grid: { color: '#f1f5f9' },
          ticks: {
            color: '#64748b',
            callback: v => v.toLocaleString() + ' 円'
          }
        },
        x: {
          grid: { display: false },
          ticks: { color: '#64748b' }
        }
      }
    }
  });

  /* ===== 円グラフ：固定費 vs 変動費 ===== */
  new Chart(document.getElementById('expenseRatioChart'), {
    type: 'doughnut',
    data: {
      labels: ['固定費', '変動費'],
      datasets: [{
        data: [fixed, variable],
        backgroundColor: ['#2563eb', '#f59e0b'],
        borderWidth: 0,
        hoverOffset: 10
      }]
    },
    options: {
      plugins: {
        legend: legendStyle,
        tooltip: {
          callbacks: {
            label: function(ctx) {
              const value = ctx.parsed;
              const total = fixed + variable;
              const percent = total === 0 ? 0 :
                ((value / total) * 100).toFixed(1);
              return `${ctx.label}: ${value.toLocaleString()} 円（${percent}%）`;
            }
          }
        }
      }
    }
  });

  /* ===== 円グラフ：変動費カテゴリ別 ===== */
  const categoryLabels = [];
  const categoryAmounts = [];

  <c:forEach var="item" items="${categoryExpenseList}">
    categoryLabels.push('${item.categoryName}');
    categoryAmounts.push(Number('${item.categoryVariableAmount}') || 0);
  </c:forEach>

  const totalCategory = categoryAmounts.reduce((a,b)=>a+b,0);

  if (totalCategory > 0) {
    new Chart(document.getElementById('categoryExpenseChart'), {
      type: 'doughnut',
      data: {
        labels: categoryLabels,
        datasets: [{
          data: categoryAmounts,
          backgroundColor: chartColors,
          borderWidth: 0,
          hoverOffset: 10
        }]
      },
      options: {
        plugins: {
          legend: legendStyle,
          tooltip: {
            callbacks: {
              label: function(ctx) {
                const value = ctx.parsed;
                const percent = totalCategory === 0 ? 0 :
                  ((value / totalCategory) * 100).toFixed(1);
                return `${ctx.label}: ${value.toLocaleString()} 円（${percent}%）`;
              }
            }
          }
        }
      }
    });
  }
};
</script>

</body>
</html>

