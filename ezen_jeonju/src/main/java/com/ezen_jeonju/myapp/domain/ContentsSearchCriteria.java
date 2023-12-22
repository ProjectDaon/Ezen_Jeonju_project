package com.ezen_jeonju.myapp.domain;

public class ContentsSearchCriteria extends Criteria{
	private String category;
	private boolean search = false;
	private String keyword;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public boolean isSearch() {
		return search;
	}
	public void setSearch(boolean search) {
		this.search = search;
	}
}
