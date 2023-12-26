package com.ezen_jeonju.myapp.controller;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ezen_jeonju.myapp.domain.ContentsLikeVo;
import com.ezen_jeonju.myapp.service.ContentsLikeService;

@RestController
@RequestMapping(value="/contentsLike")
public class ContentsLikeController {
	
	@Autowired
	ContentsLikeService cls;
	
	
	@RequestMapping(value="/contentsLike.do")
	public JSONObject contentsLike(ContentsLikeVo clv, HttpSession session) {
		JSONObject js = new JSONObject();
		String txt = "";
		if(session.getAttribute("midx")!=null) {
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
			clv.setMidx(midx);
			int check = cls.likeCheck(clv);
			if(check==0) {
				int value = cls.likeAction(clv);
				if(value!=0) {
					txt="좋아요";
				}else {
					txt="에러";
				}
			}else {
				cls.likeDelete(clv);
				txt="좋아요 취소";
			}
		}else {
			txt="로그인 후 이용바랍니다.";
		}
		js.put("value", txt);
		return js;
	}
	@RequestMapping(value="/contentsLikeCheck.do")
	public JSONObject contentsLikeCheck(ContentsLikeVo clv, HttpSession session) {
		JSONObject js = new JSONObject();
		int value = 0;
		String txt = "";
		if(session.getAttribute("midx")!=null) {
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
			clv.setMidx(midx);
			value = cls.likeCheck(clv);
		}else {
			value=0;
		}
		js.put("value", value);
		return js;
	}
	
}
