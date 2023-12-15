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
			<input type="file" name="noticeFileName">
			<input type="button" value="등록" onclick="goWrite()">
			
			<div class="tr_hashTag_area">
				<p><strong>해시태그 구현</strong></p>
				<div class="form-group">
				<input type="hidden" value="" name="tag" id="rdTag" />
				</div>
				
				<ul id="tag-list"></ul>
				
				<div class="form-group">
				<input type="text" id="tag" size="7" placeholder="엔터로 해시태그를 등록해주세요." style="width: 300px;"/>
				</div>
			</div>
			<script>
    $(document).ready(function () {
        var tag = {};
        var counter = 0;

        // 입력한 값을 태그로 생성한다.
        function addTag (value) {
            tag[counter] = value;
            counter++; // del-btn 의 고유 id 가 된다.
        }

        // tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
        function marginTag () {
            return Object.values(tag).filter(function (word) {
                return word !== "";
            });
        }
    
        // 서버에 제공
        $("#tag-form").on("submit", function (e) {
            var value = marginTag(); // return array
            $("#rdTag").val(value); 

            $(this).submit();
        });

        $("#tag").on("keypress", function (e) {
            var self = $(this);

            //엔터나 스페이스바 눌렀을때 실행
            if (e.key === "Enter" || e.keyCode == 32) {

                var tagValue = self.val(); // 값 가져오기

                // 해시태그 값 없으면 실행X
                if (tagValue !== "") {

                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
                    var result = Object.values(tag).filter(function (word) {
                        return word === tagValue;
                    })
                
                    // 해시태그가 중복되었는지 확인
                    if (result.length == 0) { 
                        $("#tag-list").append("<li class='tag-item'>"+tagValue+"<span class='del-btn' idx='"+counter+"'>x</span></li>");
                        addTag(tagValue);
                        self.val("");
                    } else {
                        alert("태그값이 중복됩니다.");
                    }
                }
                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
            }
        });

        // 삭제 버튼 
        // 인덱스 검사 후 삭제
        $(document).on("click", ".del-btn", function (e) {
            var index = $(this).attr("idx");
            tag[index] = "";
            $(this).parent().remove();
        });
})
</script>
			
			
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