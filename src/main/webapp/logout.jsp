<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션 객체 가져오기
    HttpSession session2 = request.getSession();
    
    // 세션 무효화 (로그아웃)
    session.invalidate();
    
    // 로그아웃 후 메인 페이지 또는 로그인 페이지 등으로 이동
    response.sendRedirect("index.jsp"); // 예시로 index.jsp로 이동하도록 설정
%>
