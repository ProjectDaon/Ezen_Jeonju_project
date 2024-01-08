package com.ezen_jeonju.myapp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 권한 인터셉터
public class AuthInterceptor extends HandlerInterceptorAdapter {

	// 컨트롤러 실행 전에 호출되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// 세션을 가져온다
		HttpSession session = request.getSession();
		
		//System.out.println("등급은?"+session.getAttribute("memberGrade"));
		
		// 세션에 회원 정보가 없으면 로그인 페이지로 리다이렉트
		if (session.getAttribute("midx") == null || !session.getAttribute("memberGrade").equals("관리자")) {
			
			// 로그인 페이지로 리다이렉트
			String location = request.getContextPath() + "/";
			response.sendRedirect(location);
			
			// 요청 처리를 중단하고 false를 반환
			return false;
		} else {
			// 회원 정보가 있으면 요청 처리를 계속 진행
			return true;
		}
	}

}