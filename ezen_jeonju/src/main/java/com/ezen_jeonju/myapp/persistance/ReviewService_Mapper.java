package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ReviewCriteria;
import com.ezen_jeonju.myapp.domain.ReviewListDTO;
import com.ezen_jeonju.myapp.domain.ReviewReportDTO;
import com.ezen_jeonju.myapp.domain.ReviewReportVo;
import com.ezen_jeonju.myapp.domain.ReviewVo;

public interface ReviewService_Mapper {
	public int reviewWrite(ReviewVo rv);
	public ArrayList<ReviewListDTO> reviewList(ReviewCriteria rcri);
	public int reviewDel(int ridx);
	public int reviewTotalCnt(int cidx);
	public ReviewReportDTO reviewReport(int ridx);
	public int reviewReportAction(ReviewReportVo rrv);
}
