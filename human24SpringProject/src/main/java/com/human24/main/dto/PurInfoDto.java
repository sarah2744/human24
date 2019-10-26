package com.human24.main.dto;

import java.sql.Date;

public class PurInfoDto {
	private String booknum;
	private String user_id;
	private int buy_count;
	private Date buy_date;
	private int pur_index; // 몇번 째 구매인지
	private int usepoint;
	
	
	PurInfoDto(){}
	
	PurInfoDto(String booknum, String user_id, int buy_count, Date buy_date, int pur_index, int usepoint){
		this.booknum = booknum;
		this.user_id = user_id;
		this.buy_count = buy_count;
		this.buy_date = buy_date;
		this.pur_index = pur_index;
		this.usepoint = usepoint;
	}


	public int getPur_index() {
		return pur_index;
	}

	public void setPur_index(int pur_index) {
		this.pur_index = pur_index;
	}

	public int getUsepoint() {
		return usepoint;
	}

	public void setUsepoint(int usepoint) {
		this.usepoint = usepoint;
	}

	public String getBooknum() {
		return booknum;
	}

	public void setBooknum(String booknum) {
		this.booknum = booknum;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getBuy_count() {
		return buy_count;
	}

	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}

	public Date getBuy_date() {
		return buy_date;
	}

	public void setBuy_date(Date buy_date) {
		this.buy_date = buy_date;
	}
	
	
}
