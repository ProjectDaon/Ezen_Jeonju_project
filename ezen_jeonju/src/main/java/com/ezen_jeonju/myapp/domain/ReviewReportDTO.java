package com.ezen_jeonju.myapp.domain;

public class ReviewReportDTO extends ReviewReportVo {
	private String memberName;
	private String myName;
	private String contentsSubject;
	private String reviewArticle;
	private String reporter;
	private String reported;
	
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getReported() {
		return reported;
	}
	public void setReported(String reported) {
		this.reported = reported;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMyName() {
		return myName;
	}
	public void setMyName(String myName) {
		this.myName = myName;
	}
	public String getReviewArticle() {
		return reviewArticle;
	}
	public void setReviewArticle(String reviewArticle) {
		this.reviewArticle = reviewArticle;
	}
	public String getContentsSubject() {
		return contentsSubject;
	}
	public void setContentsSubject(String contentsSubject) {
		this.contentsSubject = contentsSubject;
	}
}
