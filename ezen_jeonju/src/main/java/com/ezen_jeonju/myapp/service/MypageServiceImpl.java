package com.ezen_jeonju.myapp.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.persistance.MypageService_Mapper;

@Service
public class MypageServiceImpl implements MypageService{

	private MypageService_Mapper msm;
	
	@Autowired
	public MypageServiceImpl(SqlSession sqlSession) {
		this.msm = sqlSession.getMapper(MypageService_Mapper.class);
	}
	
	@Override
	public String getMemberPhone(int midx) {
		String memberPhone = "";
		memberPhone = msm.getMemberPhone(midx);
		return memberPhone;
	}

}
