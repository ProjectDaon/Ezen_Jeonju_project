<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/searchPwd.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
	
	updateSessionTimer(); // 초기화

});

function changePwd(){
	var fm = document.frm;
	var pw = fm.memberPwd.value;
	var num = pw.search(/[0-9]/g);
	var eng = pw.search(/[a-z]/ig);
    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
    
    if(pw.length < 8 || pw.search(/\s/) != -1 || num < 0 || eng < 0 || spe < 0 ){
		alert("비밀번호 형식을 확인해주세요");
		return;
    }else if(pw !== fm.memberPwd2.value){
    	alert("비밀번호 확인이 틀렸습니다.");
    	return;
    }
    
    fm.action = "<%=request.getContextPath()%>/member/changePwdAction.do";
	fm.method = "post";
	fm.submit();
	return;
}
</script>
<div id="headers"></div>
<div class="contents">
	<div class="title_wrap">
		<h4>비밀번호 변경</h4>
		<h2>새로운 비밀번호를 입력해주세요</h2>
	</div>
	<div class="auth_wrap">
		<form name="frm">
		<table>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="memberPwd"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="memberPwd2"></td>
			</tr>
		</table>
		</form>
	</div>
	<div class="pwInfo">※ 영문, 숫자, 특수기호 포함 8자 이상</div>
	<button class="btn" onclick="changePwd();">확인</button>
</div>
<div id="footers"></div>
</body>
</html>