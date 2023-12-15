package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.NoticeVo;
import com.ezen_jeonju.myapp.domain.SearchCriteria;

public interface NoticeService {
	public int noticeWrite(NoticeVo nv);
	public ArrayList<NoticeVo> noticeList(SearchCriteria scri);
	public int noticeTotalCount(SearchCriteria scri);
	public NoticeVo noticeContents(int nidx);
	public int noticeModify(NoticeVo nv);
	public int noticeDelete(int nidx);
}
