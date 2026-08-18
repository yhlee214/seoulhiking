<%-- 
  [페이지 지시어]
  이 JSP가 자바로 실행되고, 응답은 UTF-8 인코딩된 HTML이라는 걸 선언
  language: 이 페이지 안 스크립틀릿이 자바로 작성됨을 명시
  contentType: 브라우저에게 "이건 HTML이고 UTF-8로 읽어라"고 알려줌
  pageEncoding: JSP 파일 자체를 UTF-8로 읽으라는 뜻 (한글 깨짐 방지)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
  JSTL core 태그립 선언. 이게 있어야 <c:forEach>, <c:if>, <c:choose> 같은 태그를 쓸 수 있음
  prefix="c" → 앞으로 c:태그명 형식으로 사용하겠다는 별명 지정
  Jakarta EE 9+ / Tomcat 10+ 환경이라 URI가 jakarta.tags.core (구버전은 java.sun.com 이었음)
--%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%-- 
  JSTL functions 태그립. fn:substring 같은 문자열 함수를 쓰기 위해 필요
  닉네임 첫 글자만 잘라서 아바타에 넣을 때 사용함 (아래에서 사용)
--%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>

<!-- HTML5 문서라는 선언 -->
<!DOCTYPE html>
<html>
<head>
<!-- 문서 자체의 문자 인코딩을 UTF-8로 지정 (브라우저가 한글 깨지지 않게 읽음) -->
<meta charset="UTF-8">

<!-- 브라우저 탭에 표시될 제목 -->
<title>등산 리뷰 - 서울하이킹</title>

<!-- Bootstrap 5.3.3 CSS 프레임워크 불러오기: 버튼, 그리드, 모달 등 기본 스타일 제공 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons 폰트 불러오기: 연필, 휴지통 등 아이콘 사용을 위함 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
   
<!-- Google Fonts 서버에 미리 연결(preconnect)해서 폰트 로딩 속도를 살짝 앞당김 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Noto Sans KR 한글 폰트 불러오기: weight 400(보통),500,700(굵게),900(아주 굵게) 4가지 굵기 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<style>
/* html 태그 전체 배경에 산 사진을 깔아둠.
   center center: 이미지 가운데 정렬 / cover: 화면을 꽉 채우도록 비율 유지하며 확대
   no-repeat: 이미지 반복 안 함 / fixed: 스크롤해도 배경은 고정됨 */
html {
   background: url('images/reviewbgi.jpg') center center / cover no-repeat fixed;
}

/* body에는 아이보리색 반투명(88%) 레이어를 씌워서
   뒤에 사진이 은은하게 비치되 글씨는 잘 읽히게 함 */
body {
   background: linear-gradient(rgba(250, 246, 238, .88), rgba(250, 246, 238, .88));
   color: #2b2b2b;                          /* 기본 글자색: 짙은 회색(거의 검정) */
   font-family: "Noto Sans KR", sans-serif; /* 위에서 불러온 한글 폰트 적용 */
   min-height: 100vh;                       /* 화면 높이 이상으로 배경이 항상 채워지게 */
}

/* 상단 타이틀(h2) 스타일 */
.page-header h2 {
   font-weight: 900;      /* 아주 굵게 */
   letter-spacing: -0.5px; /* 글자 사이 간격 살짝 좁힘 (타이틀 느낌) */
}

/* 상단 부제목(p) 스타일 */
.page-header p {
   color: #9a9184;    /* 연한 갈색톤 회색 */
   margin-bottom: 0;  /* 아래 여백 제거 */
}

/* "리뷰 작성하기" 버튼 스타일 */
#btnWrite {
   border-radius: 999px;  /* 숫자를 크게 줘서 완전히 둥근 알약 모양으로 */
   padding: 10px 22px;    /* 위아래 10px, 좌우 22px 여백 */
   font-weight: 700;      /* 굵은 글씨 */
   box-shadow: 0 4px 14px rgba(13, 202, 240, .35); /* 하늘색 그림자로 입체감 */
   border: none;          /* 테두리 없앰 */
}

