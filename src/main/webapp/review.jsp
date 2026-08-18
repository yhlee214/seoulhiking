<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등산 리뷰 - 서울하이킹</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
html {
   background: url('images/reviewbgi.jpg') center center / cover no-repeat fixed;
}

body {
   background: linear-gradient(rgba(250, 246, 238, .88), rgba(250, 246, 238, .88));
   color: #2b2b2b;
   font-family: "Noto Sans KR", sans-serif;
   min-height: 100vh;
}

.page-header h2 {
   font-weight: 900;
   letter-spacing: -0.5px;
}

.page-header p {
   color: #9a9184;
   margin-bottom: 0;
}

#btnWrite {
   border-radius: 999px;
   padding: 10px 22px;
   font-weight: 700;
   box-shadow: 0 4px 14px rgba(13, 202, 240, .35);
   border: none;
}

.review-card {
   background: rgba(255, 253, 248, .92);
   border: 1px solid #e5ddc9;
   border-radius: 16px;
   padding: 24px;
   margin-bottom: 24px;
   height: 100%;
   backdrop-filter: blur(6px);
   transition: transform .18s ease, box-shadow .18s ease;
}

.review-card:hover {
   transform: translateY(-4px);
   box-shadow: 0 12px 28px rgba(43, 43, 43, .10);
   border-color: #d8cda9;
}

.review-title {
   font-weight: 700;
   font-size: 1.15rem;
   margin: 0;
   color: #2b2b2b;
   line-height: 1.4;
}

.review-content {
   color: #4a4a4a;
   line-height: 1.65;
   margin-top: 10px;
   white-space: pre-line;
   font-size: .95rem;
}

.review-photos {
   display: flex;
   gap: 8px;
   margin-top: 14px;
}

.review-photo {
   width: 100%;
   max-width: 220px;
   height: 130px;
   object-fit: cover;
   border-radius: 10px;
}

.review-meta {
   display: flex;
   align-items: center;
   gap: 8px;
   color: #7a7a7a;
   font-size: .85rem;
   margin-top: 16px;
   padding-top: 14px;
   border-top: 1px dashed #e5ddc9;
}

