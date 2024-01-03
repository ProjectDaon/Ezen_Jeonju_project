package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.domain.MainPageVo;
import com.ezen_jeonju.myapp.domain.NoticeVo;

public interface MainPageService {

	public int mainPageVannerRegister(MainPageVo mpv);

	public ArrayList<MainPageVo> mainPageVannerView();

	public ArrayList<ContentsVo> mainPageSecondView();

	public ArrayList<ContentsVo> mainPageThirdView();
	
	public ArrayList<NoticeVo> mainPageNoticeView();

	public ArrayList<MainPageVo> registeredVanners();

	public MainPageVo vannerContent(int mpidx);

	public int vannerCount(MainPageVo mpv);
	
	public int vannerModify(MainPageVo mpv);

	public int vannerDelete(MainPageVo mpv);


}
