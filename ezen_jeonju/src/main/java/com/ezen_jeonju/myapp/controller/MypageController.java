package com.ezen_jeonju.myapp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.service.MypageService;

@Controller
@RequestMapping(value = "/mypage")
public class MypageController {
	
	@Autowired
	MypageService ms;
	
	@RequestMapping(value = "/userMypage.do")
	public String memberLogin(HttpSession session) {

		String memberGrade = "";
		memberGrade = (String) session.getAttribute("memberGrade");

		if(memberGrade.equals("일반회원")) {
			return "mypage/userMypage";
		}else {
			return "mypage/registerMainImages";
		}
	}
	
	@RequestMapping(value = "/personalInfo.do")
	public String personalInfo(HttpSession session, Model model) {
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		String memberName = (String) session.getAttribute("memberName");
		String memberPhone = "";
		memberPhone = ms.getMemberPhone(midx);
		MemberVo mv = new MemberVo();

		mv.setMemberName(memberName);
		mv.setMemberPhone(memberPhone);
		
		model.addAttribute("mv",mv);
		return "mypage/personalInfo";
		
	}
	
}
