package com.ezen_jeonju.myapp.domain;

public class GoogleInfResponse {
    private String sub; //db에서 id
    private String email;
    private String name;
    private String kid; //db에서 pw
	public String getSub() {
		return sub;
	}
	public void setSub(String sub) {
		this.sub = sub;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKid() {
		return kid;
	}
	public void setKid(String kid) {
		this.kid = kid;
	}

	
}
