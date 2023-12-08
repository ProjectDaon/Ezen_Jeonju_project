package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.NoticeVo;

public interface NoticeService_Mapper {
	public int noticeWrite(NoticeVo nv);
	public ArrayList<NoticeVo> noticeList();
	public NoticeVo noticeContents(int nidx);
}
