package com.ezen_jeonju.myapp.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/test")
public class TestController {
	
	@RequestMapping(value = "/crolling_test")
	public String crolling_test(Model model) throws Exception {
		
		String query = "전주한옥마을";
		ArrayList<String> al1 = new ArrayList<>();
		ArrayList<String> al2 = new ArrayList<>();
		ArrayList<String> al3 = new ArrayList<>();
		ArrayList<String> al4 = new ArrayList<>();
		
		String address = "https://search.naver.com/search.naver?query="+query+"&nso=&where=blog&sm=tab_opt";
		Document rawData = Jsoup.connect(address).get();
		
		Elements blogOption = rawData.select("li.bx");

		String realURL = "";
		String realTitle = "";
		String blogName = "";
		String realContents = "";
		for(Element option : blogOption) {
			//System.out.println(option);
			//블로그 링크
			realURL = option.select(".title_area a").attr("href");
			//게시글 제목
			Elements titleDiv = option.select(".title_area");
			realTitle = titleDiv.select("a").text();
			//게시글 내용
			Elements contentsDiv = option.select(".dsc_area");
			realContents = contentsDiv.select("a").text();
			if(realContents.length()>=30) realContents = realContents.substring(0, 80);
			//블로그 이름
			Elements blognameDiv = option.select(".user_info");
			blogName = blognameDiv.select("a").text();
			
			
//			System.out.println("링크: "+realURL);
//			System.out.println("제목: "+realTitle);
//			System.out.println("내용: "+realContents);
//			System.out.println("블로그: "+blogName);
			al1.add(realURL);
			al2.add(realTitle);
			al3.add(blogName);
			al4.add(realContents);
		}

		model.addAttribute("url",al1);
		model.addAttribute("title",al2);
		model.addAttribute("blogname",al3);
		model.addAttribute("contents",al4);
		return "contents/crolling_test";
	}
	
	@RequestMapping(value = "/crolling_test2")
	public String crolling_test2(Model model) throws Exception {
		String query = "전주한옥마을";
		ArrayList<String> al1 = new ArrayList<>();
		ArrayList<String> al2 = new ArrayList<>();
		ArrayList<String> al3 = new ArrayList<>();
		ArrayList<String> al4 = new ArrayList<>();
		
		Path path = Paths.get(System.getProperty("user.dir"), "/resources/chromedriver");
		System.setProperty("webdriver.chrome.driver", path.toString());
		
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--start-maximized");
		ChromeDriver driver = new ChromeDriver( options );
		
		// 웹페이지 요청
        driver.get("https://search.naver.com/search.naver?query="+query+"&nso=&where=blog&sm=tab_opt");
        driver.executeScript("window.scrollBy(0,1000);");
        Thread.sleep(1000);
        
        WebElement liDiv = driver.findElement(By.className("bx"));
        
        
		return "contents/crolling_test";
	}
}


