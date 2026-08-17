<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
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
.main-wrapper {
	position: relative;
}

.main_carousel, .main_carousel .carousel-inner, .main_carousel .carousel-item
	{
	height: 1200px;
}

.main_carousel img {
	width: 100%;
	height: 1200px;
	object-fit: cover;
	object-position: center;
}

.main_title {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: 10;
	color: white;
	text-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	pointer-events: none;
}

.main_title p {
	font-family: "Noto Sans", sans-serif;
	margin: 0;
}

.title-sub1 {
	font-size: 30px;
	font-weight: 700;
}

.title-main1 {
	font-size: 60px;
	font-weight: 500;
}

.title-main2 {
	width: 800px;
	margin: 10px;
	filter: drop-shadow(0 2px 6px rgba(0, 0, 0, 0.5));
}

.highlight {
	color: #0dcaf0;
}

.main-btn {
	margin-top: 20px;
	pointer-events: auto;
}

</style>
</head>
<body>

	<div class="main-wrapper">

		<div class="main_title">
			<p class="title-sub1">
				<span class="highlight">KOREA MOUNTAIN TRAVLES</span>
			</p>
			<p class="title-main1">Start Your</p>
			<img src="images/logo.png" alt="Seoul Hiking" class="title-main2">
			<button type="button" class="btn btn-info btn-lg main-btn">KOR / ENG</button>
		</div>

		<!-- ============ Carousel begin ============ -->
		<div id="carouselExampleIndicators"
			class="carousel slide main_carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="images/mt1.jpg" class="d-block w-100" alt="mt1">
				</div>
				<div class="carousel-item">
					<img src="images/mt2.jpg" class="d-block w-100" alt="mt2">
				</div>
				<div class="carousel-item">
					<img src="images/mt3.jpg" class="d-block w-100" alt="mt3">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<!-- ============ Carousel end ============ -->



	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>