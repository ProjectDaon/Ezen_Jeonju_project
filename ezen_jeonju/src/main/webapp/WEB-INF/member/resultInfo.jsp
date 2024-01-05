<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<div class="contents">
	<form name="frm" action="${contextPath}/member/findId.do" method="" value="">
		<div class="inner">
			<div class="find_id">
				<div class="find_inner">
					<div class="title_wrap">
						<h4>회원님의 아이디를 확인해주세요.</h4>
					</div>
					<div class="resultId">
					<ul>
						<!-- 이메일이 일치하지 않을 때 -->
						<c:choose>
							<c:when test="${idList == '[]'}">
								<li>일치하는 정보가 존재하지 않습니다.</li>
							</c:when>
							<c:otherwise>
							<c:forEach items="${idList}" var="idList">
								<li>${idList.memberId}</li><br/>
							</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
					<button type="button" onclick="location.href='/member/memberLogin.do'">
						<span class="next">로그인하기</span>
					</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<div id="footers"></div>
</body>
</html>