package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen_jeonju.myapp.domain.ScheduleRootVo;
import com.ezen_jeonju.myapp.domain.TourCourseVo;
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
	public String scheduleWriteAction(ScheduleRootVo sv ,HttpSession session,
			@RequestParam("Array") String rootValue,
			@RequestParam("scheduleSubject") String scheduleSubject,
			@RequestParam("scheduleStartDate") String scheduleStartDate,
			@RequestParam("scheduleEndDate") String scheduleEndDate,
			@RequestParam("scheduleShareYN") String scheduleShareYN
			) 
	{
		sv.setMidx(((Integer)session.getAttribute("midx")).intValue());
		sv.setScheduleEndDate(scheduleEndDate);
		sv.setScheduleStartDate(scheduleStartDate);
		sv.setScheduleShareYN(scheduleShareYN);
		sv.setScheduleSubject(scheduleSubject);
		
		JSONParser parser = new JSONParser();
		
		JSONArray jsonArray = null;
	    try {
			jsonArray = (JSONArray) parser.parse(rootValue);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
	    ArrayList<TourCourseVo> list = new ArrayList<>();
	    for(int i=0; i<jsonArray.size(); i++){
			JSONObject insertData = (JSONObject) jsonArray.get(i);
			
			String tourCourseDate = (String)insertData.get("tourCourseDate");
			String tourCourseTime = (String)insertData.get("tourCourseTime");
			String tourCoursePlace = (String)insertData.get("tourCoursePlace");
			TourCourseVo tv = new TourCourseVo();
			tv.setTourCourseDate(tourCourseDate);
			tv.setTourCourseTime(tourCourseTime);
			tv.setTourCoursePlace(tourCoursePlace);
			list.add(tv);
		}
	    
		//System.out.println(rootValue);

		ss.scheduleWrite(sv,list);
		
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
    	ArrayList<TourCourseVo> tlist = ss.tourCourseContents(sidx);
    	
    	model.addAttribute("sv",sv);
    	model.addAttribute("tlist",tlist);
    	
    	return "/schedule/scheduleContents";
    }
	
}