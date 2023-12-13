package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen_jeonju.myapp.domain.NoticeVo;
import com.ezen_jeonju.myapp.service.NoticeService;
import com.ezen_jeonju.myapp.service.ScheduleService;

@Controller
@RequestMapping(value = "/schedule")
public class ScheduleController {
	
	
	@RequestMapping(value = "/scheduleWrite.do")
	public String scheduleWrite() {

		
		return "schedule/scheduleWrite";
	}
	
	@RequestMapping(value = "/scheduleList.do")
	public String schedulepractice() {

		
		return "schedule/scheduleList";
	}

	
}