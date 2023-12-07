<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
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
<form name="frm" action="" method="" value="">
	<div id="loginBox">
		<div id="text">Login</div>
		<table>
			<tr>
				<th id="loginId">아이디</th>
				<td><input type="text" name="memberId" id="memberId" value=""
					placeholder="아이디 입력"></td>
			</tr>
			<tr>
				<th id="LoginPassword">비밀번호</th>
				<td><input type="password" name="memberPwd" id="memberPwd" value=""
					placeholder="비밀번호 입력" onkeypress="if(event.keyCode == 13){ check(); return;}"></td>
			</tr>
		</table>
		<div>
			<a href="#" id="button" onclick="check();">로그인</a>
		</div>
	</div>
	</form>
</body>
</html>