package com.ezen_jeonju.myapp.domain;

//페이징을 하기 위한 기준이 되는 데이터 클래스
public class Criteria {
	
	private int page;	//현재 페이지 번호
	private int perPageNum;		//한 페이지당 보여줄 게시글 수
	
//	public int getPageStart() {
//		return (this.page-1)*perPageNum;
//	}
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 9;
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
