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
	    const maxResults = 4;  // 나타내고 싶은 동영상의 최대 수
	
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
	            let str = '';
	
	            for (let i = 0; i < Math.min(maxResults, playlistItems.length); i++) {
	                const playlistItem = playlistItems[i];
	                // 각 아이템에서 제목, 썸네일 및 영상 링크 가져오기
	                const videoTitle = playlistItem.snippet.title;
	                const thumbnailUrl = playlistItem.snippet.thumbnails.maxres.url;
	                const videoId = playlistItem.snippet.resourceId.videoId;
	                const videoLink = 'https://www.youtube.com/watch?v=' + videoId;
	
	                // 테이블에 추가할 HTML 생성
	                str += '<li><a href="' + videoLink + '" target="_blank"><div><img src="'
	                    + thumbnailUrl + '" alt="' + videoTitle + '"><p>' + videoTitle + '</p></div></a></li>';
	            }
	
	            // 테이블에 동영상 추가
	            $('.video-list').html(str);
	        } else {
	            console.error('No playlist items found.');
	        }
	    }, error => {
	        console.error('Error fetching playlist items:', error);
	    });
	}