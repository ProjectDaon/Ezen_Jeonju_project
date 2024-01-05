package com.ezen_jeonju.myapp.filter;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Component;

@Component
public class BadWordFiltering implements BadWords{
	
	private final Set<String> badWordsSet = new HashSet<>(List.of(badWords));
	private final Map<String, Pattern> badWordPatterns = new HashMap<>();
	
	@PostConstruct 
    public void compileBadWordPatterns() {
		System.out.println("BadWordFiltering bean initialized");
        String patternText = buildPatternText();
        
        for (String word : badWordsSet) {
        	String wordPattern = buildWordPattern(word);
            
        	System.out.println("Word: " + word + ", Pattern: " + wordPattern);
            
            badWordPatterns.put(word, Pattern.compile(wordPattern));  
        }
    }
	
	private String buildWordPattern(String word) {
		String[] chars = word.split("");
	    StringBuilder wordPatternBuilder = new StringBuilder();

	    for (int i = 0; i < chars.length; i++) {
	        wordPatternBuilder.append(Pattern.quote(chars[i]));

	        if (i < chars.length - 1) {
	            wordPatternBuilder.append("(");
	            for (String delimiter : delimiters) {
	                wordPatternBuilder.append(Pattern.quote(delimiter)).append("|");
	            }
	            wordPatternBuilder.deleteCharAt(wordPatternBuilder.length() - 1);  // 맨 마지막의 | 제거
	            wordPatternBuilder.append(")");
	        }
	    }

	    return wordPatternBuilder.toString();
	}
	
	private String buildPatternText() {
        StringBuilder delimiterBuilder = new StringBuilder("["); 
        for (String delimiter : delimiters) {
            delimiterBuilder.append(Pattern.quote(delimiter)); 
        }
        delimiterBuilder.append("]*"); 
        return delimiterBuilder.toString();
    }
	
	public boolean checkBadWord(String input) {
	    for (Pattern pattern : badWordPatterns.values()) {
	        System.out.println("나쁜말패턴" + pattern);
	        Matcher matcher = pattern.matcher(input);
	        if (matcher.find() && matcher.start() == 0) {
	            System.out.println("Found bad word: " + input);
	            return true;
	        }
	    }
	    return false;
	}
	
	public String FindBadWord(String input) {
		for (Map.Entry<String, Pattern> entry : badWordPatterns.entrySet()) {
            String badWord = entry.getKey();
            Pattern pattern = entry.getValue();

            Matcher matcher = pattern.matcher(input);
            if (matcher.find() && matcher.start() == 0) {
                System.out.println("Found bad word in comment: " + input);
                return badWord;
            }
        }
        return null;
	}
	
	public String change(String text) {
        for (Map.Entry<String, Pattern> entry : badWordPatterns.entrySet()) { 
            String word = entry.getKey();
            Pattern pattern = entry.getValue();
            
            System.out.println("Replacing '" + word + "' in '" + text + "'");
            text = text.replace(word, substituteValue);
            
            System.out.println("After replacement: " + text);
            text = pattern.matcher(text).replaceAll(matchedWord ->
                            substituteValue.repeat(matchedWord.group().length())); 
            
            System.out.println("After pattern replacement: " + text);
        }
        return text;
    }
}
