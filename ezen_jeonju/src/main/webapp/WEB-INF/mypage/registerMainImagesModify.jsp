<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 수정 페이지</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/registerMainImagesModify.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/7430509f6d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
});

$(document).ready( function() {
	
});
</script>
<div id="headers"></div>
<script>
function goModify(){
	var isConfirmed = confirm('배너를 수정하겠습니까?');
	if (isConfirmed) {
		var fm = document.frm;
		var fileUploadedElement = document.querySelector('.fileUploaded'); 
		
		if(fm.mainPageSubject.value==""){
			alert('배너 제목을 입력해주세요');
			fm.mainPageSubject.focus();
			return;
		}else if(fm.mainPageLink.value==""){
			alert('배너 링크를 입력해주세요');
			fm.mainPageLink.focus();
		return;
		}else if(fm.uploadFileName.value==""){
			alert('새로운 이미지를 첨부해주세요');
			fm.uploadFileName.focus();
		return;
		}else if(fileUploadedElement.style.display !== "none"){
			alert('기존 배너 이미지를 삭제해주세요');
		return;
		}
		
		fm.action ="<%=request.getContextPath()%>/main/mainVannerModifyAction.do";
	    fm.method = "post"; 
	    fm.enctype= "multipart/form-data";
	    fm.submit();
	    return;
	};
}

function goDelete(mpidx){
	var isConfirmed = confirm('등록된 배너를 삭제하겠습니까?');
	if (isConfirmed) {
		var fm = document.frm;
		fm.action ="<%=request.getContextPath()%>/main/mainVannerDeleteAction.do?mpidx="+mpidx;
	    fm.method = "post";
		fm.enctype= "multipart/form-data";
	    fm.submit();
	    return;
	}
};



function fileDelete(){
	var isConfirmed = confirm('기존 배너 이미지를 삭제하겠습니까?');
	if (isConfirmed) {
		var fileUploadedElement = document.querySelector('.fileUploaded');
		if (fileUploadedElement) {
			// fileUploaded 클래스의 display 속성을 none으로 변경
			fileUploadedElement.style.display = 'none';
            if ($("#fileImg").val() === "") {
                $(".select_img img").attr("src", "");
                $(".select_img").css('height', '500px');
            }
		}
	}
}   


</script>

<form name="frm">
    <div class="contents">
        <div class="inner-wrap">
            <div class="title-wrap">
                <h3>배너 수정</h3>
            </div>
            <div>
                <label>배너 제목</label>
                <input type="text" name="mainPageSubject" value="${mpv.mainPageSubject}">
            </div>
            <input type="hidden" name="mainPageSequence" value="${mpv.mainPageSequence}">
            <input type="hidden" name="storedFile" value="${af.storedFilePath}">
   		 	<input type="hidden" name="storedThumbnail" value="${af.thumbnailFilePath}">
   		 	<input type="hidden" name="aidx" value="${af.aidx}">
   		 	<input type="hidden" name="mpidx" value="${mpv.mpidx}">
            <div class="select_img"><img src="${pageContext.request.contextPath}/imageLoading.do?aidx=${af.aidx}"/></div>
            <div>
                <label>이미지링크</label>
                <input type="text" name="mainPageLink" value="${mpv.mainPageLink}">
            </div>
            <div>
            	<label>기존 배너</label>
            	<span class ="fileUploaded" name="fileUploaded"><i class="fa-solid fa-floppy-disk"></i>${af.originalFileName}<a href="#none" onclick="fileDelete();"><i class="fa-solid fa-square-xmark"></i></a></span>
            </div>
            <div>
                <input type="file" id="fileImg" name="uploadFileName" />
            </div>       
            <div class="btn">
                <a href="#" onclick="goModify();">수정하기</a>
                <a href="javascript:window.history.back();">목록</a>
                <a href="#" onclick="goDelete(${mpv.mpidx});">삭제</a>
            </div>
        </div>
    </div>
</form>
<div id="footers"></div>

<script>
    $("#fileImg").change(function(){
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