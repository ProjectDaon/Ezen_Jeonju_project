package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.MainPageVo;

public interface MainPageService_Mapper {

	public int mainPageVannerRegister(MainPageVo mpv);

	public ArrayList<MainPageVo> mainPageVannerView();

}
