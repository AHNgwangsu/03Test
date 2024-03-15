<%@page import="javax.servlet.http.Cookie"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String password = request.getParameter("email");

    boolean login = false;
    String sql = "SELECT count(*) FROM member WHERE id = ? AND email = ?";
    Class.forName("oracle.jdbc.driver.OracleDriver");

    try {
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next() && rs.getInt(1) == 1) {
            login = true;
            // 로그인 성공시 세션 쿠키 설정
            HttpSession session1 = request.getSession();
            session.setAttribute("MEMBERID", id);
            // 쿠키 설정 (예: 아이디를 쿠키에 저장)
           Cookie idCookie = new Cookie("userID", id);
            idCookie.setMaxAge(24 * 60 * 60); 
           response.addCookie(idCookie);
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if (login) {
        response.sendRedirect("index.jsp"); // 로그인 성공 후 이동할 페이지
    } else {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter printWriter = response.getWriter();
        out.println("<script>alert('로그인에 실패하였습니다.'); history.go(-1);</script>");
        out.close();
    }
%>
