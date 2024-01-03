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

<form name="frm" action="" method="" value="">
	<div class="loginBox" id="loginBox">
		<div>
		<section id="toptitle" class="toptitle">
			<div class="innerwrap">
				<h4 class="tit">Login</h4>
			</div>
		</section>
		<table class="loginInput">
			<tr>
				<th id="loginId">ID</th>
			</tr>
			<tr>
				<td><input type="text" name="memberId" id="memberId" value="" placeholder="아이디 입력"></td>
			</tr>
			<tr>
			<td height="10px"></td>
			</tr>
			<tr>
				<th id="LoginPassword">Password</th>
			</tr>
			<tr>
				<td><input type="password" name="memberPwd" id="memberPwd" value=""	placeholder="비밀번호 입력" onkeypress="if(event.keyCode == 13){ check(); return;}"></td>
			</tr>
			<tr>
				<td style="text-align: center">
					<div style="margin-top:20px;">
						<button type="button" class="loginbtn" onclick="check();"><span>로그인</span></button>
					</div>
				</td>
			</tr>
		</table>
		<div class="signup">
			<a href="<%=request.getContextPath()%>/member/memberJoin.do">회원가입</a><br>
		</div>
		</div>

		<div class="seperator">
			<h4>Social login</h4>
			<div class="socialLogin">
				<div class="socialList">
				<a id="kakao-login-btn" href="<%=request.getContextPath()%>/member/KakaoMemberLogin.do">
					<img src="../images/kakao_login_medium_narrow.png" width="220" height="50" alt="카카오 로그인 버튼" />
				</a><br>
				<a id="naver-login-btn" href="<%=request.getContextPath()%>/member/naverMemberLogin.do">
					<img src="../images/naver_login.png" width="220" height="50" alt="네이버 로그인 버튼"/>
				</a><br>
				<a id="google-login-btn" href="<%=request.getContextPath()%>/member/googleMemberLogin.do">
					<img src="../images/google-login.png" width="220" height="50" alt="구글 로그인 버튼"/>
				</a>
				</div>
			</div>
		</div>
		
	</div>
</form>

	
</body>
</html>