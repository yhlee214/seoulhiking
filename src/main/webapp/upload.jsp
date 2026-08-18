<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.UUID" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	//파일이 꺠지지 않게 utf-8설정
	Part part = request.getPart("file");
	String origin =  part.getSubmittedFileName(); // 파일명 설정하는 함수.
	
	String webPath = "";
	
	if (origin != null && !origin.isEmpty()) {
		String ext = origin.substring(origin.lastIndexOf(".")); // 파일 확장자 파악
		String saveName = UUID.randomUUID() + ext; // 파일 생성시 랜덤 UUID + 확장자
		
		String uploadPath = application.getRealPath("/uploads"); //업로드 경로 설정
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
	part.write(uploadPath + File.separator + saveName); //파일 네임
	
	webPath = "uploads/" + saveName; // 웹에게 전달할 경로
	}
	
	%>
<script>
   // iframe 안에서 실행 → parent는 리뷰 페이지
   parent.document.getElementById('rvImg').value = '<%= webPath %>';
   var p = parent.document.getElementById('imgPreview');
   p.src = '<%= webPath %>';
   p.classList.remove('d-none');
</script>
</body>

</html>