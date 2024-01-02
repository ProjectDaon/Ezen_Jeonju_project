package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.MypageLikeCriteria;
import com.ezen_jeonju.myapp.domain.MypageReviewDTO;
import com.ezen_jeonju.myapp.domain.ReviewCriteria;

public interface MypageService_Mapper {
	public String getMemberPhone(int midx);
	public ArrayList<MypageReviewDTO> reviewList(ReviewCriteria rcri);
	public int reviewDelete(int ridx);
	public int reviewTotalCnt(int midx);
	public ArrayList<MypageLikeCriteria> likeList(MypageLikeCriteria mlcri);
	public int likeTotalCnt(int midx);
	public int likeDelete(int clidx);
}
