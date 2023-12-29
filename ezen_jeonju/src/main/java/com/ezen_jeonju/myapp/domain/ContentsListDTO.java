package com.ezen_jeonju.myapp.domain;

public class ContentsListDTO {
	private int cidx;
	private String contentsSubject;
	private int contentsViewCount;
	private int contentsReviewCount;
	private int likecount;
	private int aidx;
	
	public int getCidx() {
		return cidx;
	}

	public void setCidx(int cidx) {
		this.cidx = cidx;
	}

	public String getContentsSubject() {
		return contentsSubject;
	}

	public void setContentsSubject(String contentsSubject) {
		this.contentsSubject = contentsSubject;
	}

	public int getContentsViewCount() {
		return contentsViewCount;
	}

	public void setContentsViewCount(int contentsViewCount) {
		this.contentsViewCount = contentsViewCount;
	}

	public int getContentsReviewCount() {
		return contentsReviewCount;
	}

	public void setContentsReviewCount(int contentsReviewCount) {
		this.contentsReviewCount = contentsReviewCount;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}

	public int getAidx() {
		return aidx;
	}

	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
}
