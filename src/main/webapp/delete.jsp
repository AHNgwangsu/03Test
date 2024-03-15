<%@page import="mvjsp.board.dao.BoardDao"%>
<%@page import="mvjsp.jdbc.connection.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection conn = ConnectionProvider.getConnection();
// 지정된 글 번호 얻기
int num = Integer.parseInt(request.getParameter("num"));

String memberId = (String) session.getAttribute("MEMBERID");
if (memberId == null) {
    response.sendRedirect("sessionLoginForm.jsp");
} else {
	
    BoardDao dao = BoardDao.getInstance();
    // 게시물 작성자 가져오기
    String writer = dao.getBoardWriter(conn, num);
    
    // 현재 로그인한 사용자가 작성한 게시물인지 확인
    if (memberId.equals(writer)) {
        dao.delete(conn, num); // 현재 로그인한 사용자가 작성한 게시물이면 삭제 수행
%>

<script>
    alert('삭제되었습니다.');
    location.href="blist.jsp";
</script>

<%
    } else {
%>

<script>
    alert('본인이 작성한 게시글만 삭제할 수 있습니다.');
    location.href="blist.jsp"; // 삭제할 수 없는 경우 목록 페이지로 이동
</script>

<%
    }
}
%>
