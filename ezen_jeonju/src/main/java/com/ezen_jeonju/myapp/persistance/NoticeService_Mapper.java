package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.NoticeVo;
import com.ezen_jeonju.myapp.domain.SearchCriteria;

public interface NoticeService_Mapper {
	public int noticeWrite(NoticeVo nv);
	public ArrayList<NoticeVo> noticeList(SearchCriteria scri);
	public int noticeTotalCount(SearchCriteria scri);
	public NoticeVo noticeContents(int nidx);
	public int noticeModify(NoticeVo nv);
	public int noticeDelete(int nidx);
}
