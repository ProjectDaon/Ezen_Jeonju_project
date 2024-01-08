package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ReviewReportDTO;

public interface ReviewReportService_Mapper {
	public ArrayList<ReviewReportDTO> reportList();
	public int reportCancel(int rridx);
	public int reviewDelete(int ridx);
}
