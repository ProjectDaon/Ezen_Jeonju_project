package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.MypageLikeCriteria;
import com.ezen_jeonju.myapp.domain.MypageReviewDTO;
import com.ezen_jeonju.myapp.domain.ReviewCriteria;
import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
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
	public ArrayList<MypageReviewDTO> reviewList(ReviewCriteria rcri) {
		int value = (rcri.getPage()-1)*5;
		rcri.setPage(value);
		
		ArrayList<MypageReviewDTO> list = new ArrayList<>();
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

	@Override
	public ArrayList<MypageLikeCriteria> likeList(MypageLikeCriteria mlcri) {
		int value = (mlcri.getPage()-1)*9;
		mlcri.setPage(value);
		
		ArrayList<MypageLikeCriteria> list = new ArrayList<>();
		list = msm.likeList(mlcri);
		return list;
	}

	@Override
	public int likeTotalCnt(int midx) {
		int value = msm.likeTotalCnt(midx);
		return value;
	}

	@Override
	public int likeDelete(int clidx) {
		int value = msm.likeDelete(clidx);
		return value;
	}

	@Override
	public ArrayList<ScheduleRootVo> scheduleList(int midx) {
		ArrayList<ScheduleRootVo> list = new ArrayList<>();
		list = msm.scheduleList(midx);
		return list;
	}

	@Override
	public int scheculeTotalCnt(int midx) {
		int value = msm.scheculeTotalCnt(midx);
		return value;
	}

}
