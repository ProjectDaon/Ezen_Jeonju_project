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

@Controller
@RequestMapping(value = "/notice")
public class NoticeController {
	
	@Autowired
	NoticeService ns;
	
	@RequestMapping(value = "/noticeWrite.do")
	public String noticeWrite() {

		
		return "notice/noticeWrite";
	}
	
	@RequestMapping(value = "/noticeWriteAction.do")
	public String noticeWriteAction(NoticeVo nv, HttpSession session) {
		System.out.println(nv.getNoticeArticle());
		nv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
		ns.noticeWrite(nv);
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value = "/noticeList.do")
	public String noticeList(Model model) {
		ArrayList<NoticeVo> nvlist = ns.noticeList();
		model.addAttribute("nvlist",nvlist);
		return "/notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeContents.do")
	public String noticeContents(@RequestParam("nidx") String nidx,Model model) {
		int nidx_i = Integer.parseInt(nidx);
		NoticeVo nv = ns.noticeContents(nidx_i);
		model.addAttribute("nv", nv);
		return "/notice/noticeContents";
	}
}
