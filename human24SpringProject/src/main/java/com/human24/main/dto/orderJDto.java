package com.human24.main.dto;

import java.sql.Date;

public class orderJDto {
	private String booknum;
	private String booktitle;
	private int buy_count;
	private Date buy_date;
	private int price;
	private String dis_per;
	private int book_size;
	private int pur_index;
	private int usepoint;
	private int dis_index;
	
	public orderJDto() {}
	
	public orderJDto(String booknum, String booktitle, int buy_count, Date buy_date, int price, String dis_per,int book_size, int pur_index, int usepoint, int dis_index) {
		this.booknum = booknum;
		this.booktitle = booktitle;
		this.buy_count = buy_count;
		this.buy_date = buy_date;
		this.price = price;
		this.dis_per = dis_per;
		this.book_size = book_size;
		this.pur_index = pur_index;
		this.usepoint = usepoint;
		this.dis_index = dis_index;
	}
	
	public int getDis_index() {
		return dis_index;
	}

	public void setDis_index(int dis_index) {
		this.dis_index = dis_index;
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

	public int getBook_size() {
		return book_size;
	}

	public void setBook_size(int book_size) {
		this.book_size = book_size;
	}
	
	public String getBooknum() {
		return booknum;
	}


	public void setBooknum(String booknum) {
		this.booknum = booknum;
	}


	public String getBooktitle() {
		return booktitle;
	}


	public void setBooktitle(String booktitle) {
		this.booktitle = booktitle;
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


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public String getDis_per() {
		return dis_per;
	}


	public void setDis_per(String dis_per) {
		this.dis_per = dis_per;
	}
	
	
	
}
