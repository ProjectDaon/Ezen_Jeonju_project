package com.ezen_jeonju.myapp.service;

import java.util.ArrayList;

import com.ezen_jeonju.myapp.domain.NotificationDTO;

public interface NotificationService {
	public int notifCheck(int midx);
	public ArrayList<NotificationDTO> notifList(int midx);
}
