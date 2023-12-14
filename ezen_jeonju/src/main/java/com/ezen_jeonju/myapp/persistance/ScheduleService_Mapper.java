package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ScheduleRootVo;

//마이바티스용 메소드 정의
public interface ScheduleService_Mapper {

	public int scheduleWrite(ScheduleRootVo sv);

	public ArrayList<ScheduleRootVo> scheduleList();
}
