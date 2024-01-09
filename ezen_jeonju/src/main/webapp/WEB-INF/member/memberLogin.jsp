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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
});

$(document).ready( function() {
	$('#memberId').on('input', function() {
		if($('#memberId').val() == '') {
			$('.resetBtn1').css({'display':'none'});
		}else {
			$('.resetBtn1').css({'display':'inline-block'});
		}
	});
})
$(document).ready( function() {
	$('#memberPwd').on('input', function() {
		if($('#memberPwd').val() == '') {
			$('.resetBtn2').css({'display':'none'});
		}else {
			$('.resetBtn2').css({'display':'inline-block'});
		}
	});
})

function disappear1() {
	document.getElementById("memberId").value = '';
	$('.resetBtn1').css({'display':'none'});
}

function disappear2() {
	document.getElementById("memberPwd").value = '';
	$('.resetBtn2').css({'display':'none'});
}

function check(){
	var fm = document.frm;
	
	if(fm.memberId.value ==""){
		alert("아이디를 입력하세요.");
		fm.memberId.focus();
		return;
	} else if(fm.memberPwd.value ==""){
		alert("비밀번호를 입력하세요.");
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
<div class="contents">
	<form name="frm" action="" method="" value="">
		<div class="loginBox" id="loginBox">
			<div class="loginPart">
			<section id="toptitle" class="toptitle">
				<div class="innerwrap">
					<h4 class="tit">Login</h4>
				</div>
			</section>
			<div class="idInputBox" id="idInputBox">
				<span class="id_icon">
					<i class="fa fa-user" aria-hidden="true"></i>
				</span>
				<input type="text" name="memberId" id="memberId" value="" placeholder="아이디">
				<button type="button" class="resetBtn1" style="display:none;" onclick="disappear1();">X</button>
			</div>
			<div class="pwdInputBox" id="pwdInputBox">
				<span class="pwd_icon">
					<i class="fa fa-lock" aria-hidden="true"></i>
				</span>
				<input type="password" name="memberPwd" id="memberPwd" value=""	placeholder="비밀번호" onkeypress="if(event.keyCode == 13){ check(); return;}">
				<button type="button" class="resetBtn2" style="display:none;" onclick="disappear2();">X</button>
			</div>
			<button type="button" class="loginbtn" onclick="check();">
				<span>로그인</span>
			</button>

			<div class="wrap">
				<a href="<%=request.getContextPath()%>/member/findInfo.do">아이디 / 비밀번호 찾기</a>
				&emsp;
				|
				&emsp;
				<a href="<%=request.getContextPath()%>/member/memberJoin.do">회원가입</a>
			</div>
			</div>
	
			<div class="socialPart">
				<h4>Social Login</h4>
				<div class="socialLogin">
					<ul class="login_sns">
						<li>
							<a href="<%=request.getContextPath()%>/member/KakaoMemberLogin.do" class="kakao">Kakao 로그인</a>
						</li>
						<li>
							<a href="<%=request.getContextPath()%>/member/naverMemberLogin.do" class="naver">Naver 로그인</a>
						</li>
						<li>
							<a href="<%=request.getContextPath()%>/member/googleMemberLogin.do" class="google">Google 로그인</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</form>
</div>
<div id="footers"></div>	
</body>
</html>