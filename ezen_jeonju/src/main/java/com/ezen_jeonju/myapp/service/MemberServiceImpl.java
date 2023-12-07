package com.ezen_jeonju.myapp.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.MemberVo;
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

}
