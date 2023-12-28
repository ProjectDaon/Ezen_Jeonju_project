package com.ezen_jeonju.myapp.persistance;

import com.ezen_jeonju.myapp.domain.AttachFileVo;

public interface AttachFileService_Mapper {
	public int imageFileUpload(AttachFileVo af);
	public AttachFileVo imageFileLoad(int aidx);
	public int imageFileModify(AttachFileVo af);
}
