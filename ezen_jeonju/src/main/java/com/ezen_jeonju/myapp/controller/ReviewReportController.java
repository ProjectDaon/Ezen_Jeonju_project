package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
