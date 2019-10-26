package com.human24.main.dto;

public class BookgenreDto {
	private String main_genre_name;
	private String main_genre_num;
	private String booknum;
	private String genre;
	private String booktitle;
	private String price;
	private String sales_cnt;
	private String grade;
	private String com_cnt;
	private String dis_per;
	private String dis_index;
	private String book_intro;
	private String writer;
	private String publisher;
	
	
	public BookgenreDto(){}
	
	public BookgenreDto(String main_genre_name, String booknum, String genre, String booktitle, String price,
			String sales_cnt, String grade, String com_cnt, String dis_per, String dis_index, String book_intro, String writer, String publisher, String main_genre_num){
		this.main_genre_name = main_genre_name;
		this.main_genre_num = main_genre_num;
		this.booknum = booknum;
		this.genre = genre;
		this.booktitle = booktitle;
		this.price = price;
		this.sales_cnt = sales_cnt;
		this.grade = grade;
		this.com_cnt = com_cnt;
		this.dis_per = dis_per;
		this.dis_index = dis_index;
		this.book_intro = book_intro;
		this.writer = writer;
		this.publisher = publisher;
	}
	
	public String getMain_genre_num() {
		return main_genre_num;
	}

	public void setMain_genre_num(String main_genre_num) {
		this.main_genre_num = main_genre_num;
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

	public String getMain_genre_name() {
		return main_genre_name;
	}

	public void setMain_genre_name(String main_genre_name) {
		this.main_genre_name = main_genre_name;
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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getSales_cnt() {
		return sales_cnt;
	}

	public void setSales_cnt(String sales_cnt) {
		this.sales_cnt = sales_cnt;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getCom_cnt() {
		return com_cnt;
	}

	public void setCom_cnt(String com_cnt) {
		this.com_cnt = com_cnt;
	}

	public String getDis_per() {
		return dis_per;
	}

	public void setDis_per(String dis_per) {
		this.dis_per = dis_per;
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
