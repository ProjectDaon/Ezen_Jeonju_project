<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>zzz</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>

<script>
function goWrite(){
	var fm = document.frm;
	
	if(fm.mainPageSubject.value==""){
		alert('제목을 입력해주세요');
		fm.mainPageSubject.focus();
		return;
	}
	
	fm.action ="<%=request.getContextPath()%>/main/mainVannerRegisterAction.do"; 
    fm.method = "post"; 
    fm.enctype= "multipart/form-data";
    fm.submit();
    return;
}
</script>

<form name="frm">
<div class="inputArea">
 <label for="gdsImg">이미지</label>
 <input type="text" name="mainPageSubject">
 <label for="gdsImg">시퀀스</label>
 <input type="text" name="mainPageSequence">
 <div class="select_img"><img src="" /></div>
 <label for="gdsImg">이미지링크</label>
 <input type="text" name="mainPageLink"><br>
 
 <input type="file" id="gdsImg" name="uploadFileName" />
 
 <input type="button" value="등록" onclick="goWrite()">

 <script>
  $("#gdsImg").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(500);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
 </script>
</div>
</form>





</body>
</html>