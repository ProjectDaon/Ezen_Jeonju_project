package com.ezen_jeonju.myapp.filter;

public interface BadWords {
	String[] badWords = {"씨발","존나","병신","시발","지랄"}; //비속어
	String[] delimiters = {" ","", ",", ".", "!","?","@","1","2"}; //비속어 변형 방지
	
	String substituteValue = "*"; //대체문자
}