/* 리뷰 카드 하나하나의 공통 스타일 */
.review-card {
   background: rgba(255, 253, 248, .92); /* 거의 흰색인데 92%만 불투명 (뒤 배경 살짝 비침) */
   border: 1px solid #e5ddc9;            /* 연한 베이지색 얇은 테두리 */
   border-radius: 16px;                  /* 모서리 둥글게 */
   padding: 24px;                        /* 안쪽 여백 */
   margin-bottom: 24px;                  /* 카드 사이 아래 간격 */
   height: 100%;                         /* 같은 행의 카드들 높이를 맞춤 (그리드용) */
   backdrop-filter: blur(6px);           /* 카드 뒤에 비치는 배경을 블러 처리 (유리질감) */
   transition: transform .18s ease, box-shadow .18s ease; /* 아래 hover효과가 부드럽게 애니메이션되도록 */
}

/* 마우스를 카드 위에 올렸을 때(hover)만 적용되는 스타일 */
.review-card:hover {
   transform: translateY(-4px);              /* 위로 4px 살짝 떠오름 */
   box-shadow: 0 12px 28px rgba(43, 43, 43, .10); /* 그림자 진해짐 */
   border-color: #d8cda9;                    /* 테두리 색 살짝 진해짐 */
}

/* 리뷰 제목(따옴표 안의 텍스트) 스타일 */
.review-title {
   font-weight: 700;
   font-size: 1.15rem;
   margin: 0;
   color: #2b2b2b;
   line-height: 1.4; /* 줄간격 */
}

/* 리뷰 본문 텍스트 스타일 */
.review-content {
   color: #4a4a4a;
   line-height: 1.65;
   margin-top: 10px;
   white-space: pre-line; /* 사용자가 입력한 줄바꿈(\n)이 그대로 화면에 반영되게 함 */
   font-size: .95rem;
}

/* 리뷰 사진들을 담는 가로 정렬 컨테이너 */
.review-photos {
   display: flex;    /* 가로로 나란히 배치 */
   gap: 8px;         /* 사진 사이 간격 */
   margin-top: 14px;
}

/* 리뷰 사진 한 장의 크기/모양 */
.review-photo {
   width: 100%;
   max-width: 220px;
   height: 130px;
   object-fit: cover; /* 비율 유지하며 이 크기에 꽉 채우고 넘치는 부분은 잘라냄 */
   border-radius: 10px;
}

/* 카드 하단, 닉네임/산이름이 들어가는 영역 */
.review-meta {
   display: flex;
   align-items: center;      /* 세로 가운데 정렬 */
   gap: 8px;                 /* 요소 사이 간격 */
   color: #7a7a7a;
   font-size: .85rem;
   margin-top: 16px;
   padding-top: 14px;
   border-top: 1px dashed #e5ddc9; /* 위에 점선 구분선 */
}

