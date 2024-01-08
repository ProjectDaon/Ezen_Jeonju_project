package com.ezen_jeonju.myapp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	
	// Controller가 실행되기 전에 호출되는 메서드
	@Override  
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception{
		
		// 세션을 가져온다 (세션이 없으면 새로 생성하지 않음)
		HttpSession session = request.getSession(false);		 
		
		// 세션에 저장된 회원 정보를 제거한다
		if(session.getAttribute("midx") != null){
			session.removeAttribute("midx");		
			session.removeAttribute("memberName");
			session.removeAttribute("memberEmail");	
			session.removeAttribute("memberGrade");	
		}		 
		return true;		
	}
	
	
	
}
