package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
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
	public int scheduleWrite(ScheduleRootVo sv) {
		
		int value = ssm.scheduleWrite(sv);
		
		
		return value;
				
	}
	@Override
	public ArrayList<ScheduleRootVo> scheduleList() {
		ArrayList<ScheduleRootVo> list = ssm.scheduleList();

		return list;
	}
}
