package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.service.ContentsService;

@Controller
@RequestMapping(value = "/contents")
public class ContentsController {
	
	@Autowired
	ContentsService cs;
	
	/*
	 * @Resource(name="uploadPath") String uploadPath;
	 */
	@RequestMapping(value = "/contentsWrite.do")
	public String contentsWrite() {
		
		return "contents/contentsWrite";
	}
	
	@RequestMapping(value = "/contentsWriteAction.do")
	public String contentsWriteAction(ContentsVo cv, HttpSession session) {
	//	MultipartFile file = cv.getNoticeFileName();
	//	String uploadedFileName="";
	//	if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
	//		uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
	//	}
		cv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
	//	cv.setNoticeUploadedFileName(uploadedFileName);
	//	cv.setNoticeFilePath(uploadPath);
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
	

}
