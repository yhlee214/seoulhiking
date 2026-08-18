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
	Part part = request.getPart("file");
	String origin = part.getSubmittedFileName();

	String webPath = "";

	if (origin != null && !origin.isEmpty()) {
		String ext = origin.substring(origin.lastIndexOf("."));
		String saveName = UUID.randomUUID() + ext;

		String uploadPath = application.getRealPath("/uploads");
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
	part.write(uploadPath + File.separator + saveName);

	webPath = "uploads/" + saveName;
	}

	%>
<script>
   parent.document.getElementById('rvImg').value = '<%= webPath %>';
   let p = parent.document.getElementById('imgPreview');
   p.src = '<%= webPath %>';
   p.classList.remove('d-none');
</script>
</body>

</html>