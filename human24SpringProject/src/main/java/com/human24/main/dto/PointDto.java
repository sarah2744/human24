package com.human24.main.dto;

import java.sql.Date;

public class PointDto {
	private String user_id;
	private int total_point; // 사용 가능한 총 포인트
	private String how_point; // varchar2로 변경(포인트 적립 / 사용 내역)
	private Date point_date; // 사용 / 적립 날짜
	private int use_accu; // 사용 or 적립한 포인트 
	private int beforepoint;
	private int afterpoint;
	private String booknum;
	
	PointDto(){}
	
	

	public PointDto(String user_id, int total_point, String how_point, Date point_date, int use_accu, int beforepoint, int afterpoint, String booknum) {
		this.user_id = user_id;
		this.total_point = total_point;
		this.how_point = how_point;
		this.point_date = point_date;
		this.use_accu = use_accu;
		this.beforepoint = beforepoint;
		this.afterpoint = afterpoint;
		this.booknum = booknum;
	}
	
	
	
	
	public String getBooknum() {
		return booknum;
	}



	public void setBooknum(String booknum) {
		this.booknum = booknum;
	}



	public int getBeforepoint() {
		return beforepoint;
	}



	public void setBeforepoint(int beforepoint) {
		this.beforepoint = beforepoint;
	}



	public int getAfterpoint() {
		return afterpoint;
	}



	public void setAfterpoint(int afterpoint) {
		this.afterpoint = afterpoint;
	}



	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getTotal_point() {
		return total_point;
	}

	public void setTotal_point(int total_point) {
		this.total_point = total_point;
	}

	public String getHow_point() {
		return how_point;
	}

	public void setHow_point(String how_point) {
		this.how_point = how_point;
	}

	public Date getPoint_date() {
		return point_date;
	}

	public void setPoint_date(Date point_date) {
		this.point_date = point_date;
	}

	public int getUse_accu() {
		return use_accu;
	}

	public void setUse_accu(int use_accu) {
		this.use_accu = use_accu;
	}
	
	
}
