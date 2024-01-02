package com.ezen_jeonju.myapp.domain;

public class MypageReviewDTO {
	private int ridx;
	private int aidx;
	private int cidx;
	private int reviewScore;
	private String reviewArticle;
	private String reviewWriteday;
	private String contentsSubject;
	
	public int getRidx() {
		return ridx;
	}
	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public int getReviewScore() {
		return reviewScore;
	}
	public void setReviewScore(int reviewScore) {
		this.reviewScore = reviewScore;
	}
	public String getReviewWriteday() {
		return reviewWriteday;
	}
	public void setReviewWriteday(String reviewWriteday) {
		this.reviewWriteday = reviewWriteday;
	}
	public String getContentsSubject() {
		return contentsSubject;
	}
	public void setContentsSubject(String contentsSubject) {
		this.contentsSubject = contentsSubject;
	}
	public String getReviewArticle() {
		return reviewArticle;
	}
	public void setReviewArticle(String reviewArticle) {
		this.reviewArticle = reviewArticle;
	}
}
