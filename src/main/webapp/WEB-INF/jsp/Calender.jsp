<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- FullCalendar -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Lato:wght@300;400&display=swap"
	rel="stylesheet">

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/base.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/calendar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/modal.css">


<div style="width: 100%; min-width: 0; box-sizing: border-box;">
	<div id="calendar"></div>
	<div id="fcTooltip" class="fc-event-tooltip"></div>
</div>


