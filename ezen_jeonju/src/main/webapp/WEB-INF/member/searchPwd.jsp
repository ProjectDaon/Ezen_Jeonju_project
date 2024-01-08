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
// 1초마다 업데이트
var timerInterval = setInterval(function () {
    updateSessionTimer();
}, 1000);

function updateSessionTimer() {
    console.log('updateSessionTimer 호출'); // 디버깅 메시지 추가
    var sessionTimeOut = $('#sessionTimeOut').val();
    var sessionTimerElement = $('#sessionTimer');
	var txt = "남은시간: " + sessionTimeOut + "초";
    // 세션 타이머 값이 0 이상일 때만 업데이트
    if (sessionTimeOut > 0) {
        sessionTimerElement.html(txt);
        $('#sessionTimeOut').val(sessionTimeOut-1);

    } else {
        // 세션이 만료되었을 때의 처리를 추가할 수 있습니다.
        sessionTimerElement.html('세션이 만료되었습니다.');
        clearInterval(timerInterval); // 세션이 만료되면 타이머 중지
    }
}
function authCheck(){
	var auth = $('#authNum').val();
	
	$.ajax({
		type: "post",
		url: "<%=request.getContextPath()%>/member/mailAuthCheckPwd.do",
		data: {"authNumber" : auth},
		dataType: "json",
		success: function(data){
			if(data.txt=='pass'){
				alert("인증이 완료되었습니다.");
				 window.location.href = data.url;
			}else{
				alert(data.txt);
			}
		},
		error: function(){
			alert("실패");
		}
	});
}

</script>
<div id="headers"></div>
<div class="contents">
	<div class="title_wrap">
		<h4>인증번호 확인</h4>
		<h2>이메일로 전송된 인증번호를 입력해주세요.</h2>
	</div>
	<div class="auth_wrap">
		<input type="text" name="authNum" id="authNum">
		<div id="sessionTimer" class="sessionTimer" style="display:inline"></div>
		<div id="passCheckOK" class="passCheckOK" style="display:none;"></div>
		<input type="hidden" id="sessionTimeOut" name="sessionTimeOut" value="<%=session.getMaxInactiveInterval()%>">
	</div>
	<button class="btn" onclick="authCheck();">확인</button>
</div>
<div id="footers"></div>
</body>
</html>