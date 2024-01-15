<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/memberJoin.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<script>
var isError = "${error}";
if (isError !== '') {
    alert(isError);
}
$(document).ready(function(){
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	
	$('#memberId').keyup(function(){
		$('#checkBtn').css("color","green");
		$('#checkBtn').css("background","white");
	});
	
	$("#checkBtn").on("click",function(){
		let memberId = $("#memberId").val();
		


        $.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/member/memberIdCheck.do",
			data: {"memberId" : memberId},
			dataType: "json",
			success: function(data){
				var fm = document.frm;
				if(fm.memberId.value==""){
					alert("아이디를 입력해주세요!!");
				}else if(data.value == 0){
					alert("사용할 수 있는 아이디입니다.");
					$('#checkBtn').css("background","green");
					$('#checkBtn').css("color","white");
				}else{
					alert("사용할 수 없는 아이디입니다ㅠㅠ.");
					fm.memberId.value = "";
				}
			},
			error: function(){
				alert("실패");
			}
		});
	});
});


function check(){
		var fm = document.frm;
		var idCheck = $('#checkBtn').css("background-color");
		var pwCheck = $('#pass-info').css("color");
		var RegExp = /^[a-zA-Z0-9]{4,12}$/;
		
		if(fm.memberId.value == ""){
			alert("아이디를 입력하세요");
			fm.memberId.focus();
			return;
		}else if(!RegExp.test(fm.memberId.value)){
			alert("아이디 형식을 확인해주세요");
			return;
		}else if(idCheck !=='rgb(0, 128, 0)'){
			alert("아이디중복을 체크해주세요");
			return;
		}else if(fm.memberPwd.value == ""){
			alert("비밀번호를 입력하세요");
			fm.memberPwd.focus();
			return;
		}else if(pwCheck === "rgb(255, 0, 0)"){
			alert("비밀번호 형식을 확인해주세요");
			fm.memberPwd.focus();
			return;
		}else if(fm.memberPwd2.value == ""){
			alert("비밀번호확인을 입력하세요");
			fm.memberPwd2.focus();
			return;
		}else if(fm.memberPwd.value != fm.memberPwd2.value){
			alert("비밀번호가 일치하지 않습니다.");
			fm.memberPwd2.value="";
			fm.memberPwd1.focus();
			return;
		}else if(fm.memberName.value == ""){
			alert("이름을 입력하세요");
			fm.memberName.focus();
			return;
		}else if(fm.memberEmail.value == ""){
			alert("이메일을 입력하세요");
			fm.memberPhone.focus();
			return;
		}else if (!CheckEmail(fm.memberEmail.value)){
			alert("이메일 형식이 유효하지 않습니다.");
			fm.memberEmail.value="";
			fm.memberEmail.focus();
			return;	
		}else if(fm.authNumber.value==""){
			alert("메일인증을 완료해주세요");
			return;
		}
		fm.action = "<%=request.getContextPath()%>/member/memberJoinAction.do";
		fm.method = "post";
		fm.submit();
		return;
}

function CheckEmail(str){ 
	//정규표현식 - 일정한 패턴에따라 해당되는 위치에 해당하는 값의 범위를 지정
     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
     if(!reg_email.test(str)) { 
          return false;  
     }  
     else {
          return true; 
     } 
}

function mailAuth(){
	var memberEmail = $('input[name="memberEmail"]').val();
	if(!CheckEmail(memberEmail)){
		alert("이메일 형식이 유효하지 않습니다.");
		return;
	}
	
	$.ajax({
		type: "post",
		url: "<%=request.getContextPath()%>/member/mailAuth.do",
		data: {"memberEmail" : memberEmail},
		dataType: "json",
		success: function(data){
			alert("인증번호가 전송되었습니다");
			$('#authNum').css("display","block");
		},
		error: function(){
			alert("실패");
		}
	});

    updateSessionTimer(); // 초기화

    // 1초마다 업데이트
    var timerInterval = setInterval(function () {
        updateSessionTimer();
    }, 1000);
}

function mailAuthCheck(){
	var authNumber = $('input[name="authNumber"]').val();
	$.ajax({
		type: "post",
		url: "<%=request.getContextPath()%>/member/mailAuthCheck.do",
		data: {"authNumber" : authNumber},
		dataType: "json",
		success: function(data){
			if(data.txt=='pass'){
				$('#sessionTimer').css("display","none");
				$('#passCheckOK').css("display","inline-block");
				$('#passCheckOK').html("인증완료");
				$('input[name="authNumber"]').attr('readonly',true);
			}
		},
		error: function(){
			alert("실패");
		}
	});
}

    // 세션 타이머 표시를 업데이트하는 함수
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
</script>
<script src="../js/memberJoin.js"></script>
	<div id="headers"></div>

	<div class="memberJoin">
		<div class="title">
			<h3>회원가입</h3>
		</div>
		<form name="frm" action="" method="" value="">
			<table border="1" style="width: 650px">
				<tr>
					<th style="width: 200px" maxlength="30">아이디</th>
					<td>
						<div class="idInfo">4~12글자 영어,숫자만 가능</div>
						<input type="text" name="memberId" id="memberId" value="" placeholder="ID를 입력하세요">
						<input type="button" class="checkBtn" name="btn" id="checkBtn" value="중복체크">
					</td>
				</tr>
				<tr>
					<th style="color: red"font-weight:bold">비밀번호</th>
					<td>
						<input type="password" name="memberPwd" value="" oninput="pwcheck();">
						<div id="pass-info" class="pass-info"></div>
					</td>
				</tr>
				<tr>
					<th style="color: red"font-weight:bold">비밀번호 확인</th>
					<td>
						<input type="password" name="memberPwd2" oninput="pwcheck();">
						<div class="pass-check-info" id="pass-check-info"></div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="memberName" value=""
						placeholder="홍길동" style="width: 100px"></td>
				</tr>
				
				<tr>
					<th>이메일</th>
					<td>
						<input type="email" name="memberEmail" placeholder="ezen@naver.com">
						<button type="button" class="emailbtn" name="emailbtn" onclick="mailAuth();">인증하기</button>
						<div name="authNum" id="authNum" style="display:none">
							<input type="text" name="authNumber" class="authNumber">
							<button type="button" class="mailAuthCheckBtn" onclick="mailAuthCheck();">확인</button>
							<div id="sessionTimer" class="sessionTimer"></div>
							<div id="passCheckOK" class="passCheckOK" style="display:none;"></div>
							<input type="hidden" id="sessionTimeOut" name="sessionTimeOut" value="180">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<!-- <input
						type="submit" name="smt" value="가입하기"> --> 
						<input type="button" name="btn" class="signInBtn" value="가입하기" onclick="check();">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>