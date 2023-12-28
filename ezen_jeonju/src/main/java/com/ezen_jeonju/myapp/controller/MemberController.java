package com.ezen_jeonju.myapp.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen_jeonju.myapp.domain.KakaoDTO;
import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.domain.NaverDTO;
import com.ezen_jeonju.myapp.service.MemberService;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	
	@Autowired
	MemberService ms;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value = "/memberLogin.do")
	public String memberLogin() {

		
		return "/member/memberLogin";
	}
	
	
	/*-------------------------------------카카오로그인---------------------------------*/
	@RequestMapping(value = "/KakaoMemberLogin.do")
	public String KakaoMamberLogin() {
		StringBuffer url = new StringBuffer();
		url.append("https://kauth.kakao.com/oauth/authorize?");
		url.append("client_id=7c4b169b2f736ed6cc05e445e9a99cf9");
		url.append("&redirect_uri=http://localhost:8080/member/KakaoMemberLoginAction.do");
		url.append("&response_type=code");
		return "redirect:"+url;
	}
	
	@RequestMapping(value = "/KakaoMemberLoginAction.do", produces="application/json",method= {RequestMethod.GET, RequestMethod.POST})
	public String KakaoMamberLoginAction(@RequestParam("code") String code, HttpSession session) throws IOException {
		System.out.println("#########" + code);
        String access_Token = getKakaoAccessToken(code);
        System.out.println("###access_Token#### : " + access_Token);
		
        KakaoDTO userInfo = getKakaoUserInfo(access_Token);
        System.out.println("###access_Token#### : " + access_Token);

        //카카오 로그인 할 때 마다 DB에서 회원등록 되어있는지 check
        int idCheck = ms.memberIdCheckKakao(userInfo.getMemberId());
        if(idCheck == 0) {
        	//회원등록 안되어있을 시 등록
        	ms.KakaoMemberInsert(userInfo);
        }
        //회원등록 되어있을 시 정보추출
        MemberVo mv = ms.KakaoMemberLogin(userInfo.getMemberId());
        session.setAttribute("midx", mv.getMidx());
        session.setAttribute("memberName", mv.getMemberName());
        session.setAttribute("memberGrade", mv.getMemberGrade());
        session.setAttribute("memberEmail", mv.getMemberEmail());
        
       
		return "redirect:/";
	}
	
	//토큰발급
	public String getKakaoAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=7c4b169b2f736ed6cc05e445e9a99cf9");  //본인이 발급받은 key
            sb.append("&redirect_uri=http://localhost:8080/member/KakaoMemberLoginAction.do");     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }

	//유저정보
	 public KakaoDTO getKakaoUserInfo (String access_Token) {

	    //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		KakaoDTO userInfo = new KakaoDTO();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            String id = element.getAsJsonObject().get("id").getAsString();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            
            
            userInfo.setMemberPwd(access_Token);
            userInfo.setMemberName(nickname);
            userInfo.setMemberEmail(email);
            userInfo.setMemberId(id);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return userInfo;
    }
	/*-----------------------------------네이버 로그인---------------------------------*/
	@RequestMapping(value = "/naverMemberLogin.do")
	public String naverMamberLogin() {
		StringBuffer url = new StringBuffer();
		url.append("https://nid.naver.com/oauth2.0/authorize?");
		url.append("response_type=code");
		url.append("&client_id=p9KIpMowzVUIil3HnoAJ");
		url.append("&state=STATE_STRING&redirect_uri=http://localhost:8080/member/naverMemberLoginAction.do");
		return "redirect:"+url;
	}
	 
	@RequestMapping(value = "/naverMemberLoginAction.do", produces="application/json",method= {RequestMethod.GET, RequestMethod.POST})
	public String naverMemberLoginAction(@RequestParam("code") String code,
										@RequestParam("state") String state, HttpSession session) {
		System.out.println("#########" + code);
		System.out.println("#########" + state);
        String access_Token = getNaverAccessToken(code,state);
        System.out.println("###access_Token#### : " + access_Token);
		
        NaverDTO userInfo = getNaverUserInfo(access_Token);
        System.out.println("###access_Token#### : " + access_Token);
        
        //네이버로그인 할 때 마다 회원인지 확인
        int idCheck = ms.memberIdCheckNaver(userInfo.getMemberId());
        if(idCheck == 0) {
        	//회원이 아닐 때 회원등록 메서드
        	ms.NaverMemberInsert(userInfo);
        }
        //회원등록 되어있을 시 정보추출
        MemberVo mv = ms.NaverMemberLogin(userInfo.getMemberId());
        session.setAttribute("midx", mv.getMidx());
        session.setAttribute("memberName", mv.getMemberName());
        session.setAttribute("memberGrade", mv.getMemberGrade());
        session.setAttribute("memberEmail", mv.getMemberEmail());
        
		return "redirect:/";
	}
	
	public String getNaverAccessToken(String authorize_code, String state) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://nid.naver.com/oauth2.0/token";
		
		try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=p9KIpMowzVUIil3HnoAJ");  //본인이 발급받은 key
            sb.append("&client_secret=FArKhulil0");
            sb.append("&code=" + authorize_code);
            sb.append("&state=" + state);     // 본인이 설정해 놓은 경로
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
		
		return access_Token;
	}
	
	public NaverDTO getNaverUserInfo (String access_Token) {
		NaverDTO userInfo = new NaverDTO(); 
		String reqURL = "https://openapi.naver.com/v1/nid/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            String resultcode = element.getAsJsonObject().get("resultcode").getAsString();
            JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();

            String id = response.getAsJsonObject().get("id").getAsString();
            String nickname = response.getAsJsonObject().get("nickname").getAsString();
            String mobile = response.getAsJsonObject().get("mobile").getAsString();
            String email = response.getAsJsonObject().get("email").getAsString();
            
            System.out.println("resultcode: "+resultcode);
            userInfo.setMemberId(id);
            userInfo.setMemberName(nickname);
            userInfo.setMemberPwd(access_Token);
            userInfo.setMemberPhone(mobile);
            userInfo.setMemberEmail(email);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
		
		return userInfo;
	}
	/*--------------------------------------------------------------------------------------------*/
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
				path="index.do";
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

