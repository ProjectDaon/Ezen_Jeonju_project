<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script src="../js/contentsArticle.js"></script> 
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/contentsArticle.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
</head>
<body>
<script type="text/javascript">
var cidx = ${cv.cidx};

$(document).ready(function(){



	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
	
	/*좋아요 체크*/
	likeCheck();
	
	/*리뷰창 로딩*/
	$('#tab2').click(function(){
		reviewList();
	});
	
	/*리뷰글쓰기창 열기*/
	$('#revWrite').click(function(){
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/review/loginCheck.do",
			dataType : "json",
			cache : false,
			success : function(data){
				if(data.txt === "pass"){
					$('#writeReview').css('display','block');
				}else{
					alert(data.txt);
				}
			},
			error : function(){
				alert("통신오류 실패");
			}		
		});
		
	});
	
	$('#tab3').click(function(){
		blogReviewLead();
	});
	
	$("#loadMoreBtn").click(function () {
	    blogReviewLead();
	});
});
function likeCheck(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/contentsLike/contentsLikeCheck.do",
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			if(data.value != 0){
				$('.ck').attr('class','ck-on');
			}else{
				$('.ck-on').attr('class','ck');
			}
			$('#likeCnt').html(data.likeCount);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function likeThis(event){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/contentsLike/contentsLike.do",
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			alert(data.value);
			likeCheck();
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewWrite(){
	var fm = document.rev_frm;
	var score = fm.reviewScore.value;
	var article = fm.reviewArticle.value;
	
	if(score == ""){
		alert("별점을 등록해주세요");
		return;
	}else if(article == ""){
		alert("리뷰 내용을 작성해주세요");
		fm.reviewArticle.focus();
		return;
	}
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewWrite.do",
		dataType : "json",
		data : {
				"cidx" : cidx,
				"reviewScore" : score,
				"reviewArticle" : article
		},
		cache : false,
		success : function(data){
			if(data.txt === "pass"){
				alert("글쓰기 완료");
				$('#writeReview').css('display','none');
				reviewList();
			}else{
				alert(data.txt);
			}
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewList(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewList.do",
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			reviewListPrint(data.list);
			reviewPaging(data.pm);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewListPaging(page){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewList.do?page="+page,
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			reviewListPrint(data.list);
			reviewPaging(data.pm);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewListPrint(data){
	var str = "";
	var delbtn = "";
	var loginMidx="${sessionScope.midx}";
	
	$(data).each(function(){
		if(loginMidx==this.midx){
			delbtn = "<button class='delBtn' onclick='reviewDel("+this.ridx+")'>삭제</button>";
		}else{
			delbtn= "";
		}
		str = str+"<tr><td class='rev-writer'><div class='writer-wrap'><div class='rev-name'>"+this.memberName
			+"</div><div class='rev-date'>"+this.reviewWriteday
			+"</div><div class='rev-score'><img src='../images/rev-starOn.png'><div style='margin-left: 5px'>"+this.reviewScore
			+"</div></div></div></td><td class='rev-contents'>"+this.reviewArticle
			+"</td><td class='rev-del'>"+delbtn+"</td></tr>";
	});
	
	str = "<table class='listTable'>"+str+"</table>"
	
	$('#reviewTable').html(str);
	return;
}
function reviewPaging(data){
	var paging = "";
	if(data.prev == true){
		paging = paging + "<a class='pagePreview' href='#' onclick='reviewListPaging("+data.startPage-1+")'>이전</a>";
	}
	//var nowpage = data.cscri.page/9+1;
	for(var i=data.startPage; i<=data.endPage; i++){
		paging = paging + "<a class='pageNumber' href='#' onclick='reviewListPaging("+i+")'>"+i+"</a>";
	}
	if(data.next == true && data.endPage>0){
		paging = paging + "<a class='pageNext' href='#' onclick='reviewListPaging("+(data.endPage+1)+")'>다음</a>";
	}
	$('#paging').html(paging);
}
function reviewDel(ridx){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewDel.do",
		dataType : "json",
		data : {
				"ridx" : ridx
		},
		cache : false,
		success : function(data){
			if(data.txt === "pass"){
				alert("댓글 삭제 완료");
				reviewList();
			}else{
				alert(data.txt);
			}
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}

	var start = 4; // 시작 인덱스
	var batchSize = 5; // 한 번에 보여줄 항목의 개수
function blogReviewLead() {
	
    var subject = "전주 ${cv.contentsSubject}";
    $.ajax({
        type: "post",
        url: "${pageContext.request.contextPath}/review/blogReview.do",
        dataType: "json",
        data: {
            "subject": subject
        },
        cache: false,
        success: function (data) {
            displayBlogItems(data);
        },
        error: function () {
            alert("통신 오류 실패");
        }
    });
}

function displayBlogItems(data) {
    var txt = "";
    var end = Math.min(start + batchSize, data.url.length);

    for (var i = start; i < end; i++) {
        txt += "<a href='" + data.url[i] + "'>"
            + "<div class='blogCon'>"
            + "<div class='blogName'>" + data.blogname[i] + "</div>"
            + "<div class='blogSubject'>" + data.title[i] + "</div>"
            + "<div class='blogContents'>" + data.contents[i] + "</div>"
            + "</div>"
            + "</a>";
    }

    $(".blogList").append(txt);
    start = end;

    // 더 불러올 데이터가 있는 경우에만 "더 보기" 버튼을 표시
    if (start < data.url.length) {
        $("#loadMoreBtn").show();
    } else {
        $("#loadMoreBtn").hide();
    }
}

// "더 보기" 버튼 클릭 시 추가 항목 불러오기

</script>
<div id="headers"></div>
<div class="contents">
	<div class="title">
		<h4>${cv.contentsSubject}</h4>
<a class="modifylink" href="${pageContext.request.contextPath}/contents/contentsModify.do?cidx=${cv.cidx}">수정하기</a>
	</div>
	<div class="mainImg">
		<img src="${pageContext.request.contextPath}/imageLoading.do?aidx=${cv.aidx}" />
	</div>
	<div class="actionUserBar">
		<ul class="left">
			<li>평점 &nbsp<img src="../images/starimg.jpg">&nbsp ${csd.starAverage} </li>
			<li>조회 &nbsp<strong>${cv.contentsViewCount}</strong></li>
			<li>리뷰 <strong>${csd.reviewCount}</strong></li>
		</ul>
		<div class="right">
			<a href="#actionUserBar" onclick="likeThis(event);" class="ck">좋아요 (<span id="likeCnt"></span>)</a>
		</div>
	</div>
	<div>
		<h2>해시태그</h2>
		<ul class="listul">
		    <c:forEach var="item" items="${hashtag}">
		        <li class="listli">#${item.value}</li>
		    </c:forEach>
		</ul>
	</div>
	<div class="tabSection">
		<div class="tab-wrap">
			<ul id="tablist" class="tab innerwrap">
				<li class="on" id="tab1"><button>상세정보</button></li>
				<li id="tab2"><button>리뷰</button></li>
				<li id="tab3"><button>블로그리뷰</button></li>
			</ul>
		</div>
		<div class="tab-con innerwrap" id="tab_con">
			<div class="con-det">
				${cv.contentsArticle}
				<div id="map" style="width:500px;height:400px;"></div>
				<input type="hidden" id="latitude" value="${cv.contentsLatitude}">
				<input type="hidden" id="longitude" value="${cv.contentsLongitude}">
			</div>
			<div class="con-review" style="display:none">
				<div class="revHead">
					<div class="title">여행후기</div>
					<a href="#" class="write" id="revWrite"><span>리뷰작성하기</span></a>
				</div>
				<div class="revList" id="revList">
					<div id="reviewTable"></div>
					<div class="paging" id="paging"></div>
				</div>
			</div>
			<div class="con-blog" style="display:none">
				<div class="revHead">
					<div class="title">블로그리뷰</div>
				</div>
				<div class="blogList">
				</div>
				<button id="loadMoreBtn">더 보기</button>
			</div>
		</div>
	</div>
	<div id="writeReview" class="writeReview" style="display:none">
	<div class="writeReview-wrap">
		<div class="writeReview-header">
			<h5 class="modal-title" style="color: #fff;font-size: 1.3rem;">리뷰 등록</h5>
		</div>
		<form name="rev_frm">
			<div class="rev-container">
			<table class="rev-contb">
				<colgroup>
					<col style="width: 15%">
					<col style="width: 85%">
				</colgroup>
				<tbody>
					<tr>
						<th>리뷰장소</td>
						<td>${cv.contentsSubject}</td>
					</tr>
					<tr>
						<th>평가</td>
						<td>
							<div id="rev_star_grade" class="rev-starGrade">
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<input type="hidden" name="reviewScore" id="reviewScore"  value="">
							</div>
						</td>
					</tr>
					<tr>
						<th>리뷰내용</th>
						<td>
							<div class="rev-text">
								<textarea rows="4" cols="50" maxlength="1000" id="reviewArticle" name="reviewArticle"></textarea>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</form>
		<div class="writebtn">
			<a href="#" class="rev-basic" onclick="reviewWrite();">등록</a>
			<a href="#" class="rev-cc" id="rev-cc">취소</a>
		</div>
		</div>
	</div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
<script>
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var latitude = document.getElementById('latitude').value;
    var longitude = document.getElementById('longitude').value;
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
		level: 2 //지도의 레벨(확대, 축소 정도)
		};
	var map = new kakao.maps.Map(container, options);

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
</script>

</div>
<div id="footers"></div>
</body>
</html>