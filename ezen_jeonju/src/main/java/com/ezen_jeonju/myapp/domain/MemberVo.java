package com.ezen_jeonju.myapp.domain;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

public class MemberVo {
	private int midx;
	
	@Pattern(regexp = "^[a-zA-Z0-9]{4,12}$")
	private String memberId;
	
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
	private String memberPwd;
	
	private String memberName;
	
	@Email
	private String memberEmail;
	
	private String memberGrade;
	private String memberSigninDate;
	private String signInRoot;
	
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPwd() {
		return memberPwd;
	}
	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberGrade() {
		return memberGrade;
	}
	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}
	public String getMemberSigninDate() {
		return memberSigninDate;
	}
	public void setMemberSigninDate(String memberSigninDate) {
		this.memberSigninDate = memberSigninDate;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getSignInRoot() {
		return signInRoot;
	}
	public void setSignInRoot(String signInRoot) {
		this.signInRoot = signInRoot;
	}
}
