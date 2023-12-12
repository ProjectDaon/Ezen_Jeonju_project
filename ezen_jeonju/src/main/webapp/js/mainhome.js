$(document).ready(function(){
    $('.main-slide-img').slick({
    	infinite: true,
    	fade: true,
        autoplay: true,
        autoplaySpeed: 2500,
        asNavFor: '.main-slide-text'
    });

    $('.main-slide-text').slick({
        autoplay: true,
        autoplaySpeed: 2500,
        slideToShow: 1,
        slideToScroll: 1,
        vertical : true,
        verticalSwiping : true,
        arrows: false,
        asNavFor: '.main-slide-img'

    });
    
    $('.main-slide-text').on('afterChange', function(event, slick, currentSlide){
        $('.main-current-num').text(currentSlide + 1);
    });
    
    
    $('.second-slide-img').slick({
		infinite: true,
		centerMode: true,
		centerPadding: '60px',
		slidesToShow: 4,
		arrows: false,
		autoplay: true,
		autoplaySpeed: 3000,
		prevArrow : $('.prevArrow'), 
		nextArrow : $('.nextArrow')
	});
 
});
