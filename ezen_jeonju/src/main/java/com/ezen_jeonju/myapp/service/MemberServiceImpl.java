package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.GoogleInfResponse;
import com.ezen_jeonju.myapp.domain.KakaoDTO;
import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.domain.NaverDTO;
import com.ezen_jeonju.myapp.persistance.MemberService_Mapper;

@Service
public class MemberServiceImpl implements MemberService{
	
	private MemberService_Mapper msm;
	
	@Autowired
	public MemberServiceImpl(SqlSession sqlSession) {
		this.msm = sqlSession.getMapper(MemberService_Mapper.class);
	}
	
	@Override
	public int memberIdCheck(String memberId) {
		int value = 0;
		value = msm.memberIdCheck(memberId);
		return value;
	}

	@Override
	public int memberInsert(MemberVo mv) {
		int value = 0;
		value = msm.memberInsert(mv);
		return value;
	}

	@Override
	public MemberVo memberLogin(String memberId) {
		MemberVo mv = null;
		mv = msm.memberLogin(memberId);
		return mv;
	}
	
	@Override
	public ArrayList<MemberVo> findId(String memberEmail) {
		ArrayList<MemberVo> mv = msm.findId(memberEmail);
		return mv;
	}
/*----------------------카카오----------------------------*/
	@Override
	public int memberIdCheckKakao(String memberId) {
		//아이디 여부 체크
		int value = msm.memberIdCheckKakao(memberId);
		return value;
	}

	@Override
	public int KakaoMemberInsert(KakaoDTO kd) {
		//카카오 회원 등록
		int value = msm.KakaoMemberInsert(kd);
		return value;
	}

	@Override
	public MemberVo KakaoMemberLogin(String memberId) {
		//카카오 회원 로그인(for 세션저장)
		MemberVo mv = msm.KakaoMemberLogin(memberId);
		return mv;
	}
/*--------------------------------------------------------*/
	
/*---------------------네이버-------------------------------*/
	@Override
	public int memberIdCheckNaver(String memberId) {
		//아이디 여부 체크
		int value = msm.memberIdCheckNaver(memberId);
		return value;
	}

	@Override
	public int NaverMemberInsert(NaverDTO nd) {
		//네이버 회원 등록
		int value = msm.NaverMemberInsert(nd);
		return value;
	}

	@Override
	public MemberVo NaverMemberLogin(String memberId) {
		MemberVo mv = msm.NaverMemberLogin(memberId);
		return mv;
	}
	
/*--------------------------------------------------------*/

/*---------------------구글-------------------------------*/

	@Override
	public int memberIdCheckGoogle(String memberId) {
		int value = msm.memberIdCheckGoogle(memberId);
		return value;
	}

	@Override
	public int GoogleMemberInsert(GoogleInfResponse gr) {
		int value = msm.GoogleMemberInsert(gr);
		return value;
	}

	@Override
	public MemberVo GoogleMemberLogin(String memberId) {
		MemberVo mv = msm.GoogleMemberLogin(memberId);
		return mv;
	}

	@Override
	public int checkInfo(MemberVo mv) {
		int value = msm.checkInfo(mv);
		return value;
	}

	@Override
	public int changePwd(MemberVo mv) {
		int value = msm.changePwd(mv);
		return value;
	}

	
	
}
