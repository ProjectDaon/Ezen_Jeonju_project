
$(document).ready( function() {
	
	/*상세정보,리뷰,블로그리뷰 이동*/
	$('#tablist li').click(function(e){
		var el = $(e.target).closest('li');
		el.siblings('li').removeClass("on");
		el.addClass("on");
		var id_check = el.attr("id");
		if(id_check === 'tab1'){
			$('.con-det').css('display','block');
			$('.con-map').css('display','none');
			$('.con-review').css('display','none');
			$('.con-blog').css('display','none');
		}else if(id_check === 'tab2'){
			$('.con-det').css('display','none');
			$('.con-map').css('display','block');
			$('.con-review').css('display','none');
			$('.con-blog').css('display','none');
			
		}else if(id_check === 'tab3'){
			$('.con-det').css('display','none');
			$('.con-map').css('display','none');
			$('.con-review').css('display','block');
			$('.con-blog').css('display','none');
			
		}else{
			$('.con-det').css('display','none');
			$('.con-map').css('display','none');
			$('.con-review').css('display','none');
			$('.con-blog').css('display','block');
		}
	});
	
	/*리뷰창닫기*/
	$('#rev-cc').click(function(){
		$('#writeReview').css('display','none');
	});
	
	/*리뷰쓰기-별점*/
	const ratingStars = [...document.getElementsByClassName("rating__star")];
	
	function executeRating(stars) {
		const starClassActive = "rating__star fas fa-star";
		const starClassInactive = "rating__star far fa-star";
		const starsLength = stars.length;
		let i;
	
		stars.map((star) => {
			star.onclick = () => {
				i = stars.indexOf(star);
	
				if(star.className === starClassInactive) {
					for(i; i>=0; --i) stars[i].className = starClassActive;
				}else {
					for(i; i<starsLength; ++i) stars[i].className = starClassInactive;
				}
			}
		});
	}
	
	executeRating(ratingStars);
	
	/*별점score*/
	$('.rating__star').click(function(){
		var n = $('.rating__star.fas').length;
		$('#reviewScore').val(n);
	});
});

