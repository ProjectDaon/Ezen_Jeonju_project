package com.ezen_jeonju.myapp.domain;

public class AttachFileVo extends UploadFileDTO{
	private int aidx;
	private String originalFileName;
	private String storedFilePath;
	private String thumbnailFilePath;
	private String fileUploadDay;
	private String fileYN;
	private String category;
	
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getStoredFilePath() {
		return storedFilePath;
	}
	public void setStoredFilePath(String storedFilePath) {
		this.storedFilePath = storedFilePath;
	}
	public String getThumbnailFilePath() {
		return thumbnailFilePath;
	}
	public void setThumbnailFilePath(String thumbnailFilePath) {
		this.thumbnailFilePath = thumbnailFilePath;
	}
	public String getFileUploadDay() {
		return fileUploadDay;
	}
	public void setFileUploadDay(String fileUploadDay) {
		this.fileUploadDay = fileUploadDay;
	}
	public String getFileYN() {
		return fileYN;
	}
	public void setFileYN(String fileYN) {
		this.fileYN = fileYN;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
}