/* 닉네임 첫 글자가 들어가는 동그란 아바타 */
.review-avatar {
   width: 28px;
   height: 28px;
   border-radius: 50%; /* 완전한 원 */
   background: linear-gradient(135deg, #0dcaf0, #0d8bf0); /* 하늘색→파랑 그라데이션 */
   color: #fff;
   display: inline-flex;
   align-items: center;
   justify-content: center; /* 글자를 원 안 정가운데 배치 */
   font-size: .8rem;
   font-weight: 700;
   flex-shrink: 0; /* 좁은 화면에서도 이 크기 그대로 유지, 찌그러지지 않게 */
}

/* 닉네임 텍스트 스타일 */
.review-nick {
   font-weight: 600;
   color: #3f3f3f;
}

/* 산 이름이 들어가는 뱃지(주황 톤) */
.mt-badge {
   background: #fff2e0 !important; /* !important: Bootstrap 기본 뱃지 스타일보다 우선 적용되게 강제 */
   color: #b5651d !important;
   font-weight: 600;
   border-radius: 999px;
   padding: .35em .75em;
}

/* 수정/삭제 버튼들 스타일 */
.review-actions .btn {
   margin-left: 4px;      /* 버튼 사이 간격 */
   border-radius: 999px;  /* 둥근 버튼 */
}

/* 리뷰가 하나도 없을 때 보여주는 영역 */
.empty-state {
   text-align: center;
   padding: 70px 20px;
   color: #9a9184;
}

/* 빈 상태 안의 아이콘 스타일 */
.empty-state i {
   font-size: 2.5rem;
   display: block;      /* 아이콘을 한 줄 통째로 차지하게 해서 아래 텍스트와 줄바꿈 */
   margin-bottom: 12px;
   opacity: .5;         /* 반투명하게 흐릿한 느낌 */
}

/* 모달(작성/수정 폼) 관련 스타일 시작 */
.modal-content {
   background: rgba(255, 253, 248, .97); /* 카드보다 더 불투명 (97%) */
   color: #2b2b2b;
   border-radius: 16px;
   border: none;
   backdrop-filter: blur(6px);
}

/* 모달 상단 제목 영역 아래 테두리 */
.modal-header {
   border-bottom: 1px solid #eee2c9;
}

/* 모달 하단 버튼 영역 위 테두리 */
.modal-footer {
   border-top: 1px solid #eee2c9;
}

/* 입력창(input, textarea, select) 공통 스타일
   !important로 강제하는 이유: 배경 이미지 위에서도 입력창 글씨가 항상 잘 보이게(검정 글씨+흰 배경) 고정하려고 */
.form-control, .form-select {
   color: #2b2b2b !important;
   background-color: #ffffff !important;
   border-radius: 10px;
}

/* 입력창의 placeholder(안내문구) 색상 */
.form-control::placeholder {
   color: #9a9a9a;
}

/* 저장 버튼 스타일 */
#btnSave {
   border-radius: 999px;
   padding: 8px 22px;
   font-weight: 700;
}
</style>
</head>
<body>

   <!-- Bootstrap의 container: 화면 가운데 정렬 + 좌우 여백 자동 조절, py-5: 위아래 padding 크게 -->
   <div class="container py-5">

      <!-- 상단 헤더: 제목/부제목과 작성 버튼을 양쪽 끝으로 배치(justify-content-between) -->
      <div
         class="page-header d-flex justify-content-between align-items-center mb-4">
         <div>
            <h2>🏔️ Seoul Hiking Review</h2>
            <p>다녀온 산의 생생한 후기를 남겨보세요 ✍️</p>
         </div>
         <!-- 리뷰 작성 버튼. id="btnWrite"로 아래 JS가 이 버튼의 클릭을 감지함 -->
         <button type="button" class="btn b   tn-info" id="btnWrite">
            <i class="bi bi-pencil-square me-1"></i> 리뷰 작성하기
         </button>
      </div>

      <!-- 리뷰 목록이 들어가는 영역 -->
      <div id="reviewBody">

         <%-- 
           c:choose / c:when / c:otherwise = 자바의 if-else와 같은 역할
           EL 표현식 ${reviewlist}는 ShController가 req.setAttribute("reviewlist", list)로
           넣어준 List<ReviewTO> 객체를 그대로 꺼내오는 것
         --%>
         <c:choose>
            <%-- empty reviewlist: 리스트가 null이거나 크기가 0이면 참 --%>
            <c:when test="${empty reviewlist}">
               <!-- 리뷰가 하나도 없을 때 보여줄 안내 문구 -->
               <div class="empty-state">
                  <i class="bi bi-chat-square-text"></i>
                  🥾 아직 작성된 리뷰가 없습니다. 첫 리뷰를 남겨보세요!
               </div>
            </c:when>

            <%-- 리뷰가 1개 이상 있을 때 실행되는 부분 --%>
            <c:otherwise>
               <!-- Bootstrap row: 그리드 시작. 이 안의 col-md-6들이 가로로 나열됨 -->
               <div class="row">

                  <%-- 
                    c:forEach = 자바의 for-each 문과 같음
                    var="rv": 반복마다 리뷰 객체 하나가 rv라는 변수에 담김 (타입은 ReviewTO)
                    items="${reviewlist}": 순회할 대상 리스트
                  --%>
                  <c:forEach var="rv" items="${reviewlist}">

                     <!-- md(중간 화면) 이상에서는 폭의 절반(6/12)을 차지 → 2열 배치 -->
                     <div class="col-md-6">

                        <%-- 
                          data-id="${rv.rvNumid}": 이 카드가 몇 번 리뷰인지 HTML data속성에 저장
                          JS가 이 값을 읽어서 수정/삭제 대상을 구분함
                        --%>
                        <div class="review-card" data-id="${rv.rvNumid}">

                           <div class="d-flex justify-content-between align-items-start">
                              <%-- 
                                &ldquo; &rdquo;: 여는/닫는 물결 따옴표(HTML 엔티티)
                                <c:out value="${rv.rvTitle}" />: rv.getRvTitle() 값을 출력.
                                <c:out>은 <, >, & 같은 특수문자를 이스케이프해서 출력하므로
                                리뷰 제목에 악성 스크립트가 들어있어도 안전하게 텍스트로만 보여줌 (XSS 방지)
                              --%>
                              <p class="review-title mb-2">&ldquo;<c:out
                                    value="${rv.rvTitle}" />&rdquo;</p>

                              <div class="review-actions">
                                 <%-- 수정 버튼. data-id에 리뷰 번호 저장. 클릭 이벤트는 JS에서 처리 --%>
                                 <button type="button"
                                    class="btn btn-sm btn-outline-secondary btn-edit"
                                    data-id="${rv.rvNumid}">
                                    <i class="bi bi-pencil"></i>
                                 </button>
                                 <%-- 삭제 버튼. 마찬가지로 data-id 저장 --%>
                                 <button type="button"
                                    class="btn btn-sm btn-outline-danger btn-delete"
                                    data-id="${rv.rvNumid}">
                                    <i class="bi bi-trash3"></i>
                                 </button>
                              </div>
                           </div>

                           <!-- 리뷰 본문 출력 -->
                           <p class="review-content">
                              <c:out value="${rv.rvContent}" />
                           </p>

                           <%-- rv.rvImg가 비어있지 않을 때만(사진이 등록된 경우만) 이 블록 실행 --%>
                           <c:if test="${not empty rv.rvImg}">
                              <div class="review-photos">
                                 <img src="${rv.rvImg}" class="review-photo"
                                    alt="review photo">
                              </div>
                           </c:if>

                           <div class="review-meta">
                              <%-- 
                                fn:substring(문자열, 시작, 끝): 닉네임의 0번째~1번째 글자(즉 첫 글자 1개)만 잘라냄
                                예: "주형킴" → "주" 만 추출되어 아바타 원 안에 표시됨
                              --%>
                              <span class="review-avatar"><c:out
                                    value="${fn:substring(rv.rvNickid, 0, 1)}" /></span>
                              <!-- 닉네임 전체 출력 -->
                              <span class="review-nick"><c:out value="${rv.rvNickid}" /></span>

                              <%-- 산 이름이 있을 때만 뱃지로 표시 (join 안 된 경우 mtName이 비어있을 수 있어서 방어) --%>
                              <c:if test="${not empty rv.mtName}">
                                 <span class="badge mt-badge ms-auto"><i
                                    class="bi bi-geo-alt-fill me-1"></i><c:out
                                       value="${rv.mtName}" /></span>
                              </c:if>
                           </div>
                        </div> <!-- .review-card 끝 -->
                     </div> <!-- .col-md-6 끝 -->
                  </c:forEach> <!-- 반복 끝 -->
               </div> <!-- .row 끝 -->
            </c:otherwise>
         </c:choose>
      </div> <!-- #reviewBody 끝 -->
   </div> <!-- .container 끝 -->

   <%-- 
     jsp:include: 이 위치에 reviewForm.jsp 파일의 내용을 통째로 끌어와서 끼워넣음.
     reviewForm.jsp는 <html><body> 없는 조각 파일이라, review.jsp와 합쳐져서 하나의 완전한 페이지가 됨.
     여기에 등록/수정 모달(#reviewModal)이 들어있음
   --%>
   <jsp:include page="reviewForm.jsp" />

   <!-- jQuery 라이브러리: $(...) 문법을 쓰기 위해 필요 -->
   <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
   <!-- Bootstrap의 JS 기능(모달 열고 닫기 등)을 쓰기 위한 번들 -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

   <script>
      // $(function(){...}): 페이지의 모든 HTML이 다 로드된 다음에 안의 코드를 실행하라는 뜻
      // (요소를 찾기 전에 요소가 먼저 존재해야 하므로 필수)
      $(function() {

         // reviewForm.jsp 안에 있는 모달 div(#reviewModal)를 찾아서 JS 변수에 저장
         var reviewModalEl = document.getElementById('reviewModal');
         // Bootstrap의 Modal 객체로 감싸서, .show()/.hide() 같은 메서드를 쓸 수 있게 만듦
         var reviewModal = new bootstrap.Modal(reviewModalEl);

         // 폼을 "등록 모드"(빈 값)로 초기화하는 함수
         function resetForm() {
            $('#reviewForm')[0].reset();   // 폼 안의 모든 input을 비움 (기본 HTML reset 기능)
            $('#rvNumid').val('');         // hidden 필드도 확실히 빈 값으로 (reset이 안 먹는 경우 대비)
            $('#rvImg').val('');
            $('#imgPreview').addClass('d-none');
            $('#reviewModalLabel').text('리뷰 작성'); // 모달 제목을 "리뷰 작성"으로 되돌림
         }

         // "리뷰 작성하기" 버튼 클릭 시 실행되는 이벤트
         $('#btnWrite').on('click', function() {
            resetForm();       // 폼을 비우고 (혹시 이전에 수정하다 남은 값 제거)
            reviewModal.show(); // 모달을 화면에 띄움
         });

         // 수정(연필) 버튼 클릭 이벤트.
         // $(document).on('click', '.btn-edit', ...) = 이벤트 위임 방식.
         // 카드들이 서버에서 미리 그려져 있으므로 직접 바인딩해도 되지만,
         // 이 방식을 쓰면 나중에 카드가 동적으로 추가/제거돼도 항상 동작함
         $(document).on('click', '.btn-edit', function() {
            // $(this): 클릭된 그 버튼 자신. data('id')로 버튼에 저장된 data-id 값(리뷰 번호)을 읽음
            var rvNumid = $(this).data('id');

            // 서버에 이 리뷰의 상세 정보를 요청 (GET 방식)
            $.ajax({
               url : 'reviewone.do',       // 요청 보낼 컨트롤러 주소
               type : 'GET',
               data : { rvNumid : rvNumid }, // ?rvNumid=값 형태로 전달됨
               dataType : 'json',           // 응답을 JSON으로 해석하겠다는 뜻
               success : function(data) {   // 요청 성공 시 실행되는 콜백. data = 서버가 준 JSON 객체
                  // 서버가 준 값들을 각 입력창에 채워넣음
                  $('#rvNumid').val(data.rvNumid);
                  $('#rvTitle').val(data.rvTitle);
                  $('#rvContent').val(data.rvContent);
                  $('#rvNickid').val(data.rvNickid);
                  $('#rvImg').val(data.rvImg);
                  if (data.rvImg) {
                	  $('#imgPreivw').attr('src', data.rvImg).removeClass('d-none');
                  }
                  $('#mtId').val(data.mtId);
                  $('#rvPwd').val('');  // 비밀번호는 서버가 안 보내주므로 항상 빈 값 (수정 시 다시 입력해야 함)
                  $('#reviewModalLabel').text('리뷰 수정'); // 모달 제목을 "리뷰 수정"으로 바꿈
                  reviewModal.show();   // 값 다 채운 다음 모달 오픈
               },
               error : function() {     // 요청 실패 시(네트워크 오류, 서버 에러 등)
                  alert('리뷰 정보를 불러오지 못했습니다.');
               }
            });
         });

         // 삭제(휴지통) 버튼 클릭 이벤트
         $(document).on('click', '.btn-delete', function() {
            var rvNumid = $(this).data('id'); // 클릭된 버튼의 리뷰 번호

            // 브라우저 기본 확인창. 취소 누르면 false 반환되어 함수 종료
            if (!confirm('정말 삭제하시겠습니까?')) {
               return; // 여기서 함수 실행을 멈추고 빠져나감 (아래 ajax 실행 안 됨)
            }

            // 확인을 눌렀을 때만 서버에 삭제 요청
            $.ajax({
               url : 'delete.do',
               type : 'POST',                // 삭제는 POST로 (서버 상태를 바꾸는 요청이므로)
               data : { rvNumid : rvNumid },
               dataType : 'json',
               success : function(res) {      // res = 서버가 돌려준 {"result": 숫자} 객체
                  if (res.result == 1) {      // 1이면 삭제 성공 (executeUpdate가 영향받은 행 수 반환)
                     location.reload();       // 페이지를 새로고침해서 최신 목록을 다시 불러옴
                  } else {
                     alert('삭제에 실패했습니다.'); // 0이면 비번 틀림/대상 없음 등으로 실패
                  }
               },
               error : function() {
                  alert('삭제 요청 중 오류가 발생했습니다.');
               }
            });
         });

         // "저장" 버튼 클릭 이벤트 (등록/수정 공용)
         $('#btnSave').on('click', function() {

            // 폼의 각 입력값을 변수에 담음. .trim()으로 앞뒤 공백 제거
            var rvTitle = $('#rvTitle').val().trim();
            var rvContent = $('#rvContent').val().trim();
            var rvNickid = $('#rvNickid').val().trim();
            var rvPwd = $('#rvPwd').val();       // 비밀번호는 공백 트림 안 함(비번에 공백이 의미 있을 수 있어서)
            var mtId = $('#mtId').val();

            // 필수값이 하나라도 비어있으면(!값 → true) 저장 중단
            // (HTML5 required 속성도 걸려있지만, JS로 한 번 더 이중 체크)
            if (!rvTitle || !rvContent || !rvNickid || !rvPwd || !mtId) {
               alert('필수 항목을 모두 입력해주세요.');
               return;
            }

            var rvNumid = $('#rvNumid').val();
            // hidden 필드에 값이 있으면(빈 문자열이 아니면) 수정 모드로 판단
            var isEdit = rvNumid !== '';
            // 삼항연산자: isEdit이 true면 'edit.do', 아니면 'insert.do'로 보낼 주소 결정
            var url = isEdit ? 'edit.do' : 'insert.do';

            // 서버로 보낼 데이터를 객체로 구성
            var formData = {
               rvTitle : rvTitle,
               rvContent : rvContent,
               rvNickid : rvNickid,
               rvPwd : rvPwd,
               rvImg : $('#rvImg').val().trim(),
               mtId : mtId
            };

            // 수정 모드일 때만 rvNumid를 같이 보냄 (등록은 rvNumid가 아직 없으므로 안 보냄)
            if (isEdit) {
               formData.rvNumid = rvNumid;
            }

            // 실제 서버로 등록/수정 요청 전송
            $.ajax({
               url : url,          // 위에서 결정한 insert.do 또는 edit.do
               type : 'POST',
               data : formData,
               dataType : 'json',
               success : function(res) {
                  if (res.result == 1) {      // 저장 성공
                     reviewModal.hide();       // 모달 닫기
                     location.reload();        // 페이지 새로고침해서 방금 저장한 내용 반영
                  } else {
                     alert('저장에 실패했습니다.'); // 실패(DB 에러, FK 위반 등)
                  }
               },
               error : function() {
                  alert('저장 요청 중 오류가 발생했습니다.');
               }
            });
         });

         // 모달이 닫힐 때마다(취소 버튼, X버튼, 배경 클릭 등 모든 닫힘 상황 포함)
         // 자동으로 resetForm()을 호출해서 폼을 깨끗이 비움.
         // 이렇게 안 하면, 수정하다 취소하고 "작성하기"를 눌렀을 때 이전 값이 남아있는 버그가 생김
         reviewModalEl.addEventListener('hidden.bs.modal', resetForm);

      });
   </script>
</body>
</html>