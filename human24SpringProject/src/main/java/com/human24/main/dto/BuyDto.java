package com.human24.main.dto;

public class BuyDto {
	private String booknum;
    private String booktitle;
    private String price;
    private String dis_per;
   
    
    private String buy_count = "0";
    
    public BuyDto(){}

	public BuyDto(String booknum, String booktitle, String price, String dis_per, String buy_count) {
		this.booknum = booknum;
		this.booktitle = booktitle;
		this.price = price;
		this.dis_per = dis_per;
		this.buy_count = buy_count;
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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getDis_per() {
		return dis_per;
	}

	public void setDis_per(String dis_per) {
		this.dis_per = dis_per;
	}

	public String getBuy_count() {
		return buy_count;
	}

	public void setBuy_count(String buy_count) {
		this.buy_count = buy_count;
	}
    
    
    
    
}
