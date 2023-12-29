package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.MypageDTO;
import com.ezen_jeonju.myapp.domain.ReviewCriteria;
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

	@Override
	public ArrayList<MypageDTO> reviewList(ReviewCriteria rcri) {
		int value = (rcri.getPage()-1)*5;
		rcri.setPage(value);
		
		ArrayList<MypageDTO> list = new ArrayList<>();
		list = msm.reviewList(rcri);
		return list;
	}

	@Override
	public int reviewDelete(int ridx) {
		int value = msm.reviewDelete(ridx);
		return value;
	}

	@Override
	public int reviewTotalCnt(int midx) {
		int value = msm.reviewTotalCnt(midx);
		return value;
	}

}
