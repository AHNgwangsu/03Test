<%@page import="mvjsp.board.model.Member"%>
<%@page import="mvjsp.board.dao.MemberDao"%>
<%@page import="mvjsp.jdbc.connection.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
// 세션에서 사용자 아이디를 가져옴
String memberId = (String) session.getAttribute("MEMBERID");

// 로그인되어 있지 않은 경우 로그인 페이지로 이동
if (memberId == null) {
    response.sendRedirect("login.jsp"); // 예시로 login.jsp로 이동
    return;
}

// 게시물 작성자와 현재 로그인된 사용자의 아이디를 비교하여 접근 권한 확인
String mno = request.getParameter("memberno");
Connection conn = ConnectionProvider.getConnection();
MemberDao dao = MemberDao.getInstance(); 
Member member = dao.select(conn, Integer.parseInt(mno));

if (!member.getId().equals(memberId)) {
    // 게시물 작성자와 현재 로그인된 사용자의 아이디가 다른 경우 접근 거부
    // 경고창을 띄움
    out.println("<script>alert('본인만 수정할 수 있습니다.'); history.back();</script>");
    return; 	   
} 
	
// 접근이 허용된 경우 수정 페이지로 이동
request.setAttribute("member", member);
%>
<jsp:forward page="updateForm_view.jsp"/>
