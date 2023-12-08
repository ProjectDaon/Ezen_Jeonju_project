<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../summernote/summernote-ko-KR.js"></script>

</head>
<body>
<script>
function goWrite(){
	var fm = document.frm;
	
	if(fm.noticeSubject.value==""){
		alert('제목을 입력해주세요');
		fm.noticeSubject.focus();
		return;
	}
	
	fm.action ="<%=request.getContextPath()%>/notice/noticeWriteAction.do"; 
    fm.method = "post"; 
    fm.submit();
    return;
}
</script>
<form name="frm">
	제목 <input type="text" name="noticeSubject"> 
	분류
	<select name="noticeCategory">
		<option value="공연">공연</option>
		<option value="전시">전시</option>
		<option value="행사">행사</option>
		<option value="축제">축제</option>
	</select>
	<textarea id="summernote" name="noticeArticle"></textarea>
	<input type="file" name="noticeFile">
	<input type="button" value="글쓰기" onclick="goWrite()">
</form>
<script>
$(document).ready(function() {
  $('#summernote').summernote({
    lang: 'ko-KR' // default: 'en-US'
  });
});
</script>
</body>
</html>