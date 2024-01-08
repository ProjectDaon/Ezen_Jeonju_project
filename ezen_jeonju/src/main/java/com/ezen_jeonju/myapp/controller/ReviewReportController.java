package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen_jeonju.myapp.domain.ReviewReportDTO;
import com.ezen_jeonju.myapp.service.ReviewReportService;

@Controller
@RequestMapping(value="/reviewReport")
public class ReviewReportController {
	
	@Autowired
	ReviewReportService rrs;
	
	@RequestMapping(value="reportList.do")
	public String reportList(Model model) {
		ArrayList<ReviewReportDTO> list = new ArrayList<>();
		list = rrs.reportList();
		model.addAttribute("reportList", list);
		return "mypage/reviewReportList";
	}
	
	@ResponseBody
	@RequestMapping(value="reportListGet.do")
	public JSONObject reportListGet() {
		JSONObject js = new JSONObject();
		ArrayList<ReviewReportDTO> list = new ArrayList<>();
		list = rrs.reportList();
		js.put("list", list);
		return js;
	}
	
	@ResponseBody
	@RequestMapping(value="reportCancel.do")
	public JSONObject reportCancel(@RequestParam("rridx") int rridx) {
		JSONObject js = new JSONObject();
		String txt = "";
		int value = rrs.reportCancel(rridx);
		if(value != 0) {
			txt = "신고가 반려되었습니다.";
		}else {
			txt = "신고반려 오류";
		}
		js.put("txt", txt);
		return js;
	}
	
	@ResponseBody
	@RequestMapping(value="reviewDelete.do")
	public JSONObject reviewDelete(@RequestParam("ridx") int ridx) {
		JSONObject js = new JSONObject();
		String txt = "";
		int value = rrs.reviewDelete(ridx);
		if(value != 0) {
			txt = "리뷰가 삭제되었습니다.";
		}else {
			txt = "리뷰삭제 오류";
		}
		js.put("txt", txt);
		return js;
	}
}
