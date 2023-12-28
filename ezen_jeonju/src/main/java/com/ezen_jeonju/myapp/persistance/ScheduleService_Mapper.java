package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;
import java.util.HashMap;

import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
import com.ezen_jeonju.myapp.domain.TourCourseVo;

//마이바티스용 메소드 정의
public interface ScheduleService_Mapper {

	public int scheduleWrite(ScheduleRootVo sv);

	public ArrayList<ScheduleRootVo> scheduleList();
	
	public ScheduleRootVo scheduleContents(int sidx);

	public void scheduleViewCount(int sidx);
	
	public int tourCourseInsert(TourCourseVo tv);
	
	public ArrayList<TourCourseVo> tourCourseContents(int sidx);
	
	public ArrayList<TourCourseVo> tourCourseNDate(int sidx);
	
	public ArrayList<TourCourseVo> tourCourseNDateContents(TourCourseVo tv);

}
