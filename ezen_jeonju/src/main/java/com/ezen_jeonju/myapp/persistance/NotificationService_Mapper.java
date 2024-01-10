package com.ezen_jeonju.myapp.persistance;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.NotificationDTO;

public interface NotificationService_Mapper {
	public int notifCheck(int midx);
	public ArrayList<NotificationDTO> notifList(int midx);
	public int openNotification(int midx);
}
