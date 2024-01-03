function pwcheck(){
	var pw = $('input[name="memberPwd"]').val();
	var pw2 = $('input[name="memberPwd2"]').val();
	var num = pw.search(/[0-9]/g);
	var eng = pw.search(/[a-z]/ig);
    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
    if(pw.length < 8 || pw.search(/\s/) != -1 || num < 0 || eng < 0 || spe < 0 ){
		$('#pass-info').text('※ 영문, 숫자, 특수기호 포함 8자 이상').css('color','red');
    }else{
		$('#pass-info').text('check').css('color','green');
    }
    

	if(pw == pw2){
		$('#pass-check-info').text('check').css('color','green');
	}else{
		$('#pass-check-info').css('display','inline-block');
		$('#pass-check-info').text('비밀번호 불일치').css('color','red');
	}
}

