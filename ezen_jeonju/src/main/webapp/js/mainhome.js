$(document).ready(function(){

    $('#btn-play').hide();

    $('#btn-play').click(function(){
        $('.first-text-list').slick('slickPlay');
        $(this).hide();
        $('#btn-pause').show();
    });
     
    $('#btn-pause').click(function(){
        $('.first-text-list').slick('slickPause');
        $(this).hide();
        $('#btn-play').show();
    });



    $('.first-visual-list').slick({
    	infinite: true,
    	fade: true,
		arrows: false,
         asNavFor: '.first-text-list'
    });

    
    $('.first-text-list').slick({
        autoplay: true,
        autoplaySpeed: 3000,
        slideToShow: 1,
        slideToScroll: 1,
        vertical : true,
        verticalSwiping : true,
        asNavFor: '.first-visual-list',
    
        prevArrow : $('.btn-prev'), 
        nextArrow : $('.btn-next'),
        

    });
    

    // 초기에 페이지 번호 및 토탈 넘버 설정
    var initialCurrentSlide = $('.first-text-list').slick('slickCurrentSlide') + 1;
    var totalSlides = $('.first-text-list').slick('getSlick').slideCount;

    // 초기 페이지 번호 설정
    $('.first-current-num').text(initialCurrentSlide);
    // 초기 토탈 넘버 설정
    $('.first-total-num').text(totalSlides);

    // 슬라이더의 afterChange 이벤트 핸들러
    $('.first-text-list').on('afterChange', function (event, slick, currentSlide) {
        // 현재 슬라이드 번호를 가져옵니다.
        var currentSlideNumber = currentSlide + 1;

        // 페이지 번호 업데이트
        $('.first-current-num').text(currentSlideNumber);
    });



     function calculateSlidesToShow() {
	 	var viewportWidth = $(window).width();
	 	//console.log("뷰포트" + viewportWidth);
	
	
	 	// breakpoint가 1500 이하인 경우 이미지 넓이를 280으로 변경
	 	var imageWidth = 417;
        //console.log("이미지넓이" + imageWidth);


	 	var totalwidth = imageWidth;
        //console.log("토탈넓이" + totalwidth);

	
	 	// 반올림하여 소수점 한자리까지 표시
	 	var slidesToShow = Math.round(viewportWidth / totalwidth * 10) / 10;
	 	//console.log("개수" + slidesToShow);
	
	 	return slidesToShow;
	 }
	
	$('.second-visual-list').slick({
		pauseOnHover: true,
        autoplay: true,
		autoplaySpeed: 3000,
		centerMode: true,
		centerPadding: '60px',
		slidesToShow: calculateSlidesToShow()

	});
	
	$(window).on('resize', function () {
		$('.second-visual-list').slick('slickSetOption', 'slidesToShow', calculateSlidesToShow());
	});



});