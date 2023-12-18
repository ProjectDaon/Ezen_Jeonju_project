<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Insert title here</title>
    <link rel="stylesheet" href="./css/navbar.css">
    <link rel="stylesheet" href="./css/mainhome.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon-32x32.png">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>

<body>
<script src="./js/nav-bar.js"></script>
<script>
function toggleMenu() {
    var test = document.getElementById("test");
    var submenus = test.querySelectorAll(".menu-hamburger-list ul");

    // 메뉴 토글
    test.style.display = (test.style.display === "none" || test.style.display === "") ? "block" : "none";

    // 메뉴가 숨겨질 때 하위 메뉴들을 모두 감추기
    if (test.style.display === "none") {
        submenus.forEach(function(submenu) {
            submenu.style.display = "none";
        });
    }
}
    // 브라우저 창 크기 변화 감지   
    window.addEventListener('resize', function() {
        var test = document.getElementById("test");
    
    // 창 크기가 1200px 이상인 경우
        if (window.innerWidth > 1200) {
            test.style.display = "none";
        }
    });

    function toggleSubMenu(submenuClassName) {
    var submenus = document.querySelectorAll(".menu-hamburger-list ul");
    
    submenus.forEach(function(submenu) {
        if (submenu.className === submenuClassName) {
            submenu.style.display = (submenu.style.display === "none" || submenu.style.display === "") ? "block" : "none";
        } else {
            submenu.style.display = "none";
        }
    });
}

    // 클릭 이벤트 처리
    document.addEventListener('DOMContentLoaded', function() {
        var submenu1 = document.querySelector(".submenu-title-1");
        var submenu2 = document.querySelector(".submenu-title-2");
        var submenu3 = document.querySelector(".submenu-title-3");

        document.querySelector(".submenu-title-1").addEventListener("click", function() {
            toggleSubMenu("submenu-title-1");
        });

        document.querySelector(".submenu-title-2").addEventListener("click", function() {
            toggleSubMenu("submenu-title-2");
        });

        document.querySelector(".submenu-title-3").addEventListener("click", function() {
            toggleSubMenu("submenu-title-3");
        });
    });

    
</script>

<header class="navigation" id="navigation">
    <nav class="nav-bar">
        <h1>
            <a href="index.jsp">
                <img src="images/logo.png">
            </a>
        </h1>
        <div class="menu-wrap">
            <ul class="menu-element">
                <li class="dep">
                    <a href="<%=request.getContextPath()%>/contents/sightList.do">전주에가면</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">전주에가면</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="<%=request.getContextPath()%>/contents/sightList.do">명소</a></li>
                            <li><a href="<%=request.getContextPath()%>/contents/foodList.do">음식</a></li>
                            <li><a href="#">영상</a></li>
                        </ul>
                    </div>
                </li>
                <li class="dep">
                    <a href="<%=request.getContextPath()%>/schedule/scheduleList.do">여행일정</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">여행일정</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="<%=request.getContextPath()%>/schedule/scheduleList.do">여행공유</a></li>
                        </ul>
                    </div>
                </li>
                <li class="dep">
                    <a href="<%=request.getContextPath()%>/notice/noticeList.do">공지사항</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">공지사항</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="#">공지</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <div class="my-menu-element">
            <div class="login-element">
                <%if(session.getAttribute("midx")==null){%>
                <a class="login" href="<%=request.getContextPath()%>/member/memberLogin.do">로그인</a>
                <%} else{ %>
                <a href="<%=request.getContextPath()%>/member/memberLogout.do">로그아웃</a>
                <%} %>
                <a href="<%=request.getContextPath()%>/mypage/userMypage.do">마이페이지</a>
            </div>
        </div>
        <div class="menu-hamburger" onclick="toggleMenu()">
            <i class="xi-bars"></i>
        </div>
    </nav>
        <div class="test" id="test">
            <div class="login-box">
                <%if(session.getAttribute("midx")==null){%>
                <a class="login" href="<%=request.getContextPath()%>/member/memberLogin.do">로그인</a>
                <%} else{ %>
                <a href="<%=request.getContextPath()%>/member/memberLogout.do">로그아웃</a>
                <%} %>
                <a href="<%=request.getContextPath()%>/mypage/userMypage.do">마이페이지</a>
            </div>
            <div class="menu-hamburger-list">
                <div class="menu-list-wrap">
                    <div class="menu-title" onclick="toggleSubMenu('submenu-title-1')">
                        <p>전주에가면</p>
                    </div>
                    <ul class="submenu-title-1">
                        <li><a href="<%=request.getContextPath()%>/contents/sightList.do">명소</a></li>
                        <li><a href="<%=request.getContextPath()%>/contents/foodList.do">음식</a></li>
                        <li><a href="#">영상</a></li>
                    </ul>
                </div>
                <div class="menu-list-wrap">
                    <div class="menu-title" onclick="toggleSubMenu('submenu-title-2')">
                        <p>여행일정</p>
                    </div>
                    <ul class="submenu-title-2">
                        <li><a href="<%=request.getContextPath()%>/schedule/scheduleList.do">여행공유</a></li>
                    </ul>
                </div>
                <div class="menu-list-wrap">
                    <div class="menu-title" onclick="toggleSubMenu('submenu-title-3')">
                        <p>공지사항</p>
                    </div>
                    <ul class="submenu-title-3">
                        <li><a href="#">공지</a></li>
                    </ul>
                </div>
            </div>
        </div>
 
