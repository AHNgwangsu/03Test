<%@page import="mvjsp.jdbc.connection.ConnectionProvider"%>
<%@page import="mvjsp.board.model.Board"%>
<%@page import="mvjsp.board.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = ConnectionProvider.getConnection();
    // 지정된 글 번호 얻기
    int num = Integer.parseInt(request.getParameter("num"));   

    // 게시글 데이터를 담을 변수 정의
    String writer  = "";
    String title   = "";
    String content = "";
    String regtime = "";
    int    hits    = 0;
    

    String memberId = (String)session.getAttribute("MEMBERID");
    if (memberId == null) {
        response.sendRedirect("sessionLoginForm.jsp");
    }
    BoardDao dao = BoardDao.getInstance();
    Board board = dao.selectOne(conn, num, true);

    // 글 데이터를 변수에 저장
    writer  = board.getWriter();
    title   = board.getTitle();
    content = board.getContent();
    regtime = board.getRegtime();
    hits    = board.getHits();
	
    // 글 제목과 내용이 웹 페이지에 올바르게 출력되도록 
    // 공백과 줄 바꿈 처리
    title   = title.replace  (" ", "&nbsp;");
    content = content.replace(" ", "&nbsp;").replace("\n", "<br>");

    // 수정 및 삭제 권한 확인
    boolean hasPermission = writer.equals(memberId);
%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>게시판</title>
   <link rel="icon" href="homepage_home_house_icon_225739.ico" type="image/x-icon">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">게시글</div>
                <div class="card-body">
                    <table class="table">
                        <tr>
                            <th style="width: 20%;">제목</th>
                            <td><%=title%></td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td><%=writer%></td>
                        </tr>
                        <tr>
                            <th>작성일시</th>
                            <td><%=regtime%></td>
                        </tr>
                        <tr>
                            <th>조회수</th>
                            <td><%=hits%></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td><%=content%></td>
                        </tr>

                           
                    </table>
                    <div class="text-center">
                        <a href="blist.jsp" class="btn btn-primary">목록보기</a>
                        
                            <a href="write.jsp?num=<%=num%>" class="btn btn-success">수정</a>
                            <a href="delete.jsp?num=<%=num%>" class="btn btn-danger">삭제</a>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
