package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.domain.ContentsSearchCriteria;
import com.ezen_jeonju.myapp.domain.ContentsVo;

public interface ContentsService_Mapper {
	public int contentsWrite(ContentsVo cv);
	public ArrayList<ContentsVo> contentsList(ContentsSearchCriteria cscri);
	public ContentsVo contentsArticle(int cidx);
	public int contentsModify(ContentsVo cv);
	public int contentsDelete(int cidx);
	public int contentsViewCountUpdate(int cidx);
	public Integer contentsFileUpload(ContentsVo cv);
	public AttachFileVo contentsFileload(int cidx);
	public int totalCount(ContentsSearchCriteria cscri);
}
