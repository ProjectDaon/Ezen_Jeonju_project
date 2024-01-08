package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ReviewReportDTO;

public interface ReviewReportService {
	public ArrayList<ReviewReportDTO> reportList();
	public int reportCancel(int rridx);
	public int reviewDelete(int ridx);
}
