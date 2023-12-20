package com.ezen_jeonju.myapp.domain;

public class ScheduleRootVo extends TourCourseVo{
	private int sidx;
	private int midx;
	private String scheduleSubject;
	private String scheduleStartDate;
	private String scheduleEndDate;
	private String scheduleShareYN;
	private int scheduleViewCount;
	private String scheduleDelYN;
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
	public String getScheduleStartDate() {
		return scheduleStartDate;
	}
	public void setScheduleStartDate(String scheduleStartDate) {
		this.scheduleStartDate = scheduleStartDate;
	}
	public String getScheduleEndDate() {
		return scheduleEndDate;
	}
	public void setScheduleEndDate(String scheduleEndDate) {
		this.scheduleEndDate = scheduleEndDate;
	}

	public int getScheduleViewCount() {
		return scheduleViewCount;
	}
	public void setScheduleViewCount(int scheduleViewCount) {
		this.scheduleViewCount = scheduleViewCount;
	}
	public String getScheduleShareYN() {
		return scheduleShareYN;
	}
	public void setScheduleShareYN(String scheduleShareYN) {
		this.scheduleShareYN = scheduleShareYN;
	}
	public String getscheduleDelYN() {
		return scheduleDelYN;
	}
	public void setscheduleDelYN(String scheduleDelYN) {
		this.scheduleDelYN = scheduleDelYN;
	}
	public String getScheduleWriteday() {
		return scheduleWriteday;
	}
	public void setScheduleWriteday(String scheduleWriteday) {
		this.scheduleWriteday = scheduleWriteday;
	}
}
