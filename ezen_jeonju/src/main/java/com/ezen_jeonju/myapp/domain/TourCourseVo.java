package com.ezen_jeonju.myapp.domain;

import java.sql.Date;
import java.text.DecimalFormat;

public class TourCourseVo {
	private int tcidx;
	private int sidx;
	private Date tourCourseDate;
	private String tourCourseTime;
	private String tourCoursePlace;
	private String tourCourseLatitude;
	private String tourCourseLongitude;

	
	
	public int getTcidx() {
		return tcidx;
	}
	public void setTcidx(int tcidx) {
		this.tcidx = tcidx;
	}
	public int getSidx() {
		return sidx;
	}
	public void setSidx(int sidx) {
		this.sidx = sidx;
	}
	public Date getTourCourseDate() {
		return tourCourseDate;
	}
	public void setTourCourseDate(Date tourCourseDate) {
		this.tourCourseDate = tourCourseDate;
	}
	public String getTourCourseTime() {
		return tourCourseTime;
	}
	public void setTourCourseTime(String tourCourseTime) {
		this.tourCourseTime = tourCourseTime;
	}
	public String getTourCoursePlace() {
		return tourCoursePlace;
	}
	public void setTourCoursePlace(String tourCoursePlace) {
		this.tourCoursePlace = tourCoursePlace;
	}
	public String getTourCourseLatitude() {
		return tourCourseLatitude;
	}
	public void setTourCourseLatitude(String tourCourseLatitude) {
		this.tourCourseLatitude = tourCourseLatitude;
	}
	public String String() {
		return tourCourseLongitude;
	}
	public void setTourCourseLongitude(String tourCourseLongitude) {
		this.tourCourseLongitude = tourCourseLongitude;
	}


}
