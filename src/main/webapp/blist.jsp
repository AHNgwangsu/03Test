<%@page import="mvjsp.board.model.Board"%>
<%@page import="mvjsp.board.dao.BoardDao"%>
<%@page import="mvjsp.jdbc.connection.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%
Connection conn = ConnectionProvider.getConnection();
String memberId = (String) session.getAttribute("MEMBERID");
if (memberId == null) {
	response.sendRedirect("sessionLoginForm.jsp");
}
BoardDao dao = BoardDao.getInstance();
List<Board> list = dao.selectList(conn);
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
 <link rel="icon" href="homepage_home_house_icon_225739.ico" type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.jsp">홈 화면</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="list.jsp">회원정보</a></li>
				</ul>

				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
	<div class="container" style="padding-top: 50px;">
		<table class="table table-bordered table-hover">
			<tr>
				<th class="num">번호</th>
				<th class="title">제목</th>
				<th class="writer">작성자</th>
				<th class="regtime">작성일시</th>
				<th class = "hits">조회수</th>
			</tr>
			<%
			for (Board board : list) {
			%>
			<tr>
				<td><%=board.getNum()%></td>
				<td style="text-align: left;"><a
					href="view.jsp?num=<%=board.getNum()%>"> <%=board.getTitle()%>
				</a></td>
				<td><%=board.getWriter()%></td>
				<td><%=board.getRegtime()%></td>
				<td><%=board.getHits()%></td>
			</tr>
			<%
			}
			%>
		</table>

		<br> <input type="button" value="글쓰기" class="btn btn-primary"
			onclick="location.href='write.jsp'"> 

	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
</body>
</html>