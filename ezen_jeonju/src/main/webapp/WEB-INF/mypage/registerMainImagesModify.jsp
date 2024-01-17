<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[EZEN-JEONJU]배너 수정</title>
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/registerMainImagesModify.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/7430509f6d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
<style type="text/css">
.swal2-popup .swal2-content {
    font-weight: bold;
}
</style>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	window.history.replaceState({}, document.title, 'http://192.168.0.30:8080');
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
});

$(document).ready( function() {
	
});
</script>
<div id="headers"></div>
<script>
function goModify(){
	swal({
		title: "",
		text: "배너를 수정하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			var fm = document.frm;
			var fileUploadedElement = document.querySelector('.fileUploaded'); 
			
			if(fm.mainPageSubject.value==""){
				swal(
					'',
					'<b style="font-weight:bold;">배너 제목을 입력해주세요.</b>',
					'warning'
				);
				fm.mainPageSubject.focus();
				return;
			}else if(fm.mainPageLink.value==""){
				swal(
					'',
					'<b style="font-weight:bold;">배너 링크를 입력해주세요.</b>',
					'warning'
				);
				fm.mainPageLink.focus();
			return;
			}else if(fm.uploadFileName.value==""){
				swal(
					'',
					'<b style="font-weight:bold;">새로운 배너 이미지를 첨부해주세요.</b>',
					'warning'
				);
				fm.uploadFileName.focus();
			return;
			}else if(fileUploadedElement.style.display !== "none"){
				swal(
					'',
					'<b style="font-weight:bold;">기존 배너 이미지를 삭제해주세요.</b>',
					'warning'
				);
			return;
			}
			
			swal(
				'',
				'<b style="font-weight:bold;">배너가 수정되었습니다.</b>',
				'success'
			).then(function(){
				fm.action ="<%=request.getContextPath()%>/main/mainVannerModifyAction.do";
			    fm.method = "post"; 
			    fm.enctype= "multipart/form-data";
			    fm.submit();
			    return;
				
			});
			
		}		
	});
}

function goDelete(mpidx){
	swal({
		title: "",
		text: "등록된 배너를 삭제하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">배너가 삭제되었습니다.</b>',
				'success'
			).then(function(){
				var fm = document.frm;
				fm.action ="<%=request.getContextPath()%>/main/mainVannerDeleteAction.do?mpidx="+mpidx;
				fm.method = "post";
				fm.enctype= "multipart/form-data";
				fm.submit();
				return;
				
			});
		}
	});
}


function fileDelete(){
	swal({
		title: "",
		text: "기존 배너 이미지를 삭제하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">배너가 삭제되었습니다.</b>',
				'success'
			)
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
	});
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
                <a href="<%=request.getContextPath()%>/main/vannerRegisterList.do">목록</a>
                <a href="#" onclick="goDelete(${mpv.mpidx});">삭제</a>
            </div>
        </div>
    </div>
</form>

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