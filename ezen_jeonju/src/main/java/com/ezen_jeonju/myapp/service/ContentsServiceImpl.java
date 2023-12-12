package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.persistance.ContentsService_Mapper;

@Service
public class ContentsServiceImpl implements ContentsService{

	private ContentsService_Mapper csm;
	
	@Autowired
	public ContentsServiceImpl(SqlSession sqlSession) {
		this.csm = sqlSession.getMapper(ContentsService_Mapper.class);
	}
	
	@Override
	public int contentsWrite(ContentsVo cv) {
		int value = csm.contentsWrite(cv);
		return value;
	}
	
	@Override
	public ArrayList<ContentsVo> sightsList() {
		ArrayList<ContentsVo> cv = csm.sightsList();
		return cv;
	}
	
	@Override
	public ArrayList<ContentsVo> foodList() {
		ArrayList<ContentsVo> cv = csm.foodList();
		return cv;
	}
	
	@Override
	public ContentsVo contentsArticle(int cidx) {
		ContentsVo cv = csm.contentsArticle(cidx);
		return cv;
	}
}
