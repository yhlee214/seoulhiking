package sh;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("*/do")
public class ShController extends HttpServlet {
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = "menu.jsp";
		String uri = req.getRequestURI(); //http://localhost:8080/empapp/list.do
		String requestUri = uri.substring(uri.lastIndexOf("/"), uri.length());

	switch (requestUri) {
		case "/insert.do" : {
			Review rv = makeReview(req);
		}
		case "/edit.do" : {
			Review rv = makeReview(req);
		}
		
		case "/delete.do" : {
			Review rv = makeReview(req);
		}
		
		case "/reviewlist.do " : {
			Review rv = makeReview(req);
			
		}
		
		case "/mtlist.do" : {
			MountainTO mt = makeMountain(req);
		}
	}
	}

	private Review makeReview(HttpServletRequest req) {
		Review rv = new Review();
		rv.setRvNumid(Integer.parseInt(req.getParameter("rvNumid")));
		rv.setRvTitle(req.getParameter("rvContent"));
		rv.setRvNickid(req.getParameter("rvNickid"));
		rv.setRvPwd(req.getParameter("rvPwd"));
		rv.setRvImg(req.getParameter("rvImg"));
		rv.setMtId(Integer.parseInt(req.getParameter("mtId")));
		return rv;

	}
	
	private MountainTO makeMountain(HttpServletRequest req) {
		MountainTO mt =  new MountainTO();
		mt.setMtId(Integer.parseInt(req.getParameter("mtId")));
		mt.setMtName(req.getParameter("mtName"));
		mt.setMtLocation(req.getParameter("mtLocation"));
		mt.setMtHeight(Integer.parseInt(req.getParameter("mtHeight")));
		mt.setMtTrail(req.getParameter("mtTrail"));
		
		return mt;

	}
}
