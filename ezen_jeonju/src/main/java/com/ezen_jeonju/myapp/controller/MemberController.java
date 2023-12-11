package com.ezen_jeonju.myapp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.service.MemberService;


@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	@Autowired
	MemberService ms;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value = "/memberLogin.do")
	public String memberLogin() {

		
		return "member/memberLogin";
	}
	
	@RequestMapping(value = "/memberLoginAction.do")
	public String memberLoginAction(
			@RequestParam("memberId") String memberId, 
			@RequestParam("memberPwd") String memberPwd,
			HttpSession session,
			HttpServletRequest request,
			RedirectAttributes rttr) {
		

		MemberVo mv = ms.memberLogin(memberId);
		String path="";
		
		if(mv!=null&&bcryptPasswordEncoder.matches(memberPwd, mv.getMemberPwd())) {
			session.setAttribute("midx",mv.getMidx());
			session.setAttribute("memberName", mv.getMemberName());
			session.setAttribute("memberGrade", mv.getMemberGrade());
			
			//1회용 모델클래스 redirectAttribute
//			rttr.addAttribute("midx", mv.getMidx());
//			rttr.addAttribute("memberName", mv.getMemberName());
			
			if(request.getSession().getAttribute("saveUrl")!= null) {
				path=(String)request.getSession().getAttribute("saveUrl").toString().substring(request.getContextPath().length()+1);
			}else {
				path="index.jsp";
			}
		}else {
			rttr.addFlashAttribute("msg", "아이디와 비밀번호를 확인해주세요.");
			path="member/memberLogin.do";
		}
		return "redirect:/"+path;
	}
	
	@RequestMapping(value = "/memberJoin.do")
	public String memberJoin() {

		
		return "member/memberJoin";
	}
	
	@RequestMapping(value = "/memberJoinAction.do")
	public String memberJoinAction(MemberVo mv) { // input 객체들의 값을 바인딩한다.

		
		String memberPwd2 = bcryptPasswordEncoder.encode(mv.getMemberPwd());
		mv.setMemberPwd(memberPwd2); 
		

		// 처리하는 입력 로직
		int value = ms.memberInsert(mv);

		return "redirect:/"; // 포워드방식이 아닌 sendRedirect 방식
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck.do")
	public String memberIdCheck(String memberId) {
		String str = null;
		int value = ms.memberIdCheck(memberId);
		str = "{\"value\" : \""+value+"\"}";
		return str;
	}
	
	@RequestMapping(value = "/memberLogout.do")
	public String memberLogout(HttpSession session) {
		session.removeAttribute("midx");
		session.removeAttribute("memberName");
		session.invalidate();
		return "redirect:/";
	}
}

