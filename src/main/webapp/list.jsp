<%@page import="mvjsp.board.model.Member"%>
<%@page import="mvjsp.board.dao.MemberDao"%>
<%@page import="mvjsp.jdbc.connection.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 세션을 통해 로그인 여부 확인
String memberId = (String)session.getAttribute("MEMBERID");
if(memberId != null) {
    // 로그인 상태일 때만 데이터를 가져와서 전달
    Connection conn = ConnectionProvider.getConnection();
    MemberDao dao = MemberDao.getInstance();
    ArrayList<Member> list = dao.selectAll(conn);
    request.setAttribute("list", list);
    
    // 로그인 상태에서만 목록 페이지로 포워딩
    request.getRequestDispatcher("list_view.jsp").forward(request, response);
} else {
    // 로그인 상태가 아니면 로그인 페이지로 리다이렉트
    response.sendRedirect("sessionLoginForm.jsp");
}
%>
