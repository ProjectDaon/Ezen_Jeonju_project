package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.domain.MypageDTO;
import com.ezen_jeonju.myapp.domain.PageMaker;
import com.ezen_jeonju.myapp.domain.ReviewCriteria;
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
		MemberVo mv = new MemberVo();
	
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		String memberName = (String) session.getAttribute("memberName");
		if(session.getAttribute("memberEmail")!=null) {
			mv.setMemberEmail(session.getAttribute("memberEmail").toString());
		}
		String memberPhone = "";
		memberPhone = ms.getMemberPhone(midx);
		
		mv.setMemberName(memberName);
		mv.setMemberPhone(memberPhone);
		
		model.addAttribute("mv",mv);
			

		return "mypage/personalInfo";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewList.do")
	public JSONObject reviewList(ReviewCriteria rcri) {
		JSONObject js = new JSONObject();
		int midx = rcri.getMidx();
		int totalCnt = ms.reviewTotalCnt(midx);
		
		PageMaker pm = new PageMaker();
		pm.setRcri(rcri);
		pm.setTotalCount(totalCnt);
		ArrayList<MypageDTO> list = ms.reviewList(rcri);
		
		js.put("pm", pm);
		js.put("reviewlist", list);
		return js;
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewDelete.do")
	public JSONObject reviewDelete(@RequestParam("ridx") int ridx) {
		JSONObject js = new JSONObject();
		int value = ms.reviewDelete(ridx);
		String txt="";
		if(value!=0) {
			txt = "댓글을 삭제하였습니다.";
		}else {
			txt="삭제오류";
		}
		js.put("txt", txt);
		return js;
	}
	
}
