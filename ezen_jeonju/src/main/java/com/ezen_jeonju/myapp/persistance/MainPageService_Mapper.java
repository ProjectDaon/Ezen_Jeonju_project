package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.domain.MainPageVo;
import com.ezen_jeonju.myapp.domain.NoticeVo;

public interface MainPageService_Mapper {

	public int mainPageVannerRegister(MainPageVo mpv);

	public ArrayList<MainPageVo> mainPageVannerView();

	public ArrayList<ContentsVo> mainPageSecondView();

	public ArrayList<ContentsVo> mainPageThirdView();
	
	public ArrayList<NoticeVo> mainPageNoticeView();


}
