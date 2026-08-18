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
	
		String page = "main.jsp";
		String uri = req.getRequestURI();
		String requestUri = uri.substring(uri.lastIndexOf("/"));

	switch (requestUri) {
	
		// ═══ Ajax 응답 구간 (Controller가 직접 JSON, View 안 거침) ═══
	
		// 등록 — 모달 저장 버튼
		case "/insert.do" : {
			ReviewTO rv = makeReview(req);
			int result = ShDAO.insertReview(rv);
			writeJson(resp, "{\"result\":" + result + "}");
			return;   // ★ forward 타면 JSON 뒤에 HTML 붙어서 파싱 깨짐
		}
		
		// 수정 — 모달 저장 버튼
		case "/edit.do" : {
			ReviewTO rv = makeReview(req);
			// makeReview는 rvNumid를 안 담음(등록엔 없는 값이라)
			// update는 대상 글번호가 필수 → 모달의 hidden input에서 받아 세팅
			rv.setRvNumid(Integer.parseInt(req.getParameter("rvNumid")));
			rv.setRvPwd(req.getParameter("rvPwd"));
			int result = ShDAO.updateReview(rv);
			writeJson(resp, "{\"result\":" + result + "}");
			return;
		}
		
		// 삭제
		case "/delete.do" : {
			int rvId = Integer.parseInt(req.getParameter("rvNumid"));
			String rvpw = req.getParameter("rvPwd");
			int result = ShDAO.deleteReview(rvId, rvpw);
			writeJson(resp, "{\"result\":" + result + "}");
			return;
		}
		
		// 한 건 조회 — 수정 모달 열기 전 기존 값 받아가는 용도
		// jQuery가 이 값을 $('#rvTitle').val(data.rvTitle) 로 채운 뒤 modal('show')
		case "/reviewone.do" : {
			int rvId = Integer.parseInt(req.getParameter("rvNumid"));
			ReviewTO rv = ShDAO.getReviewById(rvId);
			
			// rvPwd는 화면에 내려보내지 않음
			String json = "{"
					+ "\"rvNumid\":"  + rv.getRvNumid() + ","
					+ "\"rvTitle\":\""   + esc(rv.getRvTitle())   + "\","
					+ "\"rvContent\":\"" + esc(rv.getRvContent()) + "\","
					+ "\"rvNickid\":\""  + esc(rv.getRvNickid())  + "\","
					+ "\"rvImg\":\""     + esc(rv.getRvImg())     + "\","
					+ "\"mtId\":"     + rv.getMtId()
					+ "}";
			writeJson(resp, json);
			return;
		}
		
		
		// ═══ View(JSP) 거치는 구간 ═══
		
		// 리뷰 목록 — 페이지 전체 (모달 마크업도 이 JSP 안에 포함)
		case "/review.do" : {
		    List<ReviewTO> list = ShDAO.getReviewList();
		    req.setAttribute("reviewlist", list);
		    
		    String lang = "eng";
		    
		    // 모달 안 산 선택 <select> 채우기용
		    List<MountainTO> mtList = ShDAO.getMountainList(lang);
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
		case "/main.do" : {
			String lang = req.getParameter("lang");
			if (lang == null) {
				lang = "eng";
			}
			
			List<MountainTO> list = ShDAO.getMountainList(lang);
			req.setAttribute("mtList", list);
			page ="main.jsp";
			break;
		}
		
		
		// 산 목록
		case "/mtInfo.do" : {
			String lang = req.getParameter("lang");
		    if (lang == null) {
		        lang = "eng";
		    }
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