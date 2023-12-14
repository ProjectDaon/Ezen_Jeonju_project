package com.ezen_jeonju.myapp.domain;

import java.sql.Date;

public class ScheduleRootVo {
	private int sidx;
	private int midx;
	private String scheduleSubject;
	private Date scheduleStartDate;
	private Date scheduleEndDate;
	private String scheduleShare;
	private int scheduleViewCount;
	private String scheduleYN;
	private String scheduleWriteday;
	
	public int getSidx() {
		return sidx;
	}
	public void setSidx(int sidx) {
		this.sidx = sidx;
	}
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}

	public String getScheduleSubject() {
		return scheduleSubject;
	}
	public void setScheduleSubject(String scheduleSubject) {
		this.scheduleSubject = scheduleSubject;
	}
	public Date getScheduleStartDate() {
		return scheduleStartDate;
	}
	public void setScheduleStartDate(Date scheduleStartDate) {
		this.scheduleStartDate = scheduleStartDate;
	}
	public Date getScheduleEndDate() {
		return scheduleEndDate;
	}
	public void setScheduleEndDate(Date scheduleEndDate) {
		this.scheduleEndDate = scheduleEndDate;
	}
	public String getScheduleShare() {
		return scheduleShare;
	}
	public void setScheduleShare(String scheduleShare) {
		this.scheduleShare = scheduleShare;
	}
	public int getScheduleViewCount() {
		return scheduleViewCount;
	}
	public void setScheduleViewCount(int scheduleViewCount) {
		this.scheduleViewCount = scheduleViewCount;
	}
	public String getScheduleYN() {
		return scheduleYN;
	}
	public void setScheduleYN(String scheduleYN) {
		this.scheduleYN = scheduleYN;
	}
	public String getScheduleWriteday() {
		return scheduleWriteday;
	}
	public void setScheduleWriteday(String scheduleWriteday) {
		this.scheduleWriteday = scheduleWriteday;
	}
}
