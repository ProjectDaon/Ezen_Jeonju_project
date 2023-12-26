package com.ezen_jeonju.myapp.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.ContentsLikeVo;
import com.ezen_jeonju.myapp.persistance.AttachFileService_Mapper;
import com.ezen_jeonju.myapp.persistance.ContentsLikeService_Mapper;

@Service
public class ContentsLikeServiceImpl implements ContentsLikeService{

	public ContentsLikeService_Mapper clsm;
	
	@Autowired
	public ContentsLikeServiceImpl(SqlSession sqlSession) {
		this.clsm = sqlSession.getMapper(ContentsLikeService_Mapper.class);
	}
	
	@Override
	public int likeAction(ContentsLikeVo clv) {
		int value = clsm.likeAction(clv);
		return value;
	}

	@Override
	public int likeCheck(ContentsLikeVo clv) {
		int value = clsm.likeCheck(clv);
		return value;
	}

	@Override
	public int likeDelete(ContentsLikeVo clv) {
		int value = clsm.likeDelete(clv);
		return value;
	}

}