.review-avatar {
   width: 28px;
   height: 28px;
   border-radius: 50%;
   background: linear-gradient(135deg, #0dcaf0, #0d8bf0);
   color: #fff;
   display: inline-flex;
   align-items: center;
   justify-content: center;
   font-size: .8rem;
   font-weight: 700;
   flex-shrink: 0;
}

.review-nick {
   font-weight: 600;
   color: #3f3f3f;
}

.mt-badge {
   background: #fff2e0 !important;
   color: #b5651d !important;
   font-weight: 600;
   border-radius: 999px;
   padding: .35em .75em;
}

.review-actions .btn {
   margin-left: 4px;
   border-radius: 999px;
}

.empty-state {
   text-align: center;
   padding: 70px 20px;
   color: #9a9184;
}

.empty-state i {
   font-size: 2.5rem;
   display: block;
   margin-bottom: 12px;
   opacity: .5;
}

/* 모달(작성/수정 폼)*/
.modal-content {
   background: rgba(255, 253, 248, .97);
   color: #2b2b2b;
   border-radius: 16px;
   border: none;
   backdrop-filter: blur(6px);
}

.modal-header {
   border-bottom: 1px solid #eee2c9;
}

.modal-footer {
   border-top: 1px solid #eee2c9;
}

.form-control, .form-select {
   color: #2b2b2b !important;
   background-color: #ffffff !important;
   border-radius: 10px;
}

.form-control::placeholder {
   color: #9a9a9a;
}

#btnSave {
   border-radius: 999px;
   padding: 8px 22px;
   font-weight: 700;
}
</style>
</head>
<body>

   <div class="container py-5">
      <div
         class="page-header d-flex justify-content-between align-items-center mb-4">
         <div>
            <h2>🏔️ Seoul Hiking Review</h2>
            <p>다녀온 산의 생생한 후기를 남겨보세요 ✍️</p>
         </div>
         <button type="button" class="btn btn-info" id="btnWrite">
            <i class="bi bi-pencil-square me-1"></i> 리뷰 작성하기
         </button>
      </div>

      <div id="reviewBody">
         <c:choose>
            <c:when test="${empty reviewlist}">
               <div class="empty-state">
                  <i class="bi bi-chat-square-text"></i>
                  🥾 아직 작성된 리뷰가 없습니다. 첫 리뷰를 남겨보세요!
               </div>
            </c:when>
            <c:otherwise>
               <div class="row">
                  <c:forEach var="rv" items="${reviewlist}">
                     <div class="col-md-6">
                        <div class="review-card" data-id="${rv.rvNumid}">
                           <div class="d-flex justify-content-between align-items-start">
                              <p class="review-title mb-2">&ldquo;<c:out
                                    value="${rv.rvTitle}" />&rdquo;</p>
                              <div class="review-actions">
                                 <button type="button"
                                    class="btn btn-sm btn-outline-secondary btn-edit"
                                    data-id="${rv.rvNumid}">
                                    <i class="bi bi-pencil"></i>
                                 </button>
                                 <button type="button"
                                    class="btn btn-sm btn-outline-danger btn-delete"
                                    data-id="${rv.rvNumid}">
                                    <i class="bi bi-trash3"></i>
                                 </button>
                              </div>
                           </div>

                           <p class="review-content">
                              <c:out value="${rv.rvContent}" />
                           </p>

                           <c:if test="${not empty rv.rvImg}">
                              <div class="review-photos">
                                 <img src="${rv.rvImg}" class="review-photo"
                                    alt="review photo">
                              </div>
                           </c:if>

                           <div class="review-meta">
                              <span class="review-avatar"><c:out
                                    value="${fn:substring(rv.rvNickid, 0, 1)}" /></span>
                              <span class="review-nick"><c:out value="${rv.rvNickid}" /></span>
                              <c:if test="${not empty rv.mtName}">
                                 <span class="badge mt-badge ms-auto"><i
                                    class="bi bi-geo-alt-fill me-1"></i><c:out
                                       value="${rv.mtName}" /></span>
                              </c:if>
                           </div>
                        </div>
                     </div>
                  </c:forEach>
               </div>
            </c:otherwise>
         </c:choose>
      </div>
   </div>

   <jsp:include page="reviewForm.jsp" />

   <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   <script>
      $(function() {

         var reviewModalEl = document.getElementById('reviewModal');
         var reviewModal = new bootstrap.Modal(reviewModalEl);

         function resetForm() {
            $('#reviewForm')[0].reset();
            $('#rvNumid').val('');
            $('#reviewModalLabel').text('리뷰 작성');
         }

         $('#btnWrite').on('click', function() {
            resetForm();
            reviewModal.show();
         });

         $(document).on('click', '.btn-edit', function() {
            var rvNumid = $(this).data('id');

            $.ajax({
               url : 'reviewone.do',
               type : 'GET',
               data : { rvNumid : rvNumid },
               dataType : 'json',
               success : function(data) {
                  $('#rvNumid').val(data.rvNumid);
                  $('#rvTitle').val(data.rvTitle);
                  $('#rvContent').val(data.rvContent);
                  $('#rvNickid').val(data.rvNickid);
                  $('#rvImg').val(data.rvImg);
                  $('#mtId').val(data.mtId);
                  $('#rvPwd').val('');
                  $('#reviewModalLabel').text('리뷰 수정');
                  reviewModal.show();
               },
               error : function() {
                  alert('리뷰 정보를 불러오지 못했습니다.');
               }
            });
         });

         // 삭제(휴지통) 버튼 클릭 이벤트
         // 비밀번호를 prompt로 입력받아서 delete.do에 rvPwd로 같이 전송해야 함
         // (ShDAO.deleteReview가 rv_pwd 일치 조건까지 확인하도록 되어있어서 비번 없이 보내면 항상 실패함)
         $(document).on('click', '.btn-delete', function() {
            var rvNumid = $(this).data('id');
            var pwd = prompt('삭제하려면 비밀번호를 입력하세요:');

            if (pwd === null) {
               return; // 취소 누르면 그냥 종료
            }

            $.ajax({
               url : 'delete.do',
               type : 'POST',
               data : { rvNumid : rvNumid, rvPwd : pwd },
               dataType : 'json',
               success : function(res) {
                  if (res.result == 1) {
                     location.reload();
                  } else {
                     alert('비밀번호가 틀렸거나 삭제에 실패했습니다.');
                  }
               },
               error : function() {
                  alert('삭제 요청 중 오류가 발생했습니다.');
               }
            });
         });

         $('#btnSave').on('click', function() {

            var rvTitle = $('#rvTitle').val().trim();
            var rvContent = $('#rvContent').val().trim();
            var rvNickid = $('#rvNickid').val().trim();
            var rvPwd = $('#rvPwd').val();
            var mtId = $('#mtId').val();

            if (!rvTitle || !rvContent || !rvNickid || !rvPwd || !mtId) {
               alert('필수 항목을 모두 입력해주세요.');
               return;
            }

            var rvNumid = $('#rvNumid').val();
            var isEdit = rvNumid !== '';
            var url = isEdit ? 'edit.do' : 'insert.do';

            var formData = {
               rvTitle : rvTitle,
               rvContent : rvContent,
               rvNickid : rvNickid,
               rvPwd : rvPwd,
               rvImg : $('#rvImg').val().trim(),
               mtId : mtId
            };

            if (isEdit) {
               formData.rvNumid = rvNumid;
            }

            $.ajax({
               url : url,   
               type : 'POST',
               data : formData,
               dataType : 'json',
               success : function(res) {
                  if (res.result == 1) {
                     reviewModal.hide();
                     location.reload();
                  } else {
                     alert('저장에 실패했습니다.');
                  }
               },
               error : function() {
                  alert('저장 요청 중 오류가 발생했습니다.');
               }
            });
         });

         reviewModalEl.addEventListener('hidden.bs.modal', resetForm);

      });
   </script>
</body>
</html>