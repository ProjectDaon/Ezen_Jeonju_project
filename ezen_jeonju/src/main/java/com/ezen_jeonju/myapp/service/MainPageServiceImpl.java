package com.ezen_jeonju.myapp.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.persistance.MainPageService_Mapper;

@Service
public class MainPageServiceImpl implements MainPageService{
	
	public MainPageService_Mapper mpsm;
	
	@Autowired
	public MainPageServiceImpl(SqlSession sqlSession) {
		this.mpsm = sqlSession.getMapper(MainPageService_Mapper.class);
	}

}
