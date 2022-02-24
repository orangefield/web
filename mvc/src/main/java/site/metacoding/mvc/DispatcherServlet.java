package site.metacoding.mvc;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import site.metacoding.mvc.config.DBConn;
import site.metacoding.mvc.web.MyUserController;

// http://localhost:8000/
// http://localhost:8000/hello 도 낚아챌거임
// http://localhost:8000/myuser -> MyUserController로
// http://localhost:8000/mypost -> MyPostController로 보낼거임(이건 안 만들겨)
@WebServlet("/") // 포트 다음 /가 붙은 모든 요청을 다 낚아챈다
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		DBConn.getConnection(); 테스트 끝나서 지웠음
		String domain = request.getRequestURI();
		System.out.println("domain : " + domain);

		if (domain.equals("/myuser")) {
			MyUserController controller = new MyUserController(request, response);

			String idStr = request.getParameter("id"); // null

			if (idStr == null) {
				controller.getAll();
			} else {
				int id = Integer.parseInt(idStr);
				controller.getOne(id);
			}
		}
	} // Dispatcher 스레드가 종료(1. 클라에게 연결된 response 선 짤림, 2. request 메모리 영역 삭제, DB connection 반납)

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	} // Dispatcher 스레드가 종료

}
