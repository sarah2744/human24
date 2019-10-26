package com.human24.main.dto;

import java.sql.Date;

public class CommentDto {
	private String com_num;
	private String user_id;
	private String booknum;
	private Date com_date;
	private String contents;
	private int grade;
	
	CommentDto(){}
	
	CommentDto(String com_num, String user_id, String booknum, Date com_date, String contents, int grade){
		this.com_num = com_num;
		this.user_id = user_id;
		this.booknum = booknum;
		this.com_date = com_date;
		this.contents = contents;
		this.grade = grade;
	}

	public String getCom_num() {
		return com_num;
	}

	public void setCom_num(String com_num) {
		this.com_num = com_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getBooknum() {
		return booknum;
	}

	public void setBooknum(String booknum) {
		this.booknum = booknum;
	}

	public Date getCom_date() {
		return com_date;
	}

	public void setCom_date(Date com_date) {
		this.com_date = com_date;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	
	
}
