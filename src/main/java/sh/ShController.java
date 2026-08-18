package sh;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet("*.do")
public class ShController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");  
		// UTF-8을 하는 이유는 인코딩 문제 응답 해오는 것들을 utf-8을 맥여줘야함
		String page = "main.jsp"; // 첫 페이지는 메인.jsp
		String uri = req.getRequestURI(); // 오는 주소들을 uri 담고 
		String requestUri = uri.substring(uri.lastIndexOf("/")); // 마지막 / 이후에 문장을 담을것

	switch (requestUri) { // 들어오는 uri를 선택할 경우 어떻게 진행되는지
	
		// ═══ Ajax 응답 구간 (Controller가 직접 JSON, View 안 거침) ═══
	
		// 등록 — 모달 저장 버튼
		case "/insert.do" : { // 등록 케이스
			ReviewTO rv = makeReview(req); //  함수에 있는 모든 요소들을 가져옴/
			int result = ShDAO.insertReview(rv); // DAO에 있는 SQL의 결과를 result에 저장함
			writeJson(resp, "{\"result\":" + result + "}"); // json 형태로 결과를 내놔줌 이 result는 result가 성공시 sql도 한줄 식 추가되므로 성공일 경우 양수로 나옴
			return;   // ★ forward 타면 JSON 뒤에 HTML 붙어서 파싱 깨짐
		}
		
		// 수정 — 모달 저장 버튼
		case "/edit.do" : {
			ReviewTO rv = makeReview(req); // 똑같이 생성,
			// makeReview는 rvNumid를 안 담음(등록엔 없는 값이라)
			// update는 대상 글번호가 필수 → 모달의 hidden input에서 받아 세팅
			rv.setRvNumid(Integer.parseInt(req.getParameter("rvNumid")));
			//수정할 때 필요한 아이디,비밀번호를 를 먼저 받음
			rv.setRvPwd(req.getParameter("rvPwd"));
			int result = ShDAO.updateReview(rv); // 인서트와 똑같은 형식
			writeJson(resp, "{\"result\":" + result + "}");
			return;
		}
		
		// 삭제
		case "/delete.do" : {
			int rvId = Integer.parseInt(req.getParameter("rvNumid"));
			String rvpw = req.getParameter("rvPwd");
			// 필요한 아이디 비밀번호를 먼저 받고 대조함. 
			int result = ShDAO.deleteReview(rvId, rvpw); // dao함수 실행
			writeJson(resp, "{\"result\":" + result + "}"); // 위와 같은 형식
			return; // 원래 화면으로 돌아감
		}
		
	
		case "/reviewone.do" : { // 수정할때 수정할 값을 받아오기 위해 사용.
			int rvId = Integer.parseInt(req.getParameter("rvNumid"));
			// 수정할때 필요한건 아이디므로 아이디를 먼저 받아줌.
			ReviewTO rv = ShDAO.getReviewById(rvId);
			// 다오에 실행된 값들을 rv 변수상자의 저장,
			
			// rvPwd는 화면에 내려보내지 않음
			String json = "{" // json은 서버와 브라우저가 뷰를 통하고 싶지 아니할때 쓰는 형태 이떄 받아온 값을 바로 저장하기 위해 사용
					+ "\"rvNumid\":"  + rv.getRvNumid() + ","
					+ "\"rvTitle\":\""   + esc(rv.getRvTitle())   + "\","
					+ "\"rvContent\":\"" + esc(rv.getRvContent()) + "\","
					+ "\"rvNickid\":\""  + esc(rv.getRvNickid())  + "\","
					+ "\"rvImg\":\""     + esc(rv.getRvImg())     + "\","
					+ "\"mtId\":"     + rv.getMtId()
					+ "}";
			writeJson(resp, json); // json에 저장
			return; // 원래 홈페이지로 돌아옴
		}
		
		
		// ═══ View(JSP) 거치는 구간 ═══
		
		// 리뷰 목록 — 페이지 전체 (모달 마크업도 이 JSP 안에 포함)
		case "/reviewlist.do" : {
		    List<ReviewTO> list = ShDAO.getReviewList();
		    req.setAttribute("reviewlist", list);

		    // 모달 안 산 선택 <select> 채우기용
		    List<MountainTO> mtList = ShDAO.getMountainList(req.getParameter("lang"));
		    req.setAttribute("mtList", mtList);

		    page = "review.jsp";
		    break;
		}
		
		// 리뷰 목록 — 표 부분만 (Ajax 요청이지만 응답은 HTML 조각)
		// reviewTable.jsp 에는 <c:forEach>로 <tr>만 반복. html/head/body 없음
		// 저장 성공 후 $('#reviewBody').load('reviewtable.do') 로 갈아끼움
		case "/reviewtable.do" : {
			List<ReviewTO> list = ShDAO.getReviewList();
			req.setAttribute("reviewlist", list);
			page = "reviewTable.jsp";
			break;
		}
		
		// 산 목록
		case "/mtlist.do" : {
			String lang = req.getParameter("lang");
			List<MountainTO> list = ShDAO.getMountainList(lang);
			req.setAttribute("mtList", list);
			page = "mtInfo.jsp";
			break;
		}
	}
	
	RequestDispatcher rd = req.getRequestDispatcher(page);
	rd.forward(req, resp);
	}

	
	// JSON 응답 공통 처리
	private void writeJson(HttpServletResponse resp, String json) throws IOException {
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		out.print(json);
		out.flush();
	}
	
	// 리뷰 내용에 " 나 줄바꿈이 들어가면 JSON 문법이 깨짐 → 이스케이프 처리
	private String esc(String s) {
		if (s == null) return "";
		return s.replace("\\", "\\\\")
		        .replace("\"", "\\\"")
		        .replace("\r", "")
		        .replace("\n", "\\n");
	}
	
	private ReviewTO makeReview(HttpServletRequest req) {
		ReviewTO rv = new ReviewTO();
		rv.setRvTitle(req.getParameter("rvTitle"));
		rv.setRvContent(req.getParameter("rvContent"));
		rv.setRvNickid(req.getParameter("rvNickid"));
		rv.setRvPwd(req.getParameter("rvPwd"));
		rv.setRvImg(req.getParameter("rvImg"));
		rv.setMtId(Integer.parseInt(req.getParameter("mtId")));
		rv.setMtName(req.getParameter("mtName"));
		return rv;
	}
	
}