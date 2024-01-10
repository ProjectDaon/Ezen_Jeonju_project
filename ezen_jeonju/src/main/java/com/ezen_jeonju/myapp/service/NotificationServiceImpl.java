package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.NotificationDTO;
import com.ezen_jeonju.myapp.persistance.NotificationService_Mapper;

@Service
public class NotificationServiceImpl implements NotificationService{

	public NotificationService_Mapper ntsm;
	
	@Autowired
	public NotificationServiceImpl(SqlSession sqlSession) {
		this.ntsm = sqlSession.getMapper(NotificationService_Mapper.class);
	}

	@Override
	public int notifCheck(int midx) {
		int value = ntsm.notifCheck(midx);
		return value;
	}

	@Override
	public ArrayList<NotificationDTO> notifList(int midx) {
		ArrayList<NotificationDTO> list = new ArrayList<>();
		list = ntsm.notifList(midx);
		ntsm.openNotification(midx);
		return list;
	}


	
	
}
