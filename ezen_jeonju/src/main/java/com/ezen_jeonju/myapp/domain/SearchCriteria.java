package com.ezen_jeonju.myapp.domain;

public class SearchCriteria extends Criteria {
	
	private String searchType;
	private String keyword;
	private String keywordFilter;
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getKeywordFilter() {
		return keywordFilter;
	}
	public void setKeywordFilter(String keywordFilter) {
		this.keywordFilter = keywordFilter;
	}
}
