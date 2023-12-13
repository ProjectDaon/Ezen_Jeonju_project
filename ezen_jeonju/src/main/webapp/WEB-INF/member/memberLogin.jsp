<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet"  href="../css/memberLogin.css">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});

function check(){
	var fm = document.frm;
	
	if(fm.memberId.value ==""){
		alert("아이디를 입력하세요");
		fm.memberId.focus();
		return;
	} else if(fm.memberPwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.memberPwd.focus();
		return;
	}
	
	fm.action = "<%=request.getContextPath()%>/member/memberLoginAction.do";
	fm.method = "post";
	fm.submit();
	return;
}

</script>
<div id="headers"></div>
<br><br><br><br><br>
<form name="frm" action="" method="" value="">
	<div id="loginBox">
		<section id="toptitle" class="toptitle">
			<div class="innerwrap">
				<h4 class="tit">Login</h4>
			</div>
		</section>
		<table>
			<tr>
				<th id="loginId">아이디</th>
				<td><input type="text" name="memberId" id="memberId" value="" placeholder="아이디 입력"></td>
			</tr>
			<tr>
				<th id="LoginPassword">비밀번호</th>
				<td><input type="password" name="memberPwd" id="memberPwd" value=""	placeholder="비밀번호 입력" onkeypress="if(event.keyCode == 13){ check(); return;}"></td>
			</tr>
		</table>
		<div>
			<a href="#" id="button" onclick="check();">로그인</a>
		</div>
	</div>
	
	
	</form>
	<a href="<%=request.getContextPath()%>/member/memberJoin.do">회원가입</a><br>


<a id="kakao-login-btn" href="<%=request.getContextPath()%>/member/KakaoMemberLogin.do">
	<img src="../images/kakao_login_medium_narrow.png" width="200" height="50" alt="카카오 로그인 버튼" />
</a>
<br>
<a id="naver-login-btn" href="<%=request.getContextPath()%>/member/naverMemberLogin.do">
	<img src="../images/naver_login.png" width="200" height="50" alt="네이버 로그인 버튼"/>
</a>


</body>
</html>