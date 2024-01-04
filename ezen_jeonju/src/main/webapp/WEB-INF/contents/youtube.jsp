<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/youtube.css">
    <script src="https://code.jquery.com/jquery-3.1.0.js"></script>
    <title>Insert title here</title>
</head>
<body>
    <script type="text/javascript">
        $(document).ready(function () {
            // 가져올 때 navbar.css도 같이 가져올 것
            $('#headers').load("../nav/nav.jsp");
            $('#footers').load("../nav/footer.jsp");
        });
    </script>
<div id="headers"></div>

<br><br><br>

<div class="innerwrap">
	<h3>전주 영상</h3>
</div>
<div class="inner">
	<div class="innerList">
        <div class="total_cnt" id="total_cnt">전체&nbsp;</div>
        <table class="video-table" id="results"></table>
        <div class="innerwrap">
        	<a class="pagination" id="pagination"></a>
        </div>
    </div>
</div>    
<div id="footers"></div>
    
    <script src="https://apis.google.com/js/api.js"></script>

    <script>
    	var page = ${page};
        // API 키 설정
        const API_KEY = 'AIzaSyBpmtMGQU3gyt4rQFHvFFSQugosfSlEykg';

        // 클라이언트 라이브러리 초기화
        gapi.load('client', init);

        function init() {
            // YouTube API 클라이언트 초기화
            gapi.client.init({
                apiKey: API_KEY,
                discoveryDocs: ["https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest"],
            }).then(() => {
                // 최초 데이터 호출
                getPlaylistItems();
            });
        }

        function getPlaylistItems() {
            // 플레이리스트 아이디 설정
            const PLAYLIST_ID = 'PL1GT5AS9KmUeXAxHkPeW3-fyFj9pKL00O';
            const maxResults = 50;
            // API 호출하여 플레이리스트의 아이템 목록 가져오기
            gapi.client.youtube.playlistItems.list({
                part: 'snippet',
                playlistId: PLAYLIST_ID,
                maxResults: maxResults,
                order: 'date',
            }).then(response => {
                const playlistItems = response.result.items;
                playlistItems.reverse();
                if (playlistItems) {

                	playlistItems.forEach(item => {
                        console.log(item.snippet.publishedAt);
                    });
                	
                	
                	let tableRows = '';
                    let tableCell = '';
                    var size = playlistItems.length;
                    var total_cnt = "<span> "+size+" </span>건";
                    $('#total_cnt').append(total_cnt);
			    	console.log("size: "+size);
			    	var totalpage = Math.ceil(size/12);
			    	console.log("totalpage: "+totalpage);
					var startnum = (page - 1)*12;
					var endnum = startnum + 11;
			    	console.log("startnum: "+startnum);
			    	console.log("endnum: "+endnum);
                    for (let i = startnum; i <= endnum; i++) {
                    	if (i < size) {
	                        const playlistItem = playlistItems[i];
	                        // 각 아이템에서 제목, 썸네일 및 영상 링크 가져오기
	                        const videoTitle = playlistItem.snippet.title;
	                        const thumbnailUrl = playlistItem.snippet.thumbnails.maxres.url;
	                        const videoId = playlistItem.snippet.resourceId.videoId;
	                        const videoLink = 'https://www.youtube.com/watch?v=' + videoId;
	
	                        // 테이블에 추가할 HTML 생성
	                        tableCell += '<td><div><a href="' + videoLink + '" target="_blank"><img class="video-thumbnail" src="'
	                            + thumbnailUrl + '" alt="' + videoTitle + '"></a><p>' + videoTitle + '</p></div></td>';
	                        if ((i+1) % 4 === 0) {
	                            // 각 행의 시작에 새로운 <tr> 추가
	                            tableRows += '<tr>' + tableCell + '</tr>';
	                            tableCell = ''; // 행 초기화
	                        }
	                    
                    	}else{
                    		break;
                    	}
                    }

                    // 마지막 행에 추가된 셀이 있을 경우 추가
                    if (tableCell !== '') {
                        tableRows += '<tr>' + tableCell + '</tr>';
                    }

                    // 테이블에 동영상 추가
                    $('#results').html(tableRows);
                    generatePagination(totalpage);
                } else {
                    console.error('No playlist items found.');
                }
            }, error => {
                console.error('Error fetching playlist items:', error);
            });
        }
        function generatePagination(totalpage) {
            const paginationElement = $('#pagination');
            paginationElement.empty();
			var pageLink = "";
            for (let i = 1; i <= totalpage; i++) {
            	if(page==i){
	                pageLink = '<a class="active" href="<%=request.getContextPath()%>/contents/youtube.do?page=' + i + '">' + i + '</a>';
            	}else{
	                pageLink = '<a href="<%=request.getContextPath()%>/contents/youtube.do?page=' + i + '">' + i + '</a>';
            	}
                paginationElement.append(pageLink);
            }
        }
    </script>
</body>
</html>