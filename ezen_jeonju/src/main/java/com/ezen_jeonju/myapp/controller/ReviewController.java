package com.ezen_jeonju.myapp.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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
		js.put("pm", pm);
		
		return js;
	}
	
	@RequestMapping(value="blogReview.do")
	public JSONObject blogReview(@RequestParam("subject") String subject) throws Exception {
		JSONObject js = new JSONObject();
		
		ArrayList<String> al1 = new ArrayList<>();
		ArrayList<String> al2 = new ArrayList<>();
		ArrayList<String> al3 = new ArrayList<>();
		ArrayList<String> al4 = new ArrayList<>();
		
		String address = "https://search.naver.com/search.naver?query="+subject+"&nso=&where=blog&sm=tab_opt";
		Document rawData = Jsoup.connect(address).get();
		
		Elements blogOption = rawData.select("li.bx");

		String realURL = "";
		String realTitle = "";
		String blogName = "";
		String realContents = "";
		for(Element option : blogOption) {
			//System.out.println(option);
			//블로그 링크
			realURL = option.select(".title_area a").attr("href");
			//게시글 제목
			Elements titleDiv = option.select(".title_area");
			realTitle = titleDiv.select("a").text();
			//게시글 내용
			Elements contentsDiv = option.select(".dsc_area");
			realContents = contentsDiv.select("a").text();
			if(realContents.length()>=30) realContents = realContents.substring(0, 80);
			//블로그 이름
			Elements blognameDiv = option.select(".user_info");
			blogName = blognameDiv.select("a").text();

			al1.add(realURL);
			al2.add(realTitle);
			al3.add(blogName);
			al4.add(realContents);
		}
		
		js.put("url", al1);
		js.put("title", al2);
		js.put("blogname",al3);
		js.put("contents", al4);
		
		return js;
	}
}
