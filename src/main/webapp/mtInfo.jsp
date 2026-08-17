<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

/*아코디언 내 사진*/
.mt-img {
	width: 100%;
	max-height: 500px;
	object-fit: cover;
	border-radius: 8px;
	margin-bottom: 15px;
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
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapse1"
						aria-expanded="true" aria-controls="collapse1">🚩 Bukhansan</button>
				</h2>
				<div id="collapse1" class="accordion-collapse collapse show">
					<div class="accordion-body">
						<img src="images/bukhansan.jpg" class="mt-img" alt="Bukhansan">
						<strong>This is the first item's accordion body.</strong> It is
						shown by default, until the collapse plugin adds the appropriate
						classes that we use to style each element.
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapse2"
						aria-expanded="false" aria-controls="collapse2">🚩 Gwanaksan</button>
				</h2>
				<div id="collapse2" class="accordion-collapse collapse">
					<div class="accordion-body">
						<img src="images/gwanaksan.jpg" class="mt-img" alt="Gwanaksan">
						<strong>This is the second item's accordion body.</strong>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapse3"
						aria-expanded="false" aria-controls="collapse3">🚩 Bugaksan</button>
				</h2>
				<div id="collapse3" class="accordion-collapse collapse">
					<div class="accordion-body">
						<img src="images/bugaksan.jpg" class="mt-img" alt="Bugaksan">
						<strong>This is the third item's accordion body.</strong>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapse4"
						aria-expanded="false" aria-controls="collapse4">🚩 Inwangsan</button>
				</h2>
				<div id="collapse4" class="accordion-collapse collapse">
					<div class="accordion-body">
						<img src="images/inwangsan.jpg" class="mt-img" alt="Inwangsan">
						<strong>This is the fourth item's accordion body.</strong>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapse5"
						aria-expanded="false" aria-controls="collapse5">🚩 Namsan</button>
				</h2>
				<div id="collapse5" class="accordion-collapse collapse">
					<div class="accordion-body">
						<img src="images/namsan.jpg" class="mt-img" alt="Namsan">
						<strong>This is the fourth item's accordion body.</strong>
					</div>
				</div>
			</div>
		</div>
		<!-- ============ accordion end ============ -->
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>