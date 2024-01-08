package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.ReviewReportDTO;
import com.ezen_jeonju.myapp.persistance.ReviewReportService_Mapper;

@Service
public class ReviewReportServiceImpl implements ReviewReportService{
	
	public ReviewReportService_Mapper rrsm;
	
	public ReviewReportServiceImpl(SqlSession sqlSession) {
		this.rrsm = sqlSession.getMapper(ReviewReportService_Mapper.class);
	}

	@Override
	public ArrayList<ReviewReportDTO> reportList() {
		ArrayList<ReviewReportDTO> list = new ArrayList<>();
		list = rrsm.reportList();
		return list;
	}

	@Override
	public int reportCancel(int rridx) {
		int value = rrsm.reportCancel(rridx);
		return value;
	}

	@Override
	public int reviewDelete(int ridx) {
		int value = rrsm.reviewDelete(ridx);
		return value;
	}
	
	
}
