<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet"  href="../css/findInfo.css">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<script>
	<% if (request.getAttribute("alertMessage") != null) { %>
    alert("${alertMessage}");
	<% } %>
</script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
});

function check_Id(){
	var fm = document.frm;
	
	if(fm.memberEmail.value ==""){
		alert("이메일을 입력해주세요.");
		fm.memberEmail.focus();
		return;
	} 
	
	fm.action = "<%=request.getContextPath()%>/member/findId.do";
	fm.method = "post";
	fm.submit();
	return;
}
function check_id_mail(){
	var fm = document.pwfrm;
	var memberId = fm.memberId.value;
	var memberEmail = fm.memberEmail.value;
	
	fm.action = "<%=request.getContextPath()%>/member/checkInfo.do";
	fm.method = "post";
	fm.submit();
	return;
}
</script>
<div id="headers"></div>
<div class="contents">
		<div class="inner">
			<div class="find_id">
				<form name="frm" action="${contextPath}/member/findId.do" method="" value="">
					<div class="find_inner">
						<div class="title_wrap">
							<h4>아이디 찾기</h4>
							<h2>이메일을 입력해주세요.</h2>
						</div>
						<div class="mailInputBox" id="mailInputBox">
							<span class="mail_icon">
								<i class="fa fa-envelope" aria-hidden="true"></i>
							</span>
							<input type="email" name="memberEmail" id="memberEmail" class="input_mail" placeholder="이메일 주소">
							<button type="button" class="resetBtn" style="display:none;"><i class="fa fa-times-circle" aria-hidden="true"></i></button>
						</div>
						<button type="button" id="check_id" class="checkBtn" onclick="check_Id();">
							<span class="next">다음</span>
						</button>
					</div>
				</form>
			</div>
			<div class="find_pwd">
				<div class="find_inner">
					<div class="title_wrap">
						<h4>비밀번호 찾기</h4>
						<h2>아이디와 이메일을 입력해주세요.</h2>
					</div>
					<form name="pwfrm">
					<div class="idInputBox" id="idInputBox">
						<span class="id_icon">
							<i class="fa fa-user" aria-hidden="true"></i>
						</span>
						<input type="text" class="input_id" placeholder="아이디" name="memberId">
						<button type="button" class="resetBtn" style="display:none;"><i class="fa fa-times-circle" aria-hidden="true"></i></button>
					</div>
					<div class="mailInputBox" id="mailInputBox">
						<span class="mail_icon">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
						<input type="email" class="input_mail" placeholder="이메일 주소" name="memberEmail">
					</div>
					</form>

					<button type="button" class="checkBtn" onclick="check_id_mail();">
						<span class="next">다음</span>
					</button>
				</div>
			</div>
		</div>
</div>
<div id="footers"></div>
</body>
</html>