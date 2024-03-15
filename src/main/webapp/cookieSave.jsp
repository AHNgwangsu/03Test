<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String email = request.getParameter("email");
String ck = request.getParameter("ck");

//쿠키생성
if (ck != null && ck.equals("on")) {
	//System.out.println(email);
	
	//쿠키생성 필수 3줄
	Cookie cookie = new Cookie("email", email); //email로 Form에 넘기기
	cookie.setMaxAge(60); //쿠키의 생명주기
	response.addCookie(cookie); // 쿠키 저장 
	
//쿠키삭제
}else {
	Cookie cookie = new Cookie ("email", null);
	cookie.setMaxAge(0); 
	response.addCookie(cookie);
}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>