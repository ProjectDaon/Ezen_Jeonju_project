package com.ezen_jeonju.myapp.domain;

public class AttachFileVo extends UploadFileDTO{
	private int aidx;
	private String originFileName;
	private String storedFileName;
	private String filePath;
	private long fileSize;
	private String fileUploadDay;
	private String fileYN;
	
	
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	public String getStoredFileName() {
		return storedFileName;
	}
	public void setStoredFileName(String storedFileName) {
		this.storedFileName = storedFileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
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
}
