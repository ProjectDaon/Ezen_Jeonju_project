package com.ezen_jeonju.myapp.service;

import com.ezen_jeonju.myapp.domain.ContentsLikeVo;

public interface ContentsLikeService {
	public int likeAction(ContentsLikeVo clv);
	public int likeCheck(ContentsLikeVo clv);
	public int likeDelete(ContentsLikeVo clv);
	public int likeCount(int cidx);
}
