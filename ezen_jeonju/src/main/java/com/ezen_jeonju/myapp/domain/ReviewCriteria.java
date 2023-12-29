package com.ezen_jeonju.myapp.domain;

public class ReviewCriteria {
	private int page;	//현재 페이지 번호
	private int perPageNum;		//한 페이지당 보여줄 게시글 수
	private int cidx;
	private String check;
	private int midx;
	
	public ReviewCriteria() {
		this.page = 1;
		this.perPageNum = 5;
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

	public int getCidx() {
		return cidx;
	}

	public void setCidx(int cidx) {
		this.cidx = cidx;
	}

	public String getCheck() {
		return check;
	}

	public void setCheck(String check) {
		this.check = check;
	}

	public int getMidx() {
		return midx;
	}

	public void setMidx(int midx) {
		this.midx = midx;
	}
}
