package com.ezen_jeonju.myapp.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.domain.ContentsListDTO;
import com.ezen_jeonju.myapp.domain.ContentsSearchCriteria;
import com.ezen_jeonju.myapp.domain.ContentsStatsDTO;
import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.domain.PageMaker;
import com.ezen_jeonju.myapp.service.AttachFileService;
import com.ezen_jeonju.myapp.service.ContentsService;
import com.ezen_jeonju.myapp.util.UploadFileUtiles;


@Controller
@RequestMapping(value = "/contents")
public class ContentsController {
	
	
	@Autowired
	ContentsService cs;
	

	
	@Autowired
	AttachFileService afs;
	private ServletContext servletContext;
	
	 @Resource(name="uploadPath") String uploadPath;
	 
	@RequestMapping(value = "/contentsWrite.do")
	public String contentsWrite() {
		
		return "contents/contentsWrite";
	}
	
	@RequestMapping(value = "/contentsWriteAction.do")
	public String contentsWriteAction(AttachFileVo af, ContentsVo cv, HttpSession session, MultipartHttpServletRequest request) throws Exception {
		
		MultipartFile file = af.getUploadFileName();
		af.setOriginalFileName(file.getOriginalFilename());
		af.setCategory("contents");
		String path = uploadPath+File.separator+"contents";
		String uploadedFileName = "";
		if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
			uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
		}
		af.setThumbnailFilePath(uploadedFileName);
		af.setStoredFilePath(uploadedFileName.substring(0,12)+uploadedFileName.substring(14));
		
		
		afs.imageFileUpload(af);
		cv.setAidx(af.getAidx());
		cv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
		cs.contentsWrite(cv);
		String category = cv.getContentsCategory();

		if(category.equals("명소")) {
			return "redirect:/contents/sight/contentsList.do";
		}else {
			return "redirect:/contents/food/contentsList.do";
		}
	}
	

	@RequestMapping(value = "/{category}/contentsList.do")
	public String sightsList(@PathVariable("category") String category, ContentsSearchCriteria cscri, Model model, HttpSession session) {
		
		switch(category) {
	        case "sight":
	            category = "명소";
	            break;
	        case "food":
	            category = "음식";
	            break;
	    }
		if(cscri.getKeyword()!=null) {
			cscri.setSearch(true);
		}
	    model.addAttribute("category", category);
	    cscri.setCategory(category);
	    int totalCount = cs.totalCount(cscri);
	    PageMaker pm = new PageMaker();
	    pm.setCscri(cscri);
	    pm.setTotalCount(totalCount);
	    
	    ArrayList<ContentsListDTO> cvlist = cs.contentsList(cscri);
	    model.addAttribute("cv", cvlist);
	    model.addAttribute("pm", pm);

	    // 검색어 입력 유지
	    String keyword = (String) cscri.getKeyword(); 
	    if (keyword != null) {
	        session.setAttribute("keyword", keyword); 
	    }
	    
	    return "/contents/contentsList";
	}

	
	@RequestMapping(value = "/contentsArticle.do")
	public String contentsArticle(@RequestParam("cidx") int cidx, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		viewCountUp(cidx, req, res);
		ContentsVo cv = cs.contentsArticle(cidx);
		String hashtagList = cv.getContentsHashtag();
		JSONParser parser = new JSONParser();
		JSONArray jsonArrayObj;
		jsonArrayObj = (JSONArray) parser.parse(hashtagList);
		
		ContentsStatsDTO csd = cs.contentsStats(cidx);
		if(csd.getStarAverage()==null || csd.getStarAverage()=="") {
			csd.setStarAverage("평점없음");
		}
		model.addAttribute("cv", cv);
		model.addAttribute("csd", csd);
		model.addAttribute("hashtag", jsonArrayObj);
		return "/contents/contentsArticle";
	}
	
	
	private void viewCountUp(int cidx, HttpServletRequest req, HttpServletResponse res) {

        Cookie oldCookie = null;

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("boardView")) {
                    oldCookie = cookie;
                }
            }
        }

        if (oldCookie != null) {
            if (!oldCookie.getValue().contains("[" + Integer.toString(cidx) + "]")) {
            	cs.contentsViewCountUpdate(cidx);
                oldCookie.setValue(oldCookie.getValue() + "_[" + cidx + "]");
                oldCookie.setPath("/");
                oldCookie.setMaxAge(60 * 60 * 24);
                res.addCookie(oldCookie);
            }else {
            	System.out.println("쿠키있음");
            }
        } else {
        	cs.contentsViewCountUpdate(cidx);
            Cookie newCookie = new Cookie("boardView","[" + cidx + "]");
            newCookie.setPath("/");
            newCookie.setMaxAge(60 * 60 * 24);
            res.addCookie(newCookie);
        }
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
        
        AttachFileVo af = afs.imageFileLoad(cv.getAidx());
        values = result.toString();
        model.addAttribute("af", af);
		model.addAttribute("cv", cv);
		model.addAttribute("values", values);
		return "/contents/contentsModify";
	}
	
	@RequestMapping(value="/contentsModifyAction.do")
	public String contentsModifyAction(AttachFileVo af, ContentsVo cv, 
						@RequestParam("storedFile") String storedFile,
						@RequestParam("storedThumbnail") String storedThumbnail) throws Exception {	
		if(af.getUploadFileName() != null && !af.getUploadFileName().isEmpty()) {
			
			//기존 파일 삭제하기
			try {
	            deleteFile("C:/uploadFile/ezen_Jeonju/contents/"+storedFile);
	            deleteFile("C:/uploadFile/ezen_Jeonju/contents/"+storedThumbnail);
	            System.out.println("File deleted successfully.");
	        } catch (IOException e) {
	            System.err.println("Error deleting file: " + e.getMessage());
	        }
			
			//새로운 파일 업로드하기
			MultipartFile file = af.getUploadFileName();
			af.setOriginalFileName(file.getOriginalFilename());
			af.setCategory("컨텐츠");
			String path = uploadPath+File.separator+"contents";
			String uploadedFileName = "";
			if(!file.getOriginalFilename().equals("")) {
				//업로드 시작
				uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
			}
			af.setThumbnailFilePath(uploadedFileName);
			af.setStoredFilePath(uploadedFileName.substring(0,12)+uploadedFileName.substring(14));
			
			//새로운 파일 db에 적용하기
			afs.imageFileModify(af);
		}
		
		cs.contentsModify(cv);
		return "redirect:/contents/contentsArticle.do?cidx="+cv.getCidx();
	}
	
	private static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }

	@RequestMapping(value="/contentsDeleteAction.do")
	public String contentsDeleteAction(@RequestParam("cidx") int cidx, @RequestParam("category") String category) {	

		if(category.equals("명소")) {
			
			cs.contentsDelete(cidx);
			return "redirect:/contents/sight/contentsList.do";
			
		}else {
			
			cs.contentsDelete(cidx);
			return "redirect:/contents/food/contentsList.do";
		}
				
	}
	
	@RequestMapping(value="/youtube.do")
	public String youtube(@RequestParam("page") int page ,Model model) throws Exception{
		model.addAttribute("page",page);
		return "contents/youtube";
	}
	

}
