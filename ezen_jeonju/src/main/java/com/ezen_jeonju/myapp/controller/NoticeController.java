package com.ezen_jeonju.myapp.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.domain.Criteria;
import com.ezen_jeonju.myapp.domain.NoticeVo;
import com.ezen_jeonju.myapp.service.AttachFileService;
import com.ezen_jeonju.myapp.service.NoticeService;
import com.ezen_jeonju.myapp.util.UploadFileUtiles;
import com.ezen_jeonju.myapp.domain.PageMaker;
import com.ezen_jeonju.myapp.domain.SearchCriteria;

@Controller
@RequestMapping(value = "/notice")
public class NoticeController {
	
	@Autowired
	NoticeService ns;
	
	@Autowired(required=false)
	private PageMaker pm;
	
	@Autowired
	AttachFileService afs;
	private ServletContext servletContext;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@RequestMapping(value = "/noticeWrite.do")
	public String noticeWrite() {
		return "notice/noticeWrite";
	}
	
	@RequestMapping(value = "/noticeWriteAction.do")
	public String noticeWriteAction(AttachFileVo af, NoticeVo nv, HttpSession session, MultipartHttpServletRequest request) throws Exception{
		MultipartFile file = af.getUploadFileName();
		af.setOriginalFileName(file.getOriginalFilename());
		af.setCategory("notice");
		String path = uploadPath+File.separator+"notice";
		String uploadedFileName="";
		if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
			uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
		}
		af.setThumbnailFilePath(uploadedFileName);
		af.setStoredFilePath(uploadedFileName.substring(0,12)+uploadedFileName.substring(14));
		
		System.out.println("af값 확인:"+af.getStoredFilePath());
		
		afs.imageFileUpload(af);
		nv.setAidx(af.getAidx());
		System.out.println("컨트롤러에서 aidx 확인:"+af.getAidx());
		nv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
		
		ns.noticeWrite(nv);
		
		return "redirect:/notice/noticeList.do";
	}
	
	@RequestMapping(value = "/noticeList.do")
	public String noticeList(Criteria cri, SearchCriteria scri, Model model, HttpSession session) {
		
		int totalCount = ns.noticeTotalCount(scri);
		pm.setCri(cri);
		pm.setScri(scri);
		pm.setTotalCount(totalCount);
				
		ArrayList<NoticeVo> nvlist = ns.noticeList(scri);
		model.addAttribute("nvlist",nvlist);
		model.addAttribute("pm", pm);
		
		// 검색어 입력 유지
		String keyword = (String)scri.getKeyword();
		if(keyword != null) {
			model.addAttribute("keyword", keyword); 
		}
		
		// 검색타입 선택 유지
		String searchType = (String)scri.getSearchType();
		if(searchType != null) {
			session.setAttribute("searchType", searchType);
		}
		
		/* model.addAttribute("keyword", keyword); */
		
		return "/notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeContents.do")
	public String noticeContents(@RequestParam("nidx") int nidx, Model model) throws Exception {
		NoticeVo nv = ns.noticeContents(nidx);
		String hashtagList = nv.getNoticeHashtag();
		JSONParser parser = new JSONParser();
		JSONArray jsonArrayObj;
		jsonArrayObj = (JSONArray) parser.parse(hashtagList);
		AttachFileVo af = afs.imageFileLoad(nv.getAidx());
		
		model.addAttribute("af",af);
		model.addAttribute("nv", nv);
		model.addAttribute("hashtag", jsonArrayObj);
		return "/notice/noticeContents";
	}
	
	@RequestMapping(value="/noticeModify.do")
	public String noticeModify(@RequestParam("nidx") int nidx, Model model) throws Exception {
		NoticeVo nv = ns.noticeContents(nidx);
		AttachFileVo af = afs.imageFileLoad(nv.getAidx());

		String hashtagList = nv.getNoticeHashtag();
		JSONParser parser = new JSONParser();
		JSONArray jsonArrayObj;
		jsonArrayObj = (JSONArray) parser.parse(hashtagList);
		
		StringBuilder result = new StringBuilder();	
		String values = "";
		// JSONArray를 순회하면서 값을 추출하여 문자열로 추가
		for (Object obj : jsonArrayObj) {
			JSONObject jsonObj = (JSONObject) obj;
			String value = (String) jsonObj.get("value");
			
			result.append(value).append(", ");
		}
		
		// 마지막 문자는 콤마와 공백 제거
		if (result.length() > 0) {
			result.setLength(result.length() - 2);
		}
		values = result.toString();
		model.addAttribute("af", af);
		model.addAttribute("nv", nv);
		/* model.addAttribute("hashtag", jsonArrayObj); */
		model.addAttribute("values", values);
		return "/notice/noticeModify";
	}
	
	@RequestMapping(value="/noticeModifyAction.do")
	public String noticeModifyAction(AttachFileVo af, NoticeVo nv,
			@RequestParam("nidx") int nidx,
			@RequestParam("storedFile") String storedFile,
			@RequestParam("storedThumbnail") String storedThumbnail) throws Exception {
		
		if(af.getUploadFileName() != null && !af.getUploadFileName().isEmpty()) {
			
			//기존 파일 삭제하기
			try {// 아래에 deleteFile Method 생성
				deleteFile("C:/uploadFile/ezen_Jeonju/contents/"+storedFile);
				deleteFile("C:/uploadFile/ezen_Jeonju/contents/"+storedThumbnail);
				System.out.println("File deleted successfully.");
			} catch (IOException e) {
				System.err.println("Error deleting file: " + e.getMessage());
			}
			
			//새로운 파일 업로드하기
			MultipartFile file = af.getUploadFileName();
			af.setOriginalFileName(file.getOriginalFilename());
			af.setCategory("notice");
			String path = uploadPath+File.separator+"notice";
			String uploadedFileName="";
			if(!file.getOriginalFilename().equals("")) {
				//업로드 시작
				uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
			}
			af.setThumbnailFilePath(uploadedFileName);
			af.setStoredFilePath(uploadedFileName.substring(0,12)+uploadedFileName.substring(14));
			
			afs.imageFileModify(af);
		}
		ns.noticeModify(nv);
		System.out.println("nids:" + nidx);
		return "redirect:/notice/noticeContents.do?nidx="+nv.getNidx();
	}
	
	private void deleteFile(String filePath) throws IOException {
		Path path = Paths.get(filePath);
		Files.deleteIfExists(path);
	}

	@RequestMapping(value="/noticeDeleteAction.do")
	public String noticeDeleteAction(@RequestParam("nidx") int nidx, @RequestParam("category") String category) {	
		ns.noticeDelete(nidx);
		return "redirect:/notice/noticeList.do";
		
	}	
}
