package com.human24.main.dto;

public class AttendanceDto {
	private String user_id;
	private int a_year;
	private int a_month;
	private int a_day;
	
	AttendanceDto(){}
	
	AttendanceDto(String user_id, int a_year, int a_month, int a_day){
		this.user_id = user_id;
		this.a_year = a_year;
		this.a_month = a_month;
		this.a_day = a_day;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getA_year() {
		return a_year;
	}

	public void setA_year(int a_year) {
		this.a_year = a_year;
	}

	public int getA_month() {
		return a_month;
	}

	public void setA_month(int a_month) {
		this.a_month = a_month;
	}

	public int getA_day() {
		return a_day;
	}

	public void setA_day(int a_day) {
		this.a_day = a_day;
	}
	
	
}
