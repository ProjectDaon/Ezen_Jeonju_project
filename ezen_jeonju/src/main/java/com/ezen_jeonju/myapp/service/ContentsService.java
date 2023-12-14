package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.ContentsVo;

public interface ContentsService {
	public int contentsWrite(ContentsVo cv);
	public ArrayList<ContentsVo> sightsList();
	public ArrayList<ContentsVo> foodList();
	public ContentsVo contentsArticle(int cidx);
	public int contentsModify(ContentsVo cv);
	public int contentsDelete(int cidx);
	public int contentsViewCountUpdate(int cidx);
}
