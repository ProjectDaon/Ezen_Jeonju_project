package com.ezen_jeonju.myapp.controller;

import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen_jeonju.myapp.domain.AttachFileVo;
import com.ezen_jeonju.myapp.service.AttachFileService;

@Controller
public class ImageController {
	
	@Autowired
	AttachFileService afs;
	
	@RequestMapping(value="/imageLoading.do")
	public String image(@RequestParam("aidx") int aidx, HttpServletResponse response) throws Exception{
		response.setContentType("image/gif");
		ServletOutputStream bout = response.getOutputStream();
		
		AttachFileVo afv = new AttachFileVo();
		afv = afs.imageFileLoad(aidx);
		
		String imgpath = "C:/uploadFile/ezen_Jeonju"+File.separator+afv.getCategory()+afv.getStoredFilePath();
		
		FileInputStream f = new FileInputStream(imgpath);
		int length;
		byte[] buffer = new byte[10];
		while((length = f.read(buffer))!= -1) bout.write(buffer, 0, length);
		
		return null;
	}
}
