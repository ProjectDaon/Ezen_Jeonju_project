package com.ezen_jeonju.myapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen_jeonju.myapp.service.ContentsService;
import com.ezen_jeonju.myapp.service.MainPageService;

@Controller
@RequestMapping(value = "/main")
public class MainPageController {
	@Autowired
	MainPageService mps;

}
