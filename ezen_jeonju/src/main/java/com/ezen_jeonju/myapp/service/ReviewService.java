package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ReviewCriteria;
import com.ezen_jeonju.myapp.domain.ReviewListDTO;
import com.ezen_jeonju.myapp.domain.ReviewVo;

public interface ReviewService {
	public int reviewWrite(ReviewVo rv);
	public ArrayList<ReviewListDTO> reviewList(ReviewCriteria rcri);
	public int reviewDel(int ridx);
	public int reviewTotalCnt(int cidx);
}
