<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/userMypage.css">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
</head>
<body>
<script>
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>

<div class="mypage">
	<div class="mypage-head">
		<div class="head-title">마이페이지</div>
		<a href="<%=request.getContextPath()%>/mypage/personalInfo.do">개인정보</a>
	</div>
	<div class="mypage-contents">
		<strong>${sessionScope.memberName}</strong>님의 전주여행
	</div>
	<div class="mypage-tabmenu">
		<ul class="tabStyle" id="tab">
			<li class="on">나의 여행일정</li>
			<li>나의 리뷰</li>
			<li>나의 좋아요</li>
		</ul>
	</div>
</div>
</body>
</html>