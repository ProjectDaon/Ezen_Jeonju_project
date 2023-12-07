<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
메인
<%if(session.getAttribute("midx")==null){%>
<a href="<%=request.getContextPath()%>/member/memberLogin.do">로그인</a>
<%} else{ %>
<a href="<%=request.getContextPath()%>/member/memberLogout.do">로그아웃</a>
<%} %>
<a href="<%=request.getContextPath()%>/member/memberJoin.do">회원가입</a>
</body>
</html>