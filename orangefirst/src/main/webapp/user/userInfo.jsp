<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="/user/login.html">로그인 홈페이지</a></li>
		<li><a href="/user/join.html">회원가입 홈페이지</a></li>
		<li><a href="/user/userInfo.jsp">회원정보 홈페이지</a></li>
		<li><a href="/post/list.html">글목록 홈페이지</a></li>
	</ul>

	<%
	// 1. DB에 테이블 생성(끝)
	// 2. 쿼리스트링 파싱(끝)
	int id = Integer.parseInt(request.getParameter("id"));
	System.out.println("id: " + id);
	String name = null;
	String phone = null;

	try {
		// 3. DB 연결(끝)
		Class.forName("oracle.jdbc.driver.OracleDriver"); // 라이브러리 path 잡기
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SCOTT", "TIGER");
		System.out.println("DB 연결 완료");

		// 4. SELECT로 id, name, phone 받기
		String sql = "SELECT id, name, phone FROM userInfo WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);

		ResultSet rs = pstmt.executeQuery();
		
		// rs.next()를 타지 않을 수도 있기 때문에 변수 초기화 해주기
		// String name = null; 
		// String phone = null;
		
		while (rs.next()) {
			name = rs.getString("name");
			phone = rs.getString("phone");
		}
	} catch (Exception e) {
		System.out.println("오류:" + e.getMessage());
	}
	%>

	<h1>회원정보 페이지입니다.</h1>
	<h3>
		아이디 : <%= id%>
		이름 : <%= name%>
		전화번호 : <%= phone%>
	</h3>
	<hr />
</body>
</html>