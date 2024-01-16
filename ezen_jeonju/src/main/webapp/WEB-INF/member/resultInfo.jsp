<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[EZEN-JEONJU]회원정보 찾기</title>
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet"  href="../css/findInfo.css">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
});
</script>
<div id="headers"></div>
<div class="contents" style="margin-bottom: 10%;">
	<div class="contents_inner">
		<div class="find_id">
			<div class="find_inner">
				<div class="title_wrap">
					<h4>회원님의 아이디를 확인해주세요.</h4>
				</div>
				<div class="resultId">
					<!-- 이메일이 일치하지 않을 때 -->
					<c:choose>
						<c:when test="${idList == '[]'}">
							<ul style="padding:0;">
							<li style="font-size:20px; margin: 10% auto;">일치하는 정보가 존재하지 않습니다.</li>
							</ul>
							<button type="button" class="loginBtn" onclick="location.href='/member/memberJoin.do'">
								<span class="next">회원가입하기</span>
							</button>
						</c:when>
						<c:otherwise>
						<c:forEach items="${idList}" var="idList">
							<ul style="padding:0;">
							<li>${idList.memberId}</li><br/>
							</ul>
						</c:forEach>
						</c:otherwise>
					</c:choose>
					<button type="button" class="loginBtn" onclick="location.href='/member/memberLogin.do'">
						<span class="next">로그인하기</span>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="footers"></div>
</body>
</html>