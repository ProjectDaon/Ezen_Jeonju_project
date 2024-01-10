package com.ezen_jeonju.myapp.domain;

public class NotificationDTO {
	private int ntidx;
	private String notificationCategory;
	private String reviewReportReason;
	private String contentsSubject;
	private String reviewArticle;
	
	public int getNtidx() {
		return ntidx;
	}
	public void setNtidx(int ntidx) {
		this.ntidx = ntidx;
	}
	public String getReviewReportReason() {
		return reviewReportReason;
	}
	public void setReviewReportReason(String reviewReportReason) {
		this.reviewReportReason = reviewReportReason;
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
	public String getNotificationCategory() {
		return notificationCategory;
	}
	public void setNotificationCategory(String notificationCategory) {
		this.notificationCategory = notificationCategory;
	}
}
