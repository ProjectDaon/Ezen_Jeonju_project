package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ezen_jeonju.myapp.domain.NotificationDTO;
import com.ezen_jeonju.myapp.service.NotificationService;

@RestController
@RequestMapping(value="/notification")
public class NotificationController {

	@Autowired
	NotificationService nts;
	
	@RequestMapping(value="/notificationCheck.do")
	public JSONObject notifCheck(HttpSession session) {
		JSONObject js = new JSONObject();
		
		try {
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
			int value = nts.notifCheck(midx);
			js.put("value", value);
		}catch(Exception e){
			
		}
		
		return js;
	}
	
	@RequestMapping(value="/notificationList.do")
	public JSONObject notificationList(HttpSession session) {
		JSONObject js = new JSONObject();
		
		try {
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
			ArrayList<NotificationDTO> list = nts.notifList(midx);
			js.put("ntlist", list);
			
		}catch(Exception e){
			
		}
		
		return js;
	}
}
