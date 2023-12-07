<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("#btn").on("click",function(){
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

</script>

</head>
<body>
<script>
	function check(){
		var fm = document.frm;
		
		if(fm.memberId.value == ""){
			alert("아이디를 입력하세요");
			fm.memberId.focus();
			return;
		}else if(fm.memberPwd.value == ""){
			alert("비밀번호를 입력하세요");
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
		}else if(fm.memberPhone.value == ""){
			alert("휴대폰번호를 입력하세요");
			fm.memberPhone.focus();
			return;
		}
		
		fm.action = "<%=request.getContextPath()%>/member/memberJoinAction.do";
		fm.method = "post";
		fm.submit();
		return;
	}
</script>
	<form name="frm" action="" method="" value="">
		<table border="1" style="width: 600px">
			<tr>
				<th style="width: 200px" maxlength="30">아이디</th>
				<td><input type="text" name="memberId" id="memberId" value="" placeholder="ID를 입력하세요">
					<input type="button" name="btn" id="btn" value="아이디 중복체크">
				</td>
			</tr>
			<tr>
				<th style="color: red"font-weight:bold">비밀번호</th>
				<td><input type="password" name="memberPwd" value=""></td>
			</tr>
			<tr>
				<th style="color: red"font-weight:bold">비밀번호 확인</th>
				<td><input type="password" name="memberPwd2"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="memberName" value=""
					placeholder="홍길동" style="width: 100px"></td>
			</tr>
			
			<tr>
				<th>휴대폰</th>
				<td><input type="tel" name="memberPhone"
					placeholder="01012345678"
					pattern="[0-9]{2,3}[0-9]{3,4}[0-9]{3,4}" maxlength="13"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<!-- <input
					type="submit" name="smt" value="가입하기"> --> 
					<input type="button" name="btn" value="가입하기" onclick="check();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>