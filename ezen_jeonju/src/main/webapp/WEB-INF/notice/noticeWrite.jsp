<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<link rel="stylesheet" href="../css/navbar.css">
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../summernote/summernote-ko-KR.js"></script>

<!-- 해시태그 source -->
<script src="https://unpkg.com/@yaireo/tagify"></script>
<!-- 폴리필 (구버젼 브라우저 지원) -->
<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.tagify{    
  width: 100%;
  max-width: 700px;
}

.tags-look .tagify__dropdown__item{
  display: inline-block;
  border-radius: 3px;
  padding: .3em .5em;
  border: 1px solid #CCC;
  background: #F3F3F3;
  margin: .2em;
  font-size: .85em;
  color: black;
  transition: 0s;
}

.tags-look .tagify__dropdown__item--active{
  color: black;
}

.tags-look .tagify__dropdown__item:hover{
  background: lightyellow;
  border-color: gold;
}
</style>

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
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
	
	if(fm.noticeSubject.value==""){
		alert('제목을 입력해주세요');
		fm.noticeSubject.focus();
		return;
	}
	
	fm.action ="<%=request.getContextPath()%>/notice/noticeWriteAction.do"; 
    fm.method = "post"; 
    fm.enctype= "multipart/form-data";
    fm.submit();
    return;
}
</script>
<div class="panel-heading">공지사항 작성하기</div>
	<div class="panel-body">
		<form name="frm">
			<div class="form-group">
				<label>카테고리</label>
				<select name="noticeCategory">
					<option value="공연">공연</option>
					<option value="전시">전시</option>
					<option value="축제">축제</option>
					<option value="행사">행사</option>
				</select>
			</div> 
			<div>
				<label>제목</label>
				<input type="text" name="noticeSubject">
			</div>
			
			<textarea id="summernote" name="noticeArticle"></textarea>
			
			<div class="hashTagArea">
				해시태그<input name='noticeHashtag'>
			</div>
			<script>
			var input = document.querySelector('input[name="noticeHashtag"]'),
			
			// init Tagify script on the above inputs
			tagify = new Tagify(input, {
			whitelist: ["#공연", "#전시", "#축제", "#행사"], // 화이트리스트 배열
			maxTags: 10, // 최대 허용 태그 갯수
				dropdown: {
				maxItems: 4,           // 드롭다운 메뉴에서 몇개 정도 항목을 보여줄지
				classname: "tags-look", // 드롭다운 메뉴 엘리먼트 클래스 이름. 이걸로 css 선택자로 쓰면 된다.
				enabled: 0,             // 단어 몇글자 입력했을떄 추천 드롭다운 메뉴가 나타날지
				closeOnSelect: false    // 드롭다운 메뉴에서 태그 선택하면 자동으로 꺼지는지 안꺼지는지
				}
			})
			</script>
			
			<input type="file" name="uploadFileName">
			<input type="button" value="등록" onclick="goWrite()">
		</form>
	<script>
	$(document).ready(function() {
	  $('#summernote').summernote({
	    lang: 'ko-KR' // default: 'en-US'
	  });
	});
	</script>
	</div>
</body>
</html>