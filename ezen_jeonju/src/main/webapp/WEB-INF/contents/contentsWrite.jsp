<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컨텐츠 작성</title>
<link rel="stylesheet" href="../css/navbar.css">
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../summernote/summernote-ko-KR.js"></script>
<style>
.tagify{    
  width: 100%;
  max-width: 700px;
}

.tagify--outside{
    border: 0;
}

.tagify--outside .tagify__input{
  order: -1;
  flex: 100%;
  border: 1px solid var(--tags-border-color);
  margin-bottom: 1em;
  transition: .1s;
}

.tagify--outside .tagify__input:hover{ border-color:var(--tags-hover-border-color); }
.tagify--outside.tagify--focus .tagify__input{
  transition:0s;
  border-color: var(--tags-focus-border-color);
}
</style>
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

$(document).ready(function(){
    $('#searchButton').on('click', function(){
    	
      var keyword = $('#searchAddr').val();
      
      $.ajax({
  		type: "post",
  		url: "${pageContext.request.contextPath}/contents/searchAddrs.do?keyword="+keyword,
		dataType: "json",
		success: function(data){
			$('#addr').val(data.addrResult);
		},
		error: function(request, status, error) {
	        alert(data);
	        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	      }
  	});
    });
  });

</script>
<div class="panel-heading">글 작성하기</div>
	<div class="panel-body">
		<form name="frm">
			<div class="form-group">
				<label>카테고리</label>
				<select name="contentsCategory">
					<option value="명소">명소</option>
					<option value="음식">음식</option>
				</select>
			</div> 
			<div>
				<label>제목</label>
				<input type="text" name="contentsSubject"><br>
				<script src="https://unpkg.com/@yaireo/tagify"></script>
				<!-- 폴리필 (구버젼 브라우저 지원) -->
				<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
				<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
				
				<!-- 해시 태그 정보를 저장할 input 태그. (textarea도 지원) -->
				태그<input name='basic'>
				
				<script>
				    const input = document.querySelector('input[name=basic]');
				    let tagify = new Tagify(input); // initialize Tagify
				    
				    // 태그가 추가되면 이벤트 발생
				    tagify.on('add', function() {
				      console.log(tagify.value); // 입력된 태그 정보 객체
				    })
				</script>
			</div>
			<textarea id="summernote" name="contentsArticle"></textarea>
			<input type="file" name="contentsFileName">
			
	<script>
	$(document).ready(function() {
	  $('#summernote').summernote({
	    lang: 'ko-KR' // default: 'en-US'
	  });
	});
	</script>
	
	<input type="text" id="searchAddr" class="inp_out" size="70" placeholder="찾고자 하는 주소를 검색해주세요">
	<input type="button" value="검색" id="searchButton">
	<br>
	
	<input type="text" id="addr" value="" size="70" class="inp_out" placeholder="주소를 입력해 주세요">
	<span class="btn h22"><input type="button" value="좌표 검색" onclick="goChk();return false;"></span>
	<div id="clickLatlng"></div>
	<div id="map" style="width:500px;height:400px;"></div>
	</form>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
	<script>
	
	
	function goChk(){
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(35.82406050330023, 127.14816812319762), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
		var addr = document.getElementById("addr").value;
		var mapContainer = document.getElementById("map");
		var coord = document.getElementById("clickLatlng");
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		//주소로 좌표 검색
		geocoder.addressSearch(addr, function(result, status) {
		
		
			// 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        
		        var latlng = new kakao.maps.LatLng(result[0].y, result[0].x); 

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		        
 		        var message = "<input type='hidden' name='contentsLatitude' value='"  + latlng.getLat() + "' > ";
		        message += " <input type='hidden' name='contentsLongitude' value='" + latlng.getLng() + "' >";
		        
		        var resultDiv = document.getElementById('clickLatlng'); 
		        resultDiv.innerHTML = message; 
		        
		    } 
		}); 
	}
	
	
	       
	</script>
</div>
<input type="button" value="등록" onclick="goWrite()">
</body>
</html>