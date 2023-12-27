package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ezen_jeonju.myapp.domain.PageMaker;
import com.ezen_jeonju.myapp.domain.ReviewCriteria;
import com.ezen_jeonju.myapp.domain.ReviewListDTO;
import com.ezen_jeonju.myapp.domain.ReviewVo;
import com.ezen_jeonju.myapp.service.ReviewService;

@RestController
@RequestMapping(value = "/review")
public class ReviewController {

	@Autowired
	ReviewService rs;
	
	@RequestMapping(value="/loginCheck.do")
	public JSONObject loginCheck(HttpSession session) {
		JSONObject jo = new JSONObject();
		String txt = "";
		if(session.getAttribute("midx")==null) {
			txt = "로그인 이후 이용바랍니다.";
		}else {
			txt="pass";
		}
		jo.put("txt", txt);
		return jo;
	}
	
	@RequestMapping(value="/reviewWrite.do")
	public JSONObject reviewWrite(ReviewVo rv, HttpSession session) {
		JSONObject jo = new JSONObject();
		String txt = "";
		if(session.getAttribute("midx")==null) {
			txt = "로그인 이후 이용바랍니다.";
			jo.put("txt", txt);
			return jo;
		}else {
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
			rv.setMidx(midx);
			int value = rs.reviewWrite(rv);
			if(value != 0) {
				txt="pass";
			}else {
				txt="작성오류";
			}
		}
		jo.put("txt", txt);
		return jo;
	}
	
	@RequestMapping(value="reviewList.do")
	public JSONObject reviewList(ReviewCriteria rcri) {
		JSONObject js = new JSONObject();
		int cnt = rs.reviewTotalCnt(rcri.getCidx());
		rcri.setCheck("check");
		PageMaker pm = new PageMaker();
		pm.setRcri(rcri);
		pm.setTotalCount(cnt);
		
		ArrayList<ReviewListDTO> list = rs.reviewList(rcri);
		js.put("list", list);
		js.put("pm", pm);
		return js;
	}
	
	@RequestMapping(value="reviewDel.do")
	public JSONObject reviewDel(@RequestParam("ridx") int ridx) {
		JSONObject js = new JSONObject();
		String txt = "";
		int value = rs.reviewDel(ridx);
		if(value != 0) {
			txt="pass";
		}else {
			txt="삭제오류";
		}
		js.put("txt", txt);
		return js;
	}
	
	@RequestMapping(value="reviewPaging.do")
	public JSONObject reviewPaging(@RequestParam("cidx") int cidx) {
		JSONObject js = new JSONObject();
		int cnt = rs.reviewTotalCnt(cidx);

		PageMaker pm = new PageMaker();
		pm.setTotalCount(cnt);
		
		
		return js;
	}
}
