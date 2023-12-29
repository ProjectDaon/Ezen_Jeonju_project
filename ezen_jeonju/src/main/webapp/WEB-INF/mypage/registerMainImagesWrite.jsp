<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 등록 페이지</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/registerMainImagesWrite.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>

<style>
h3 {
    font-size: 42px;
    font-weight: 500;
    margin: 0;
    text-align: center;
}

.contents {
    margin-top: 5%;
    padding: 5%;
    text-align: center;
    display: flex;
}

.inner-wrap {
    position: relative;
    margin: 0 auto;
    width: 1080px;
    height: auto;

}

.select_img {
    width: 100%;
    height: 500px;
    border-top: 1px solid coral;
    border-bottom: 1px solid coral;
}

.inner-wrap div{
    padding: 10px;
    text-align: left;
}

input[type="text"] {
    padding: 6px;
    width: 40%;
}

label {
    margin-left: 20px;
    margin-right: 20px;
}

.vannerSequece {
    display: none;
}


</style>

</head>
<body>
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
    <div class="contents">
        <div class="inner-wrap">
            <div class="title-wrap">
                <h3>배너 등록</h3>
            </div>
            <div>
                <label>배너 제목</label>
                <input type="text" name="mainPageSubject">
            </div>
            <div class="vannerSequece">
                <label>배너 번호</label>
                <input type="text" name="mainPageSequence" value="${mpv.mainPageSequence}">
            </div>
            <div class="select_img"><img src="" /></div>
            <div>
                <label>이미지링크</label>
                <input type="text" name="mainPageLink">
            </div>
            <div>
                <input type="file" id="gdsImg" name="uploadFileName" />
            </div>       
            <div>
                <input type="button" value="등록" onclick="goWrite()">
            </div>
        </div>
    </div>
</form>

<script>
    $("#gdsImg").change(function(){
        if(this.files && this.files[0]) {
            var reader = new FileReader;
            reader.onload = function(data) {
                $(".select_img img").attr("src", data.target.result).width('100%');
                $(".select_img").css('height', 'auto');
            }
            reader.readAsDataURL(this.files[0]);
        } else {
            // 파일을 선택하지 않은 경우 이미지 초기화
            $(".select_img img").attr("src", "");
            $(".select_img").css('height', '500px');
        }
    });
</script>
</body>
</html>