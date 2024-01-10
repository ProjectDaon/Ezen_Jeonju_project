package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ReviewReportDTO;
import com.ezen_jeonju.myapp.domain.ReviewReportVo;

public interface ReviewReportService_Mapper {
	public ArrayList<ReviewReportDTO> reportList();
	public int reportCancel(int rridx);
	public int reviewDelete(ReviewReportVo rrv);
	public int reviewReportDelete(int rridx);
	public int insertNotification(ReviewReportVo rrv);
}
