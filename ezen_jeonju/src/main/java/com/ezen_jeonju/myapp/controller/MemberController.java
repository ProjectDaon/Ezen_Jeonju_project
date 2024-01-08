package com.ezen_jeonju.myapp.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen_jeonju.myapp.domain.GoogleInfResponse;
import com.ezen_jeonju.myapp.domain.GoogleRequest;
import com.ezen_jeonju.myapp.domain.GoogleResponse;
import com.ezen_jeonju.myapp.domain.KakaoDTO;
import com.ezen_jeonju.myapp.domain.MemberVo;
import com.ezen_jeonju.myapp.domain.NaverDTO;
import com.ezen_jeonju.myapp.domain.NoticeVo;
import com.ezen_jeonju.myapp.service.MemberService;
import com.ezen_jeonju.myapp.util.NaverMailSend;
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
            String email = response.getAsJsonObject().get("email").getAsString();
            
            System.out.println("resultcode: "+resultcode);
            userInfo.setMemberId(id);
            userInfo.setMemberName(nickname);
            userInfo.setMemberPwd(access_Token);
            userInfo.setMemberEmail(email);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
		
		return userInfo;
	}
	
	/*--------------------------------------구글로그인-------------------------------------*/
	@RequestMapping(value="/googleMemberLogin.do")
	public String googleMemberLogin() {
		StringBuffer url = new StringBuffer();
		url.append("https://accounts.google.com/o/oauth2/v2/auth?");
		url.append("client_id=859504643059-8kf72j9o22utqp8e7ovqohcpsjigmhfa.apps.googleusercontent.com");
		url.append("&redirect_uri=http://localhost:8080/member/googleLoginAction.do&response_type=code&scope=email profile openid");
		return "redirect:"+url;
	}
	
	@RequestMapping(value="googleLoginAction.do", method = RequestMethod.GET)
	public String googleLoginAction(@RequestParam("code") String code, HttpSession session) {
		RestTemplate restTemplate = new RestTemplate();
		GoogleRequest googleOAuthRequestParam = new GoogleRequest
				.Builder()
				.clientId("859504643059-8kf72j9o22utqp8e7ovqohcpsjigmhfa.apps.googleusercontent.com")
				.clientSecret("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")
				.code(code)
				.redirectUri("http://localhost:8080/member/googleLoginAction.do")
				.grantType("authorization_code").build();
		
		ResponseEntity<GoogleResponse> resultEntity = restTemplate.postForEntity("https://oauth2.googleapis.com/token", googleOAuthRequestParam, GoogleResponse.class);
		String jwtToken=resultEntity.getBody().getId_token();
        Map<String, String> map=new HashMap<>();
        map.put("id_token",jwtToken);
        ResponseEntity<GoogleInfResponse> resultEntity2 = restTemplate.postForEntity("https://oauth2.googleapis.com/tokeninfo", map, GoogleInfResponse.class);
        String sub = resultEntity2.getBody().getSub(); //사용자ID
        String name = resultEntity2.getBody().getName(); //사용자이름
        String email=resultEntity2.getBody().getEmail(); //사용자 이메일 
        String kid = resultEntity2.getBody().getKid(); //키ID
        GoogleInfResponse googleDto = new GoogleInfResponse();
        googleDto.setSub(sub);
        googleDto.setName(name);
        googleDto.setEmail(email);
        googleDto.setKid(kid);
        
        int idCheck = ms.memberIdCheckGoogle(sub);
        if(idCheck==0) {
        	ms.GoogleMemberInsert(googleDto);
        }
        MemberVo mv = ms.GoogleMemberLogin(sub);
        session.setAttribute("midx", mv.getMidx());
        session.setAttribute("memberName", mv.getMemberName());
        session.setAttribute("memberGrade", mv.getMemberGrade());
        session.setAttribute("memberEmail", mv.getMemberEmail());
        
        System.out.println("sub:"+resultEntity2.getBody().getSub());
        System.out.println("name:"+resultEntity2.getBody().getName());
        System.out.println("kid:"+resultEntity2.getBody().getKid());
        System.out.println(email);
        
        
		return "redirect:/index.do";
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
	
	@ResponseBody
	@RequestMapping(value="/mailAuth.do")
	public JSONObject mailAuth(@RequestParam("memberEmail") String memberEmail, HttpSession session) {
		JSONObject js = new JSONObject();
		
		NaverMailSend nm = new NaverMailSend();
		try {
			nm.sendEmail(memberEmail, session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return js;
	}
	
	@ResponseBody
	@RequestMapping(value="/mailAuthCheck.do")
	public JSONObject mailAuthCheck(@RequestParam("authNumber") String authNumber, HttpSession session) {
		JSONObject js = new JSONObject();
		String savedPass = (String) session.getAttribute("authenCode");
		String txt = "";
		if(authNumber.equals(savedPass)) {
			txt = "pass";
			session.setAttribute("mailPass", "pass");
		}else {
			txt = "인증실패";
		}
		
		js.put("txt", txt);
		return js;
	}
	
	@RequestMapping(value = "/memberJoinAction.do")
	public String memberJoinAction(@Valid MemberVo mv, HttpSession session, Model model, BindingResult bindingResult) { // input 객체들의 값을 바인딩한다.
		if (bindingResult.hasErrors()) {
			
            return "member/memberJoin"; // 오류 페이지로 리다이렉트 또는 포워드
        }
		String authSession = (String) session.getAttribute("mailPass");
		
		if(authSession!=null && authSession.equals("pass")) {
			String memberPwd2 = bcryptPasswordEncoder.encode(mv.getMemberPwd());
			mv.setMemberPwd(memberPwd2); 
			int value = ms.memberInsert(mv);
			return "redirect:/"; // 포워드방식이 아닌 sendRedirect 방식
		}else {
			model.addAttribute("error", "메일인증이 처리되지 않았습니다.");
			return "member/memberJoin";
		}
		


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
	
	@RequestMapping(value = "/findInfo.do")
	public String findInfo() {
		return "member/findInfo";
	}
	
	@RequestMapping(value = "/findId.do")
	public String findId(@RequestParam("memberEmail") String memberEmail, Model model) {
		ArrayList<MemberVo> mv = ms.findId(memberEmail);
		model.addAttribute("idList", mv);

		return "member/resultInfo";
	}
	
	@RequestMapping(value="/checkInfo.do")
	public String checkInfo(MemberVo mv, HttpSession session, Model model) {
		int value = ms.checkInfo(mv);
		if(value != 0) {
			session.setAttribute("memberId", mv.getMemberId());
			session.setAttribute("memberEmail", mv.getMemberEmail());
			session.setMaxInactiveInterval(180);
			return "redirect:/member/searchPwd.do";
		}else {
			model.addAttribute("alertMessage", "일치하는 정보가 없습니다.");
			return "/member/findInfo";
		}
	}
	
	@RequestMapping(value = "/searchPwd.do")
	public String searchPwd(HttpSession session) {
		String memberEmail = session.getAttribute("memberEmail").toString();
		
		NaverMailSend nm = new NaverMailSend();
		try {
			nm.sendEmail(memberEmail, session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/searchPwd";
	}
	
	@ResponseBody
	@RequestMapping(value="/mailAuthCheckPwd.do")
	public JSONObject mailAuthCheckPwd(@RequestParam("authNumber") String authNumber, HttpSession session) {
		JSONObject js = new JSONObject();
		String savedPass = (String) session.getAttribute("authenCode");
		String txt = "";
		String url = "";
		if(authNumber.equals(savedPass)) {
			txt = "pass";
			session.setAttribute("mailPass", "pass");
			url = "/member/changePwd.do";
			js.put("url", url);
		}else {
			txt = "인증실패";
		}
		
		js.put("txt", txt);
		return js;
	}
	
	@RequestMapping(value="/changePwd.do")
	public String changePwd() {
		
		
		return "/member/changePwd";
	}
	
	@RequestMapping(value="/changePwdAction.do")
	public String changePwdAction(@Valid MemberVo mv, HttpSession session) {
		
		String authSession = (String) session.getAttribute("mailPass");
		
		if(authSession!=null && authSession.equals("pass")) {
			String memberId = session.getAttribute("memberId").toString();
			String memberEmail = session.getAttribute("memberEmail").toString();
			mv.setMemberId(memberId);
			mv.setMemberEmail(memberEmail);
			
			String memberPwd = mv.getMemberPwd();
			mv.setMemberPwd(bcryptPasswordEncoder.encode(memberPwd));
			
			int value = ms.changePwd(mv);
			return "redirect:/";
		}else {
			return "redirect:/member/findInfo.do";
		}
		
	}
}

