package com.ezen_jeonju.myapp.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.persistance.AttachFileService_Mapper;
import com.ezen_jeonju.myapp.persistance.ContentsService_Mapper;

@Service
public class AttachFileServiceImpl implements AttachFileService{
	
	public AttachFileService_Mapper asm;
	@Autowired
	public AttachFileServiceImpl(SqlSession sqlSession) {
		this.asm = sqlSession.getMapper(AttachFileService_Mapper.class);
	}
	
	
	@Override
	public int imageFileUpload(AttachFileVo af) {
		int value = asm.imageFileUpload(af);
		
		return value;
	}


	@Override
	public AttachFileVo imageFileLoad(int aidx) {
		AttachFileVo af = new AttachFileVo();
		af = asm.imageFileLoad(aidx);
		
		return af;
	}
	
	

}
