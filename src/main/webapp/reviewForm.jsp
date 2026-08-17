<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<div class="modal fade" id="reviewModal" tabindex="-1"
	aria-labelledby="reviewModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body">
				<form id="reviewForm">
					<input type="hidden" name="rvNumid" id="rvNumid">

					<div class="mb-3">
						<label class="form-label" for="rvTitle">제목</label> <input
							type="text" class="form-control" name="rvTitle" id="rvTitle"
							maxlength="100" required>
					</div>

					<div class="mb-3">
						<label class="form-label" for="rvContent">내용</label>
						<textarea class="form-control" name="rvContent" id="rvContent"
							rows="4" required></textarea>
					</div>

					<div class="mb-3">
						<label class="form-label" for="rvNickid">닉네임</label> <input
							type="text" class="form-control" name="rvNickid" id="rvNickid"
							maxlength="10" required>
					</div>

					<div class="mb-3">
						<label class="form-label" for="rvPwd">비밀번호</label> <input
							type="password" class="form-control" name="rvPwd" id="rvPwd"
							maxlength="10" required>
						<div class="form-text">수정 시에도 다시 입력해야 합니다..</div>
					</div>

					<div class="mb-3">
						<label class="form-label" for="rvImg">사진 URL</label> <input
							type="text" class="form-control" name="rvImg" id="rvImg"
							placeholder="images/review1.jpg">
					</div>

					<div class="mb-3">
						<label class="form-label" for="mtId">산 선택</label>
						<select class="form-select" name="mtId" id="mtId" required>
							<option value="">선택하세요</option>
							<c:forEach var="mt" items="${mtList}">
								<option value="${mt.mtId}"><c:out value="${mt.mtName}" /></option>
							</c:forEach>
						</select>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-info" id="btnSave">저장</button>
			</div>
		</div>
	</div>
</div>