package com.ezen_jeonju.myapp.domain;

public class MypageLikeCriteria {
	private int page;
	private int perPageNum;
	private int clidx;
	private int aidx;
	private String contentsSubject;
	private int midx;
	
	public MypageLikeCriteria() {
		this.page=1;
		this.perPageNum=9;
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
	public int getClidx() {
		return clidx;
	}
	public void setClidx(int clidx) {
		this.clidx = clidx;
	}
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public String getContentsSubject() {
		return contentsSubject;
	}
	public void setContentsSubject(String contentsSubject) {
		this.contentsSubject = contentsSubject;
	}
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
}
