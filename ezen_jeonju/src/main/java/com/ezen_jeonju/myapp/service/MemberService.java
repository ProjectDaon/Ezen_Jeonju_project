package com.ezen_jeonju.myapp.service;

import com.ezen_jeonju.myapp.domain.GoogleInfResponse;
import com.ezen_jeonju.myapp.domain.KakaoDTO;
import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.domain.NaverDTO;

public interface MemberService {
	public int memberIdCheck(String memberId);
	public int memberInsert(MemberVo mv);
	public MemberVo memberLogin(String memberId);
	
	public int memberIdCheckKakao(String memberId);
	public int KakaoMemberInsert(KakaoDTO kd);
	public MemberVo KakaoMemberLogin(String memberId);
	
	public int memberIdCheckNaver(String memberId);
	public int NaverMemberInsert(NaverDTO nd);
	public MemberVo NaverMemberLogin(String memberId);
	
	public int memberIdCheckGoogle(String memberId);
	public int GoogleMemberInsert(GoogleInfResponse gr);
	public MemberVo GoogleMemberLogin(String memberId);
}
