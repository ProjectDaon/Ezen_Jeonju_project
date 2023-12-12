<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>contentsWrite</title>
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
	
	if(fm.contentsSubject.value==""){
		alert('제목을 입력해주세요');
		fm.contentsSubject.focus();
		return;
	}
	
	fm.action ="<%=request.getContextPath()%>/contents/contentsWriteAction.do"; 
    fm.method = "post"; 
    fm.enctype= "multipart/form-data";
    fm.submit();
    return;
}
</script>
<form name="frm">
	제목 <input type="text" name="contentsSubject"> 
	분류
	<select name="contentsCategory">
		<option value="명소">명소</option>
		<option value="음식">음식</option>
	</select>
	<textarea id="summernote" name="contentsArticle"></textarea>
	<input type="file" name="contentsFileName">
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