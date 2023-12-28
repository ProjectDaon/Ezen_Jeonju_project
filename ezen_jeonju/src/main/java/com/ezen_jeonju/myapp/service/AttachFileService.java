package com.ezen_jeonju.myapp.service;

import com.ezen_jeonju.myapp.domain.AttachFileVo;

public interface AttachFileService {
	public int imageFileUpload(AttachFileVo af);
	public AttachFileVo imageFileLoad(int aidx);
	public int imageFileModify(AttachFileVo af);
}
