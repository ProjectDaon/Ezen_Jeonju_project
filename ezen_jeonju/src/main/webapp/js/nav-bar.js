$(document).ready(function () {
    $('.dep').mouseover(function () {
        $(this).addClass('active');
        var result=$(this).find('.dep-inner').css('display','block');
    });
    $('.dep').mouseleave(function () {
        $(this).removeClass('active');
        var result=$(this).find('.dep-inner').css('display','none');
    });
});
