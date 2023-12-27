package com.ezen_jeonju.myapp.controller;

import java.io.File;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.domain.MainPageVo;
import com.ezen_jeonju.myapp.service.AttachFileService;
import com.ezen_jeonju.myapp.service.MainPageService;
import com.ezen_jeonju.myapp.util.UploadFileUtiles;

@Controller


public class MainPageController {
	@Autowired
	MainPageService mps;
	
	@Autowired
	AttachFileService afs;
	
	@Resource(name="uploadPath") String uploadPath;
	

	@RequestMapping(value = "/index.do")
	public String sectionFirstVisual(Model model) {
		ArrayList<MainPageVo> mpvlist = mps.mainPageVannerView();
	    model.addAttribute("mpvlist", mpvlist);
	    return "/index";
	}
	
	
	
	@RequestMapping(value = "/main/vannerRegisterList.do")
	public String vannerRegisterlist() {
		
		return "mypage/registerMainImages";
	}
	
	@RequestMapping(value = "/main/vannerRegister.do")
	public String vannerRegister() {
		
		return "mypage/registerMainImagesWrite";
	}
	
	@RequestMapping(value = "/main/mainVannerRegisterAction.do", method = RequestMethod.POST)
	public String VannerRegisterAction(AttachFileVo af, MainPageVo mpv, HttpSession session, MultipartHttpServletRequest request) throws Exception {
		MultipartFile file = af.getUploadFileName();
		af.setOriginalFileName(file.getOriginalFilename());
		af.setCategory("배너");
		String path = uploadPath+File.separator+"vanners";
		String uploadedFileName = "";
		if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
			uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
		}
		
		af.setThumbnailFilePath(uploadedFileName);
		af.setStoredFilePath(uploadedFileName.substring(0,12)+uploadedFileName.substring(14));
		
		//System.out.println("af값 확인:"+af.getStoredFilePath());
		//System.out.println("제목?"+mpv.getMainPageSubject());
		//System.out.println("시퀀스?"+mpv.getMainPageSequence());
		//System.out.println("링크?"+mpv.getMainPageLink());
		//System.out.println("aidx?"+af.getAidx());
		//System.out.println("midx?"+Integer.parseInt(session.getAttribute("midx").toString()));
		
		afs.imageFileUpload(af);
		mpv.setAidx(af.getAidx());
		System.out.println("컨트롤러에서 aidx 확인:"+af.getAidx());
		mpv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
		mps.mainPageVannerRegister(mpv);

		
		return "mypage/registerMainImages";
	}
}
