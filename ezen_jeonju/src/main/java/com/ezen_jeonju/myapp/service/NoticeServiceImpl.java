package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.NoticeVo;
import com.ezen_jeonju.myapp.persistance.NoticeService_Mapper;

@Service
public class NoticeServiceImpl implements NoticeService{

	public NoticeService_Mapper nsm;
	
	@Autowired
	public NoticeServiceImpl(SqlSession sqlSession) {
		this.nsm = sqlSession.getMapper(NoticeService_Mapper.class);
	}
	@Override
	public int noticeWrite(NoticeVo nv) {
		int value = nsm.noticeWrite(nv);
		return value;
	}
	@Override
	public ArrayList<NoticeVo> noticeList() {
		ArrayList<NoticeVo> nv = nsm.noticeList();
		
		return nv;
	}
	
	@Override
	public NoticeVo noticeContents(int nidx) {
		NoticeVo nv = nsm.noticeContents(nidx);
		return nv;
	}
	
}
