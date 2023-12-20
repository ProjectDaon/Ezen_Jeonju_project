package com.ezen_jeonju.myapp.domain;

import org.springframework.web.multipart.MultipartFile;

public class UploadFileDTO {
	private MultipartFile uploadFileName;
	
	public MultipartFile getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(MultipartFile uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
}
