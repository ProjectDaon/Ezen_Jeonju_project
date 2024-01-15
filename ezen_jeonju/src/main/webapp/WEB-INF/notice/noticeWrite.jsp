<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/noticeWrite.css">
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
	$('#headers').load("../nav/nav.jsp");
	
	$('#summernote').summernote({
		  lang: 'ko-KR' // default: 'en-US'
	});
});

function goWrite(){
	var fm = document.frm;
	
	if(fm.noticeSubject.value==""){
		swal(
			'',
			'<b style="font-weight:bold;">제목을 입력해주세요.</b>',
			'warning'
		);
		fm.noticeSubject.focus();
		return;
	}
	swal({
		title: "",
		text: "공지사항을 등록하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">공지사항이 등록되었습니다.</b>',
				'success'
			).then(function(){
				fm.action ="<%=request.getContextPath()%>/notice/noticeWriteAction.do"; 
			    fm.method = "post"; 
			    fm.enctype= "multipart/form-data";
			    fm.submit();
			    return;
			});
		}
	});
}
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>

<div class="WritingWrap">
	<div class="WritingHeader">
		<h2 class="title">공지사항 작성하기</h2>
		<input class="btn" type="button" value="등록" onclick="goWrite()">
	</div>
	<div class="WritingContent">
		<form name="frm">
		<div class="editer_wrap">
			<div class="formCategory">
				<label>카테고리</label>
				<select name="noticeCategory" required>
					<option value="" disabled selected>카테고리를 선택해 주세요.</option>
					<option value="공연">공연</option>
					<option value="전시">전시</option>
					<option value="축제">축제</option>
					<option value="행사">행사</option>
				</select>
			</div> 
			<div class="formSubject">
				<label>제목</label>
				<input type="text" name="noticeSubject" placeholder="제목을 입력해 주세요.">
			</div>
			<div class="hashTagArea">
				<label>해시태그</label>
				<input name='noticeHashtag'>
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
			<div class="attachFile">
				<label>파일첨부</label>
				<input type="file" name="uploadFileName">
			</div>
		</div>	
		<textarea id="summernote" name="noticeArticle"></textarea>
		</form>
	</div>
</div>
</body>
</html>