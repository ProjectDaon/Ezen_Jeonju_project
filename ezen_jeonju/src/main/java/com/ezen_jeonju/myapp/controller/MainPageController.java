package com.ezen_jeonju.myapp.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.domain.ContentsVo;
import com.ezen_jeonju.myapp.domain.MainPageVo;
import com.ezen_jeonju.myapp.domain.NoticeVo;
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
		ArrayList<ContentsVo> cvlist = mps.mainPageSecondView();
		ArrayList<ContentsVo> cvtop3list = mps.mainPageThirdView();
		ArrayList<NoticeVo> nvlist = mps.mainPageNoticeView();
	    model.addAttribute("mpvlist", mpvlist);
	    model.addAttribute("cvlist", cvlist);
	    model.addAttribute("cvtop3list", cvtop3list);
	    model.addAttribute("nvlist", nvlist);
	    
	    return "/index";
	}
	
	
	
	@RequestMapping(value = "/main/vannerRegisterList.do")
	public String vannerRegisterlist(Model model) {
		ArrayList<MainPageVo> mpvlist = mps.registeredVanners();
		model.addAttribute("mpvlist", mpvlist);
		
		return "mypage/registerMainImages";
	}
	
	@RequestMapping(value = "/main/mainVannerContents.do")
	public String vannerRegisterlist(@RequestParam("mpidx") int mpidx, Model model) {
		
		MainPageVo mpv= mps.vannerContent(mpidx);
		AttachFileVo af = afs.imageFileLoad(mpv.getAidx());
		
		model.addAttribute("mpv",mpv);
		model.addAttribute("af",af);
		
		return "mypage/registerMainImagesModify";
	}
	
	@RequestMapping(value="/main/mainVannerModifyAction.do")
	public String vannerModify(AttachFileVo af, MainPageVo mpv, 
						@RequestParam("storedFile") String storedFile,
						@RequestParam("storedThumbnail") String storedThumbnail) throws Exception {	
		if(af.getUploadFileName() != null && !af.getUploadFileName().isEmpty()) {
			
			//기존 파일 삭제하기
			try {
	            deleteFile("C:/uploadFile/ezen_Jeonju/vanners/"+storedFile);
	            deleteFile("C:/uploadFile/ezen_Jeonju/vanners/"+storedThumbnail);
	            System.out.println("File deleted successfully.");
	        } catch (IOException e) {
	            System.err.println("Error deleting file: " + e.getMessage());
	        }
			
			//새로운 파일 업로드하기
			MultipartFile file = af.getUploadFileName();
			af.setOriginalFileName(file.getOriginalFilename());
			af.setCategory("vanners");
			String path = uploadPath+File.separator+"vanners";
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
		mps.vannerModify(mpv);
		return "redirect:/main/mainVannerContents.do?mpidx="+mpv.getMpidx();
	}
	
	private static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
	
	@RequestMapping(value = "/main/mainVannerDeleteAction.do")
	public String vannerDelete(MainPageVo mpv, RedirectAttributes redirectAttributes, Model model) {
	    int value = mps.vannerCount(mpv);
	    if (value <= 2) {
	        // value가 2 이하인 경우, 리다이렉트 시 메시지 전달
	        redirectAttributes.addFlashAttribute("message", "등록된 배너 2개 이하로 삭제는 불가능합니다.");
	    } else {
	        mps.vannerDelete(mpv);
	    }

	    return "redirect:/main/vannerRegisterList.do";
	}


	@RequestMapping(value = "/main/vannerRegister.do")
	public String vannerRegister(@RequestParam("mainPageSequence") int mainPageSequence, Model model) {
		MainPageVo mpv = new MainPageVo();
		mpv.setMainPageSequence(mainPageSequence);
		model.addAttribute("mpv",mpv);
		return "mypage/registerMainImagesWrite";
	}
	
	@RequestMapping(value = "/main/mainVannerRegisterAction.do", method = RequestMethod.POST)
	public String VannerRegisterAction(AttachFileVo af, MainPageVo mpv, HttpSession session, MultipartHttpServletRequest request) throws Exception {
		MultipartFile file = af.getUploadFileName();
		af.setOriginalFileName(file.getOriginalFilename());
		af.setCategory("vanners");
		String path = uploadPath+File.separator+"vanners";
		String uploadedFileName = "";
		if(!file.getOriginalFilename().equals("")) {
			//업로드 시작
			uploadedFileName = UploadFileUtiles.uploadFile(path, file.getOriginalFilename(), file.getBytes());
		}
		
		af.setThumbnailFilePath(uploadedFileName);
		af.setStoredFilePath(uploadedFileName.substring(0,12)+uploadedFileName.substring(14));
		
		afs.imageFileUpload(af);
		mpv.setAidx(af.getAidx());
		mpv.setMidx(Integer.parseInt(session.getAttribute("midx").toString()));
		mps.mainPageVannerRegister(mpv);

		
		return "redirect:/main/vannerRegisterList.do";
	}
}
