<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/youtube.css">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
	$(document).ready( function() {
		//가져올때 navbar.css도 같이 가져올 것
		$('#headers').load("../nav/nav.jsp");
	
	});
	</script>
	<div id="headers"></div>

	<div class="container">
		<h1>Videos list</h1>
		<table class="video-table" id="results"></table>
		<ul class="pagination" id="pagination"></ul>
	</div>
	<script src="https://apis.google.com/js/api.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	    <script>
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
                // API 초기화가 완료된 후에 실행할 함수 호출
                getPlaylistItems();
            });
        }

        function getPlaylistItems(pageToken) {
            // 플레이리스트 아이디 설정
            const PLAYLIST_ID = 'PL1GT5AS9KmUeXAxHkPeW3-fyFj9pKL00O';
			const maxResults = 50;
            // API 호출하여 플레이리스트의 아이템 목록 가져오기
            gapi.client.youtube.playlistItems.list({
                part: 'snippet',
                playlistId: PLAYLIST_ID,
                maxResults: maxResults,
                pageToken: pageToken,// 가져올 아이템의 최대 개수
            }).then(response => {
                const playlistItems = response.result.items;

                if (playlistItems) {
                	let tableRows = '';
                    let tableCell = '';
                	
                    for (let i = 0; i < playlistItems.length; i++) {
                        if (i % 4 === 0) {
                            // 각 행의 시작에 새로운 <tr> 추가
                            tableRows += '<tr>'+tableCell+'</tr>';
                            tableCell = ''; // 행 초기화
                        }

                        const playlistItem = playlistItems[i];
                        // 각 아이템에서 제목, 썸네일 및 영상 링크 가져오기
                        const videoTitle = playlistItem.snippet.title;
                        const thumbnailUrl = playlistItem.snippet.thumbnails.maxres.url;
                        const videoId = playlistItem.snippet.resourceId.videoId;
                        const videoLink = 'https://www.youtube.com/watch?v='+videoId;
                        
                        // 테이블에 추가할 HTML 생성
                        tableCell += '<td><p>'+videoTitle+'</p><a href="'+videoLink+'" target="_blank"><img class="video-thumbnail" src="'
                        		   +thumbnailUrl+'" alt="'+videoTitle+'"></a></td>';
                    }

                    // 마지막 행에 추가된 셀이 있을 경우 추가
                    if (tableCell !== '') {
                        tableRows += '<tr>'+tableCell+'</tr>';
                    }

                    // 테이블에 동영상 추가
                    $('#results').append(tableRows);
                    
                    updatePagination(response.result.prevPageToken, response.result.nextPageToken);
                } else {
                    console.error('No playlist items found.');
                }
            }, error => {
                console.error('Error fetching playlist items:', error);
            });
        }
        
        function updatePagination(prevPageToken, nextPageToken) {
            const paginationElement = $('#pagination');
            paginationElement.empty();

            if (prevPageToken) {
                paginationElement.append(`<li onclick="getPlaylistItems('${prevPageToken}')">Previous</li>`);
            }

            if (nextPageToken) {
                paginationElement.append(`<li onclick="getPlaylistItems('${nextPageToken}')">Next</li>`);
            }
        }
    </script>
</body>
</html>