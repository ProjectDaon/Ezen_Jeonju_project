package com.ezen_jeonju.myapp.domain;

public class ReviewVo {
	private int ridx;
	private int cidx;
	private int midx;
	private String reviewArticle;
	private int reviewScore;
	private String reviewPhoto;
	private String reviewPhotoPath;
	private String reviewYN;
	private String reviewWriteday;
	
	public int getRidx() {
		return ridx;
	}
	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public String getReviewArticle() {
		return reviewArticle;
	}
	public void setReviewArticle(String reviewArticle) {
		this.reviewArticle = reviewArticle;
	}
	public int getReviewScore() {
		return reviewScore;
	}
	public void setReviewScore(int reviewScore) {
		this.reviewScore = reviewScore;
	}
	public String getReviewPhoto() {
		return reviewPhoto;
	}
	public void setReviewPhoto(String reviewPhoto) {
		this.reviewPhoto = reviewPhoto;
	}
	public String getReviewPhotoPath() {
		return reviewPhotoPath;
	}
	public void setReviewPhotoPath(String reviewPhotoPath) {
		this.reviewPhotoPath = reviewPhotoPath;
	}
	public String getReviewYN() {
		return reviewYN;
	}
	public void setReviewYN(String reviewYN) {
		this.reviewYN = reviewYN;
	}
	public String getReviewWriteday() {
		return reviewWriteday;
	}
	public void setReviewWriteday(String reviewWriteday) {
		this.reviewWriteday = reviewWriteday;
	}
}
