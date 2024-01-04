package com.ezen_jeonju.myapp.domain;

public class ScheduleCriteria {
	private int page;	//현재 페이지 번호
	private int perPageNum;		//한 페이지당 보여줄 게시글 수

	
	public ScheduleCriteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {

		this.page = page;
		
	}
	
	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}


}
