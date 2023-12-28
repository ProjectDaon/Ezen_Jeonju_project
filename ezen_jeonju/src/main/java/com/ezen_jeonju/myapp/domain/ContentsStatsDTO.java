package com.ezen_jeonju.myapp.domain;

public class ContentsStatsDTO {
	//각 컨텐츠 별점 평균, 리뷰수, 좋아요수
	private String starAverage;
	private int reviewCount;
	private int likeCount;

	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getStarAverage() {
		return starAverage;
	}
	public void setStarAverage(String starAverage) {
		this.starAverage = starAverage;
	}
	
}
