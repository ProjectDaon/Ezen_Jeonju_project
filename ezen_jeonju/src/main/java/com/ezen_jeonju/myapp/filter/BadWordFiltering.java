package com.ezen_jeonju.myapp.filter;

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
        for (String word : badWordsSet) {
        	String wordPattern = buildWordPattern(word);
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
	            wordPatternBuilder.deleteCharAt(wordPatternBuilder.length() - 1);  
	            wordPatternBuilder.append(")");
	        }
	    }

	    return wordPatternBuilder.toString();
	}
	
	public boolean checkBadWord(String input) {
	    for (Pattern pattern : badWordPatterns.values()) {
	        Matcher matcher = pattern.matcher(input);
	        if (matcher.find() && matcher.start() == 0) {
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
                return badWord;
            }
        }
        return null;
	}
	
	public String change(String text) {
        for (Map.Entry<String, Pattern> entry : badWordPatterns.entrySet()) { 
            String word = entry.getKey();
            Pattern pattern = entry.getValue();
            
            text = text.replace(word, substituteValue);
            
            text = pattern.matcher(text).replaceAll(matchedWord ->
                            substituteValue.repeat(matchedWord.group().length())); 
        }
        return text;
    }
}
