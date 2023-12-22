package com.ezen_jeonju.myapp.controller;

import java.io.InputStream;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ImageController {
	
	@RequestMapping(value="/image")
	public String image(){
		
		
		return "member/memberJoin";
	}
}
