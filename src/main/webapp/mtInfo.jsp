<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>산정보화면</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- ============ Google Fonts begin ============ -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
	rel="stylesheet">
<!-- ============ Google Fonts end ============ -->

<style>
/* 배경이미지 */
.bg-fixed {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	z-index: -2;
}

/* 배경 위 하얀창 */
.bg-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(255, 255, 255, 0.5);
	z-index: -1;
}

.container-box {
	position: relative;
	max-width: 1000px;
	margin: 0 auto;
	padding: 60px 20px;
}

.title-box {
	text-align: center;
	color: black;
	text-shadow: 0 2px 6px rgba(255, 255, 255, 0.6);
	margin-bottom: 30px;
	font-family: "Noto Sans", sans-serif;
}

.title-box .title-main1 {
	font-size: 50px;
	font-weight: 700;
	margin: 0;
}

.title-box .title-main2 {
	font-size: 25px;
	font-weight: 500;
	margin: 0;
}

.title-box p {
	margin: 5px 0;
}

.accordion-button {
	font-size: 30px;
	font-weight: 600;
	font-family: "Noto Sans", sans-serif;
}

/*아코디언 내*/
.mt-img {
	width: 100%;
	max-height: 500px;
	object-fit: cover;
	border-radius: 8px;
	margin-bottom: 15px;
}

.trail-img {
	width: 100%;
	max-height: 500px;
	object-fit: contain;
	border-radius: 8px;
	margin-top: 15px;
}

.accordion-body p {
	font-size: 20px;
}

</style>

</head>
<body>

	<img src="images/mt4.jpg" class="bg-fixed" alt="뒷 배경">
	<div class="bg-overlay"></div>

	<div class="container-box">
		<div class="title-box">
			<p class="title-main1">Mountains Information</p>
			<p class="title-main2">Enjoy your trip in the mountains of Seoul!</p>
		</div>

		<!-- ============ accordion begin ============ -->
		<div class="accordion shadow-lg rounded" id="myAccordion">
			<c:forEach var="mt" items="${mtList}" varStatus="status">
				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button ${status.first ? '' : 'collapsed'}"
							type="button" data-bs-toggle="collapse"
							data-bs-target="#collapse${mt.mtId}"
							aria-expanded="${status.first ? 'true' : 'false'}"
							aria-controls="collapse${mt.mtId}">
							🚩 ${mt.mtName}
						</button>
					</h2>
					<div id="collapse${mt.mtId}"
						class="accordion-collapse collapse ${status.first ? 'show' : ''}">
						<!-- 안의 내용 -->
						<div class="accordion-body">
							<img src="images/${mt.mtImg}" class="mt-img" alt="${mt.mtName}">
							<p><strong>🏔위치:</strong> ${mt.mtLocation}</p>
							<p><strong>🏔높이:</strong> ${mt.mtHeight}m</p>
							<p>${mt.mtContent}</p>
							<img src="images/${mt.mtTrailImg}" class="trail-img" alt="${mt.mtName}S">
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<!-- ============ accordion end ============ -->
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>