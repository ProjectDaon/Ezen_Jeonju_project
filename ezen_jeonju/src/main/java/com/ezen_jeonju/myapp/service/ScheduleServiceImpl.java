package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.ScheduleCriteria;
import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
import com.ezen_jeonju.myapp.domain.TourCourseVo;
import com.ezen_jeonju.myapp.persistance.ScheduleService_Mapper;

//마이바티스 구현하는 곳
//쿼리 구현하는곳 

@Service
public class ScheduleServiceImpl implements ScheduleService{
	private ScheduleService_Mapper ssm;
	
	@Autowired
	public ScheduleServiceImpl(SqlSession sqlSession) {
		this.ssm = sqlSession.getMapper(ScheduleService_Mapper.class);
	}
	
	
	@Override
	public int scheduleWrite(ScheduleRootVo sv, ArrayList<TourCourseVo> tv) {
		
		int value = ssm.scheduleWrite(sv);
		int sidx = sv.getSidx();
		for(int i=0; i<tv.size(); i++) {
			TourCourseVo getTv = new TourCourseVo();
			getTv.setTourCourseDate(tv.get(i).getTourCourseDate());
			getTv.setTourCourseTime(tv.get(i).getTourCourseTime());
			getTv.setTourCoursePlace(tv.get(i).getTourCoursePlace());
			getTv.setTourCourseLatitude(tv.get(i).getTourCourseLatitude());
			getTv.setTourCourseLongitude(tv.get(i).getTourCourseLongitude());
			getTv.setTourCourseNDate(tv.get(i).getTourCourseNDate());
			getTv.setSidx(sidx);
			ssm.tourCourseInsert(getTv);
		}
		
		return value;
				
	}
	@Override
	public ArrayList<ScheduleRootVo> scheduleList(ScheduleCriteria sscri) {
		ArrayList<ScheduleRootVo> list = ssm.scheduleList(sscri);

		return list;
	}


	@Override
	public ScheduleRootVo scheduleContents(int sidx) {
		ssm.scheduleViewCount(sidx);
		ScheduleRootVo sv = ssm.scheduleContents(sidx);
		return sv;
	}

	@Override
	public ArrayList<TourCourseVo> tourCourseContents(int sidx) {
		ArrayList<TourCourseVo> tlist = ssm.tourCourseContents(sidx);
		return tlist;
	}

	@Override
	public ArrayList<TourCourseVo> tourCourseNDate(int sidx) {
		
		ArrayList<TourCourseVo> tlist = ssm.tourCourseNDate(sidx);
		
		return tlist;
		
	}
	@Override
	public ArrayList<TourCourseVo> tourCourseNDateContents(TourCourseVo tv) {
		ArrayList<TourCourseVo> tlist = ssm.tourCourseNDateContents(tv);
		return tlist;
	}


	@Override
	public int scheduleTotalCount() {
		int value = ssm.scheduleTotalCount();
		
		return value;
	}
	
}
