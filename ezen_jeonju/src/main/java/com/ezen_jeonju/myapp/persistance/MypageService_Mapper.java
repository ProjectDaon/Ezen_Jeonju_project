package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.MypageDTO;
import com.ezen_jeonju.myapp.domain.ReviewCriteria;

public interface MypageService_Mapper {
	public String getMemberPhone(int midx);
	public ArrayList<MypageDTO> reviewList(ReviewCriteria rcri);
	public int reviewDelete(int ridx);
	public int reviewTotalCnt(int midx);
}
