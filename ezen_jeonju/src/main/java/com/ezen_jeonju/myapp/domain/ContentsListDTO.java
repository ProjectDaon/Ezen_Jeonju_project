package com.ezen_jeonju.myapp.domain;

public class ContentsListDTO {
	private int cidx;
	private String contentsSubject;
	private int contentsViewCount;
	private int contentsReviewCount;
	private String thumbnailFilePath;
	private int likecount;
	
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

	public String getThumbnailFilePath() {
		return thumbnailFilePath;
	}

	public void setThumbnailFilePath(String thumbnailFilePath) {
		this.thumbnailFilePath = thumbnailFilePath;
	}


	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
}
