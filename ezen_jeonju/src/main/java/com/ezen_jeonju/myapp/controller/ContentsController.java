package com.ezen_jeonju.myapp.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.service.ContentsService;
import com.ezen_jeonju.myapp.util.UploadFileUtiles;

@Controller
@RequestMapping(value = "/contents")
public class ContentsController {
	
	
	@Autowired
	ContentsService cs;
	private ServletContext servletContext;
	
	 @Resource(name="uploadPath") String uploadPath;
	 
	@RequestMapping(value = "/contentsWrite.do")
	public String contentsWrite() {
		
		return "contents/contentsWrite";
	}
	
	@RequestMapping(value = "/contentsWriteAction.do")
	public String contentsWriteAction(ContentsVo cv, HttpSession session, MultipartHttpServletRequest request) throws Exception {
		MultipartFile file = cv.getUploadFileName();
		cv.setOriginFileName(file.getOriginalFilename());
		cv.setFileSize(file.getSize());
		
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/contents");
		
		String uploadedFileName = "";
		if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
			uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
		}
		cv.setStoredFileName(uploadedFileName.substring(12));
		cv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
		cv.setFilePath(path);
		cs.contentsWrite(cv);
		String category = cv.getContentsCategory();

		if(category.equals("명소")) {
			return "redirect:/contents/sightsList.do";
		}else {
			return "redirect:/contents/foodList.do";
		}
	}
	

	@RequestMapping(value = "/sightsList.do")
	public String sightsList(Model model) {
		ArrayList<ContentsVo> cvlist = cs.sightsList();
		model.addAttribute("cvlist",cvlist);
		return "/contents/sightsList";
	}
	
	@RequestMapping(value = "/foodList.do")
	public String foodList(Model model) {
		ArrayList<ContentsVo> cvlist = cs.foodList();
		model.addAttribute("cvlist",cvlist);
		return "/contents/foodList";
	}
	
	@RequestMapping(value = "/contentsArticle.do")
	public String contentsArticle(@RequestParam("cidx") int cidx, Model model) throws Exception {
		cs.contentsViewCountUpdate(cidx);
		ContentsVo cv = cs.contentsArticle(cidx);
		String hashtagList = cv.getContentsHashtag();
		JSONParser parser = new JSONParser();
		JSONArray jsonArrayObj;
		jsonArrayObj = (JSONArray) parser.parse(hashtagList);
		
		
		model.addAttribute("cv", cv);
		model.addAttribute("hashtag", jsonArrayObj);
		return "/contents/contentsArticle";
	}
	

	@RequestMapping(value="/contentsModify.do")
	public String contentsModify(@RequestParam("cidx") int cidx, Model model) throws Exception {		
		
		ContentsVo cv = cs.contentsArticle(cidx);
		String hashtagList = cv.getContentsHashtag();
		JSONParser parser = new JSONParser();
		JSONArray jsonArrayObj;
		jsonArrayObj = (JSONArray) parser.parse(hashtagList);
		
		StringBuilder result = new StringBuilder();	
        String values = "";
        // JSONArray를 순회하면서 값을 추출하여 문자열로 추가
        for (Object obj : jsonArrayObj) {
            JSONObject jsonObj = (JSONObject) obj;
            String value = (String) jsonObj.get("value");

            // 문자열을 콤마로 구분하여 추가
            result.append(value).append(", ");
        }

        // 마지막 콤마와 공백 제거
        if (result.length() > 0) {
            result.setLength(result.length() - 2);
        }
        values = result.toString();
        System.out.println(values);
		model.addAttribute("cv", cv);
		model.addAttribute("values", values);
		return "/contents/contentsModify";
	}
	
	@RequestMapping(value="/contentsModifyAction.do")
	public String contentsModifyAction(ContentsVo cv) {		
		
		cs.contentsModify(cv);
				
		return "redirect:/contents/contentsArticle.do?cidx="+cv.getCidx();
	}
	

	@RequestMapping(value="/contentsDeleteAction.do")
	public String contentsDeleteAction(@RequestParam("cidx") int cidx, @RequestParam("category") String category) {	

		if(category.equals("명소")) {
			
			cs.contentsDelete(cidx);
			return "redirect:/contents/sightsList.do";
			
		}else {
			
			cs.contentsDelete(cidx);
			return "redirect:/contents/foodList.do";
		}
				
	}
	
	@RequestMapping(value="/youtube.do")
	public String youtube(Model model) throws Exception{
		return "contents/youtube";
	}
	
	public void getYoutube(String nextToken) throws IOException{
		
		String apikey = "AIzaSyA-Gxe4RPySUsdzLv0CR00m1QOKM8rfLjE";
		String channelId = "UCsf5L9ZCtI0nPCqN2aL_4DQ";
		String UPplaylistid ="UUsf5L9ZCtI0nPCqN2aL_4DQ";
		
		String apiUrl = "https://www.googleapis.com/youtube/v3/playlistItems?key="+ apikey
				  + "&playlistId="+ UPplaylistid
				  + "&part=snippet&fields=nextPageToken,pageInfo,items(id,snippet(publishedAt,title,description,thumbnails(high(url)),resourceId(videoId)))&order=date&maxResults=50";
		
		
		//HttpURLConnection con = (HttpURLConnection) url.openConnection();
		//con.setRequestMethod("GET");
		
		//BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		String inputLine;
		StringBuffer response = new StringBuffer();
//		while((inputLine = br.readLine()) != null) {
//			response.append(inputLine);
//		}
//		br.close();
		
		return ;
	}
	
}
