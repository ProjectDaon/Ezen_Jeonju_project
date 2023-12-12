package com.ezen_jeonju.myapp.persistance;

import com.ezen_jeonju.myapp.domain.KakaoDTO;
import com.ezen_jeonju.myapp.domain.MemberVo;

public interface MemberService_Mapper {
	public int memberIdCheck(String memberId);
	public int memberInsert(MemberVo mv);
	public MemberVo memberLogin(String memberId);
	public int memberIdCheckKakao(String memberId);
	public int KakaoMemberInsert(KakaoDTO kd);
}
