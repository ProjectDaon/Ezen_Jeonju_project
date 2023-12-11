<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/navbar.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
</head>
<body>
<script src="./js/nav-bar.js"></script>
<header class="navigation" id="navigation">
	<nav class="nav-bar" style="height: 82px;">
		<h1>
			<a href="index.jsp">
				<img src="./images/logo.png">
			</a>
		</h1>
		<div class="menu-wrap">
			<ul class="menu-element">
				<li class="dep">
					<a href="#">전주에가면</a>
					<div class="dep-inner" style="display: none;">
						<div class="inner-sub-title">
							<p class="large-text">전주에가면</p>
						</div>
						<ul class="depth-2">
							<li><a href="#">명소</a></li>
							<li><a href="#">음식</a></li>
							<li><a href="#">영상</a></li>
						</ul>
					</div>
				</li>
				<li class="dep">
					<a href="#">여행일정</a>
					<div class="dep-inner" style="display: none;">
						<div class="inner-sub-title">
							<p class="large-text">여행일정</p>
						</div>
						<ul class="depth-2">
							<li><a href="#">여행공유</a></li>
						</ul>
					</div>
				</li>
				<li class="dep">
					<a href="#">공지사항</a>
					<div class="dep-inner" style="display: none;">
						<div class="inner-sub-title">
							<p class="large-text">공지사항</p>
						</div>
						<ul class="depth-2">
							<li><a href="#">공지</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		<div class="my-menu-element">
			<div class="login-element">
				<%if(session.getAttribute("midx")==null){%>
				<a class="login" href="<%=request.getContextPath()%>/member/memberLogin.do">로그인</a>
				<%} else{ %>
				<a href="<%=request.getContextPath()%>/member/memberLogout.do">로그아웃</a>
				<%} %>
				<a href="#">마이페이지</a>
			</div>
		</div>
	</nav>
	
</header>


<br><br><br>
<br><br><br>
<br><br><br>
<a href="<%=request.getContextPath()%>/notice/noticeWrite.do">글쓰기</a>
<a href="<%=request.getContextPath()%>/notice/noticeList.do">글목록</a>
<a href="<%=request.getContextPath()%>/notice/noticeList.do">글목록</a>
</body>
</html>