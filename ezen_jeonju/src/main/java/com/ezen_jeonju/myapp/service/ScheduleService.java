package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ScheduleCriteria;
import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
import com.ezen_jeonju.myapp.domain.SearchCriteria;
import com.ezen_jeonju.myapp.domain.TourCourseVo;

// 메소드를 정의해놓은 인터페이스
public interface ScheduleService {

	public int scheduleWrite(ScheduleRootVo sv,ArrayList<TourCourseVo> tv);
	
	ArrayList<ScheduleRootVo> scheduleList(ScheduleCriteria sscri);

	public ScheduleRootVo scheduleContents(int sidx);

	public ArrayList<TourCourseVo> tourCourseContents(int sidx);

	public ArrayList<TourCourseVo> tourCourseNDate(int sidx);

	public ArrayList<TourCourseVo> tourCourseNDateContents(TourCourseVo tv);
	
	public int scheduleTotalCount();

	

}
