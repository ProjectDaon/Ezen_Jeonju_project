package com.ezen_jeonju.myapp.domain;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVo {
	private int nidx;
	private int midx;
	private String noticeSubject;
	private String noticeCategory;
	private String noticeArticle;
	private MultipartFile noticeFileName;
	private String noticeUploadedFileName;
	private String noticeFilePath;
	private String noticeWriteday;
	private String noticeYN;
	
	public int getNidx() {
		return nidx;
	}
	public void setNidx(int nidx) {
		this.nidx = nidx;
	}
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public String getNoticeSubject() {
		return noticeSubject;
	}
	public void setNoticeSubject(String noticeSubject) {
		this.noticeSubject = noticeSubject;
	}
	public String getNoticeCategory() {
		return noticeCategory;
	}
	public void setNoticeCategory(String noticeCategory) {
		this.noticeCategory = noticeCategory;
	}
	public String getNoticeArticle() {
		return noticeArticle;
	}
	public void setNoticeArticle(String noticeArticle) {
		this.noticeArticle = noticeArticle;
	}
	public String getNoticeFilePath() {
		return noticeFilePath;
	}
	public void setNoticeFilePath(String noticeFilePath) {
		this.noticeFilePath = noticeFilePath;
	}
	public String getNoticeWriteday() {
		return noticeWriteday;
	}
	public void setNoticeWriteday(String noticeWriteday) {
		this.noticeWriteday = noticeWriteday;
	}
	public String getNoticeYN() {
		return noticeYN;
	}
	public void setNoticeYN(String noticeYN) {
		this.noticeYN = noticeYN;
	}
	public MultipartFile getNoticeFileName() {
		return noticeFileName;
	}
	public void setNoticeFileName(MultipartFile noticeFileName) {
		this.noticeFileName = noticeFileName;
	}
	public String getNoticeUploadedFileName() {
		return noticeUploadedFileName;
	}
	public void setNoticeUploadedFileName(String noticeUploadedFileName) {
		this.noticeUploadedFileName = noticeUploadedFileName;
	}
}
