package com.human24.main.dto;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;

public class bookDto 
{

	Calendar calendar = new GregorianCalendar(Locale.KOREA);
	int dayNum = calendar.get(Calendar.DAY_OF_WEEK);
	
	private String booknum;
	private String genre;
	private String booktitle;
	private String writer;
	private String publisher;
	private String p_date;
	private String price;
	private String dis_per;
	private String grade;
	private String sales_cnt;
	private String com_cnt;
	private String dis_index;
	private String book_intro;
	private String main_genre;
	
	public bookDto() {}
	public bookDto(String booknum, String genre, String booktitle, String writer, String publisher, String p_date,
			String price, String dis_per, String grade, String sales_cnt, String com_cnt, String dis_index,
			String book_intro, String main_genre) {
		this.booknum = booknum;
		this.genre = genre;
		this.booktitle = booktitle;
		this.writer = writer;
		this.publisher = publisher;
		this.p_date = p_date;
		this.price = price;
		this.dis_per = dis_per;
		this.grade = grade;
		this.sales_cnt = sales_cnt;
		this.com_cnt = com_cnt;
		this.dis_index = dis_index;
		this.book_intro = book_intro;
		this.main_genre = main_genre;
	}
	
	
	
	public String getMain_genre() {
		return main_genre;
	}
	public void setMain_genre(String main_genre) {
		this.main_genre = main_genre;
	}
	public String getBooknum() {
		return booknum;
	}
	public void setBooknum(String booknum) {
		this.booknum = booknum;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getBooktitle() {
		return booktitle;
	}
	public void setBooktitle(String booktitle) {
		this.booktitle = booktitle;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
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
		// 주말이 아닌 경우 모든 책 할인율 10%
		if(dayNum != 1 && dayNum != 7) this.dis_per = "0.9";
		else this.dis_per = dis_per;			
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getSales_cnt() {
		return sales_cnt;
	}
	public void setSales_cnt(String sales_cnt) {
		this.sales_cnt = sales_cnt;
	}
	public String getCom_cnt() {
		return com_cnt;
	}
	public void setCom_cnt(String com_cnt) {
		this.com_cnt = com_cnt;
	}
	public String getDis_index() {
		return dis_index;
	}
	public void setDis_index(String dis_index) {
		this.dis_index = dis_index;
	}
	public String getBook_intro() {
		return book_intro;
	}
	public void setBook_intro(String book_intro) {
		this.book_intro = book_intro;
	}
}
