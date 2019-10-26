package com.human24.main.dto;

public class MemberDto {
	private String user_id;
	private String user_name;
	private String user_pwd;
	private String mail;
	private String adr;
	private String gender;
	private String mobile;
	private int user_point;
	private int admin_index;
	private String birth;
	private int pur_count; 
	
	MemberDto(){}
	
	MemberDto(String user_id, String user_name, String user_pwd, String mail, String adr, String gender, String mobile, int user_point, int admin_index, String birth, int pur_count){
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_pwd = user_pwd;
		this.mail = mail;
		this.adr = adr;
		this.gender = gender;
		this.mobile = mobile;
		this.user_point = user_point;
		this.admin_index = admin_index;
		this.birth = birth;
		this.pur_count = pur_count;
	}

	
	public int getPur_count() {
		return pur_count;
	}

	public void setPur_count(int pur_count) {
		this.pur_count = pur_count;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getAdr() {
		return adr;
	}

	public void setAdr(String adr) {
		this.adr = adr;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getUser_point() {
		return user_point;
	}

	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}

	public int getAdmin_index() {
		return admin_index;
	}

	public void setAdmin_index(int admin_index) {
		this.admin_index = admin_index;
	}
	
	
}
