<%@page import="mvjsp.board.model.Board"%>
<%@page import="mvjsp.board.dao.BoardDao"%>
<%@page import="mvjsp.jdbc.connection.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>  
<%@ page import="java.time.*" %>
<%

%>
 
<%
	Connection conn = ConnectionProvider.getConnection();
    request.setCharacterEncoding("utf-8");

    // 양식에 입력되었던 값 읽기
    String title  = request.getParameter("title" );
    String writer   = request.getParameter("writer"  );
    String content = request.getParameter("content");

    // 빈 칸이 하나라도 있으면 오류 출력하고 종료
    if (title  == null || title.length()  == 0 ||
    	writer   == null || writer.length()   == 0 ||
        content == null || content.length() == 0) {
%>      
        <script>
            alert('모든 항목이 빈칸 없이 입력되어야 합니다.');
            history.back();
        </script>
<%        
        return;
    }


    BoardDao dao = BoardDao.getInstance();
    Board board = new Board(title, writer, content);
    
   
    dao.insert(conn, board);
    // 목록보기 화면으로 돌아감
    response.sendRedirect("blist.jsp");
%>     