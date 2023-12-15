package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
import com.ezen_jeonju.myapp.service.ScheduleService;

@Controller
@RequestMapping(value = "/schedule")
public class ScheduleController {
	
	@Autowired
	ScheduleService ss;
	
	
	@RequestMapping(value = "/scheduleWrite.do")
	public String scheduleWrite() {

		
		return "schedule/scheduleWrite";
	}
	@RequestMapping(value = "/scheduleWriteAction.do")
	public String scheduleWriteAction(ScheduleRootVo sv ,HttpSession session) {
		sv.setMidx(((Integer)session.getAttribute("midx")).intValue());
		
		ss.scheduleWrite(sv);
		
		return "redirect:/schedule/scheduleList.do";
	}
	
	
	@RequestMapping(value = "/scheduleList.do")
	public String scheduleList(Model model) {
		
		ArrayList<ScheduleRootVo> list = ss.scheduleList();
		
		model.addAttribute("list",list);
		
		return "schedule/scheduleList";
	}
    @RequestMapping(value="/scheduleContents.do")
    public String boardContents(@RequestParam("sidx") int sidx, Model model){
    	ScheduleRootVo sv = ss.scheduleContents(sidx);
    	model.addAttribute("sv",sv);
    	
    	return "/schedule/scheduleContents";
    	
    }
	
}