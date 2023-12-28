package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.domain.ContentsListDTO;
import com.ezen_jeonju.myapp.domain.ContentsSearchCriteria;
import com.ezen_jeonju.myapp.domain.ContentsStatsDTO;
import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.persistance.AttachFileService_Mapper;
import com.ezen_jeonju.myapp.persistance.ContentsService_Mapper;

@Service
public class ContentsServiceImpl implements ContentsService{

	public ContentsService_Mapper csm;
	public AttachFileService_Mapper asm;
	
	@Autowired
	public ContentsServiceImpl(SqlSession sqlSession) {
		this.csm = sqlSession.getMapper(ContentsService_Mapper.class);
	}
	
	@Override
	public int contentsWrite(ContentsVo cv) {
//		AttachFileVo af = new AttachFileVo();
//		af.setUploadFileName(cv.getUploadFileName());
//		asm.imageFileUpload(af);
//		cv.setAidx(af.getAidx());
		
		int value = csm.contentsWrite(cv);

		return value;
	}
	
	@Override
	public ArrayList<ContentsListDTO> contentsList(ContentsSearchCriteria cscri) {
		int value = (cscri.getPage()-1)*9;
		cscri.setPage(value);
		
		ArrayList<ContentsListDTO> cv = csm.contentsList(cscri);
		
		return cv;
	}

	
	@Override
	public ContentsVo contentsArticle(int cidx) {
		ContentsVo cv = csm.contentsArticle(cidx);
		
		try {
			AttachFileVo af = csm.contentsFileload(cidx);
			cv.setStoredFilePath(af.getStoredFilePath());
		}catch (Exception e) {
			
		}
		return cv;
	}
	
	@Override
	public int contentsModify(ContentsVo cv) {
		int value = csm.contentsModify(cv);
		return value;
	}
	
	@Override
	public int contentsDelete(int cidx) {
		
		int value = csm.contentsDelete(cidx);
		return value;
	}
	
	@Override
	public int contentsViewCountUpdate(int cidx) {
		int value = csm.contentsViewCountUpdate(cidx);
		return value;
	}

	@Override
	public int totalCount(ContentsSearchCriteria cscri) {
		int value = csm.totalCount(cscri);
		return value;
	}

	@Override
	public ContentsStatsDTO contentsStats(int cidx) {
		ContentsStatsDTO csdto = new ContentsStatsDTO();
		csdto.setStarAverage(csm.starAverage(cidx));
		csdto.setReviewCount(csm.reviewCount(cidx));
		return csdto;
	}


}
