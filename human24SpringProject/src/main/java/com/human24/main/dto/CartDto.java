package com.human24.main.dto;

public class CartDto {
	private String booknum;
	private String user_id;
	private int cart_count;
	
	CartDto(){}
	
	CartDto(String booknum, String user_id, int cart_count){
		this.booknum = booknum;
		this.user_id = user_id;
		this.cart_count = cart_count;
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

	public int getCart_count() {
		return cart_count;
	}

	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}
	
	
}