</header>

<div class="main-contents">
    <section class="first-visual">
        <div class="first-visual-list">
            <div><a href="#"><img class="first-visual-img" src="images/1920785.jpg"></a></div>
            <div><a href="#"><img class="first-visual-img" src="images/1920785.jpg"></a></div>
            <div><a href="#"><img class="first-visual-img" src="images/1920785.jpg"></a></div>
        </div>
        <div class="first-text">
            <div class="first-text-list">
                <div><a href="#"><p class="slide-txt">텍스트는 상자입니다. 아닙니다. 상자가 아닌 글자입니다. </p></a></div>
                <div><a href="#"><p class="slide-txt">텍스트는 상자입니다. 아닙니다. 상자가 아닌 글자입니다. </p></a></div>
                <div><a href="#"><p class="slide-txt">텍스트는 상자입니다. 아닙니다. 상자가 아닌 글자입니다. </p></a></div>
                <div><a href="#"><p class="slide-txt">텍스트는 상자입니다. 아닙니다. 상자가 아닌 글자입니다. </p></a></div>
            </div>
            <div class="first-control">
                <div class="page">
                    <span class="first-current-num"></span>
                    <span>/</span>
                    <span class="first-total-num"/></span>
                </div>  
                <div class="btn-area">
                    <button class="btn-prev" type="button">
                        <i class="xi-angle-left-thin"></i>
                    </button>
                    <button id="btn-pause" type="button">
                        <i class="xi-pause"></i>
                    </button>
                    <button id="btn-play" type="button">
                        <i class="xi-play"></i>
                    </button>
                    <button class="btn-next" type="button">
                        <i class="xi-angle-right-thin"></i>
                    </button>    
                </div>
            </div>
            <div class="admin-click">
                <div><a class="btn-more" href="#"><span>배너등록 +</span></a></div>
            </div>
        </div>
    </section>
    <section class="second-visual">
        <div class="title-section">
            <h2>
                <span class="title1">지금 전주는</span>
                <span class="title2">어디가 좋을까?</span>
            </h2>
        </div>
        <div class="second-visual-list">
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-1.jpg"></div><p class="slide-txt">이거되냐고</p></a></div>
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-2.jpg"></div><p class="slide-txt">이거되냐고2</p></a></div>
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-1.jpg"></div><p class="slide-txt">이거되냐고3</p></a></div>
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-2.jpg"></div><p class="slide-txt">이거되냐고4</p></a></div>
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-1.jpg"></div><p class="slide-txt">길게되는건지 적당히만 하자</p></a></div>
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-2.jpg"></div><p class="slide-txt">길게되는건지 적당히만 하자</p></a></div>
            <div><a href="#"><div class="thumbnail"><img class="thumbnail-img" src="images/417320-1.jpg"></div><p class="slide-txt">길게되는건지 적당히만 하자</p></a></div>
        </div>
    </section>
    <section class="third-visual">
        <div class="inner">
            <div class="title-section">
                <h2>
                    <span class="title1">전주 인기 여행 TOP3</span>
                </h2>
            </div>
            <div class="hot3-list">
                <div class="hot-item">  
                    <a href="#">
                        <div class="box-wrap">
                            <div class="box-img">
                                <img src="images/417320-1.jpg" alt="">
                            </div>
                        </div>
                        <p class="tit">이색체험 어쩌구 저쩌구</p>
                    </a>
                </div>
                <div class="hot-item">
                    <a href="#">
                        <div class="box-wrap">
                            <div class="box-img">
                                <img src="images/417320-2.jpg" alt="">
                            </div>
                        </div>
                        <p class="tit">이색체험 어쩌구 저쩌구</p>
                    </a>
                </div>
                <div class="hot-item">
                    <a href="#">
                        <div class="box-wrap">
                            <div class="box-img">
                                <img src="images/417320-1.jpg" alt="">
                            </div>
                        </div>
                        <p class="tit">이색체험 어쩌구</p>
                    </a>
                </div>
            </div>
        </div>
    </section>
    <section class="exhibition">
        <div class="inner">
            <div class="title-wrap">
                <div class="sub-title">
                    <span>공연</span>
                    <span>행사</span>
                    <span>전시</span>
                    <a href="#"><span>더 보기 +</span></a>
                </div>
            </div>
            <div class="exhibition-list">
                <a href="#"><div><img src="images/400560.jpg"><p class="slide-txt">징그럽다 htmlzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz</p></div></a>
                <a href="#"><div><img src="images/400560.jpg"><p class="slide-txt">징그럽다 css</p></div></a>
                <a href="#"><div><img src="images/400560.jpg"><p class="slide-txt">태그지옥</p></div></a>
                <a href="#"><div><img src="images/400560.jpg"><p class="slide-txt">태그지옥</p></div></a>
            </div>
        </div>
    </section>
    <section class="video" style="background-image: url(images/1920480.jpg);">
        <div class="inner">
            <div class="title-section">
                <span class="title1">전주를 더 보고 싶다면?</span>
            </div>
            <div class="sns-list">
                <a href="#" class="youtube-icon">
                    <i class="xi-youtube-play"></i>
                </a>
                <a href="#" class="naver-icon">
                    <i class="xi-naver"></i>
                </a>
                <a href="#" class="instagram-icon">
                    <i class="xi-instagram"></i>
                </a>
                <a href="#" class="facebook-icon">
                    <i class="xi-facebook"></i>
                </a>
            </div>
            <div class="video-more">
                <div><a class="btn-more" href="#"><span>영상 등록 +</span></a></div>
            </div>
            <ul class="video-list">
                <li><a href="#"><div><img src="https://img.youtube.com/vi/YwC0m0XaD2E/mqdefault.jpg"><p class="slide-txt">인간극장 발표대장 다온</p></div></a></li>
                <li><a href="#"><div><img src="https://img.youtube.com/vi/YwC0m0XaD2E/mqdefault.jpg"><p class="slide-txt">인간극장 민정</p></div></a></li>
                <li><a href="#"><div><img src="https://img.youtube.com/vi/YwC0m0XaD2E/mqdefault.jpg"><p class="slide-txt">인간극장 대희</p></div></a></li>
                <li><a href="#"><div><img src="https://img.youtube.com/vi/YwC0m0XaD2E/mqdefault.jpg"><p class="slide-txt">인간극장 건도</p></div></a></li>
            </ul>           
        </div>
    </section>
</div>
<footer>
    <div class="inner">
	    <div class="footer-text">
	    	<p>
	    		(99999) 전라북도 전주시 이젠 개발자가 되고 싶어 대표전화 : 000)999-0000
	    	</p>
		   	<p>
			   	Copyright Ezen-Developer Team All rights  reserved
		   	</p>
    	</div>
   	</div>
</footer>

</body>
</html>
<script src="./js/mainhome.js"></script>