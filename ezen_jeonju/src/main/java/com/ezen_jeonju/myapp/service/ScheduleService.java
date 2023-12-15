package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ScheduleRootVo;

// 메소드를 정의해놓은 인터페이스
public interface ScheduleService {

	public int scheduleWrite(ScheduleRootVo sv);
	
	public ArrayList<ScheduleRootVo> scheduleList();

	public ScheduleRootVo scheduleContents(int sidx);

}
