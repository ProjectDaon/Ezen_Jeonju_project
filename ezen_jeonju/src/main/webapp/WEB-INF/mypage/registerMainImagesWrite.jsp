<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 등록 페이지</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/registerMainImagesModify.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
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
	window.history.replaceState({}, document.title, 'http://localhost:8080');
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
	
});

$(document).ready( function() {
	
});
</script>
<div id="headers"></div>
<script>
function goWrite(){
	swal({
		title: "",
		text: "배너를 등록하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			var fm = document.frm;
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
					'<b style="font-weight:bold;">이미지를 첨부해주세요.</b>',
					'warning'
				);
				fm.uploadFileName.focus();
				return;
			}
			
			swal(
				'',
				'<b style="font-weight:bold;">배너가 등록되었습니다.</b>',
				'success'
			);
			
			fm.action ="<%=request.getContextPath()%>/main/mainVannerRegisterAction.do"; 
		    fm.method = "post"; 
		    fm.enctype= "multipart/form-data";
		    fm.submit();
		    return;
		}		
	});
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
            <input type="hidden" name="mainPageSequence" value="${mpv.mainPageSequence}">
            <div class="select_img"><img src="" /></div>
            <div>
                <label>이미지링크</label>
                <input type="text" name="mainPageLink">
            </div>
            <div>
                <input type="file" id="fileImg" name="uploadFileName" />
            </div>       
            <div class="btn">
            	<a href="#" onclick="goWrite();">등록하기</a>
            	<a href="<%=request.getContextPath()%>/main/vannerRegisterList.do">목록</a>
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
<div id="footers"></div>
</body>
</html>