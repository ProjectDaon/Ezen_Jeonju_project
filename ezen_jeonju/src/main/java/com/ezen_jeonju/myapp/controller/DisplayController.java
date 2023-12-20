package com.ezen_jeonju.myapp.controller;

import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen_jeonju.myapp.util.MediaUtils;

@Controller
public class DisplayController {
	private static Logger logger = LoggerFactory.getLogger(DisplayController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;

	
	
/*	@RequestMapping(value="/display")
	public ResponseEntity<Resource> contentsDisplay(@RequestParam("filename") String filename, @RequestParam("category") String category){
		System.out.println("filename: "+filename);
		String path="C:\\uploadFile\\ezen_Jeonju\\";
		String folder = "";
		switch(category) {
		case "contents":
			folder = "contents\\";
			break;
		}
		
		Resource resource = new FileSystemResource(path + folder + filename);
		
		if(!resource.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		HttpHeaders header = new HttpHeaders();
		Path filePath = null;
		
		try {
		filePath = Paths.get(path + folder + filename);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}*/
	
	@RequestMapping(value = "/display")
	public ResponseEntity<byte[]> displayFile(@RequestParam("name") String fileName)throws Exception{
		
		logger.info("uploadPath: " + uploadPath);
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath+fileName);
			
			//step: change HttpHeader ContentType
			if(mType != null) {
				//image file(show image)
				headers.setContentType(mType);
			}else {
				//another format file(download file)
				fileName = fileName.substring(fileName.indexOf("_")+1);//original file Name
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\""); 
			}
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
			return entity;
		
	}

}
