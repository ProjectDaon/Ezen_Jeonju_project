package com.ezen_jeonju.myapp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
	public String contentsWriteAction(ContentsVo cv, HttpSession session) throws Exception{
	//	MultipartFile file = cv.getNoticeFileName();
	//	String uploadedFileName="";
	//	if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
	//		uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
	//	}
	//	System.out.println("uploadFileName: "+uploadedFileName);
		cv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
	//	cv.setNoticeUploadedFileName(uploadedFileName);
	//	cv.setNoticeFilePath(uploadPath);
		cs.contentsWrite(cv);
		String category = cv.getContentsCategory();
		
		//System.out.println("넘어온 카테고리: "+category);
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
	public String contentsArticle(@RequestParam("cidx") int cidx, Model model) {
		cs.contentsViewCountUpdate(cidx);
		ContentsVo cv = cs.contentsArticle(cidx);
		model.addAttribute("cv", cv);
		return "/contents/contentsArticle";
	}
	
	@RequestMapping(value="/contentsModify.do")
	public String contentsModify(@RequestParam("cidx") int cidx, Model model) {		
		
		ContentsVo cv = cs.contentsArticle(cidx);		
		model.addAttribute("cv", cv);
		
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
	
	@ResponseBody
	@RequestMapping(value="/searchAddrs.do")
	public JSONObject searchAddrs(@RequestParam("keyword") String keyword) throws Exception {		
		JSONObject js = new JSONObject();
		String address = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query="+keyword;
		Document rawData = Jsoup.connect(address).get();
		
		Elements search = rawData.select("div.vV_z_");
		String addrResult = "";
		
		for(Element option : search) {
			//System.out.println(option);
			
			addrResult = search.select(".LDgIH").text();
			//System.out.println("넘어온거:" +addrResult);
		}
		js.put("addrResult", addrResult);
		return js;
	}
}
