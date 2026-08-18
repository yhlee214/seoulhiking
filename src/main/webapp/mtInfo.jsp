<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

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

.title-box .title-desc {
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

.review-btn-wrap {
	text-align: center;
	margin-top: 20px;
}
</style>

<img src="images/mt4.jpg" class="bg-fixed" alt="뒷 배경">
<div class="bg-overlay"></div>

<div class="container-box">
	<div class="title-box">
		<c:choose>
			<c:when test="${param.lang == 'kor'}">
				<p class="title-main1">서울 산 정보</p>
				<p class="title-desc">서울에서 즐거운 산행 하세요!</p>
			</c:when>
			<c:otherwise>
				<p class="title-main1">Mountains Information</p>
				<p class="title-desc">Enjoy your trip in the mountains of Seoul!</p>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="accordion shadow-lg rounded" id="myAccordion">
		<c:forEach var="mt" items="${mtList}" varStatus="status">
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button ${status.first ? '' : 'collapsed'}"
						type="button" data-bs-toggle="collapse"
						data-bs-target="#collapse${mt.mtId}"
						aria-expanded="${status.first ? 'true' : 'false'}"
						aria-controls="collapse${mt.mtId}">🚩 ${mt.mtName}</button>
				</h2>
				<div id="collapse${mt.mtId}"
					class="accordion-collapse collapse ${status.first ? 'show' : ''}">
					<div class="accordion-body">
						<img src="images/${mt.mtImg}" class="mt-img" alt="${mt.mtName}">
						<p>
							<strong>🏔location:</strong> ${mt.mtLocation}
						</p>
						<p>
							<strong>🏔height:</strong> ${mt.mtHeight}m
						</p>
						<p>${mt.mtContent}</p>
						<img src="images/${mt.mtTrailImg}" class="trail-img"
							alt="${mt.mtName}S">
						<div class="review-btn-wrap">
							<button type="button" class="btn btn-primary btn-lg"
								onclick="location.href='review.do?mtId=${mt.mtId}'">Write
								Review</button>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>