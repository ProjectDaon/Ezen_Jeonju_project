package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.MainPageVo;

public interface MainPageService {

	public int mainPageVannerRegister(MainPageVo mpv);

	public ArrayList<MainPageVo> mainPageVannerView();

}
