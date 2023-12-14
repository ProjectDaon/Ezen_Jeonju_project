$(document).ready(function(){

    $('.main-slide-img').slick({
		pauseOnHover: true,
    	infinite: true,
    	fade: true,
        autoplay: true,
        autoplaySpeed: 3000,
        asNavFor: '.main-slide-text'
    });

    $('.main-slide-text').slick({
		pauseOnHover: true,
        autoplay: true,
        autoplaySpeed: 3000,
        slideToShow: 1,
        slideToScroll: 1,
        vertical : true,
        verticalSwiping : true,
        arrows: false,
        asNavFor: '.main-slide-img'

    });
    
	$('.main-slide-text').on('afterChange', function(event, slick, currentSlide){
		// 현재 슬라이드 번호와 전체 슬라이드 개수를 가져옵니다.
		var currentSlideNumber = currentSlide + 1;
		var totalSlides = slick.slideCount;
  
		// 페이지 번호 업데이트
		$('.main-current-num').text(currentSlideNumber);
		$('.main-total-num').text(totalSlides);
	  });
    
	$('.main')


	$('.second-slide-2').slick({
		pauseOnHover: true,
		autoplay: true,
		autoplaySpeed: 3000,
		centerMode: true,
		centerPadding: '60px',
		slidesToShow: 3.7,
		responsive: [
		  {	
			breakpoint: 1500,
			settings: {
			  centerMode: true,
			  centerPadding: '40px',
			  slidesToShow: 3
			}
		  },
		  {
			breakpoint: 480,
			settings: {
			  arrows: false,
			  centerMode: true,
			  centerPadding: '40px',
			  slidesToShow: 1
			}
		  }
		]
	  });



	
	$('.aaa').click(function(){
    $('.second-slide-img').slick('slickPause');
});

});
