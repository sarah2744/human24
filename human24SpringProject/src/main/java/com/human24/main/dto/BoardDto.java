package com.human24.main.dto;

import java.sql.Date;
import java.util.ArrayList;

import com.human24.main.idao.StoreIDao;

public class BoardDto {
	private String board_num;
	private String user_id;
	private Date board_date;
	private String title;
	private String contents;
	private int board_index;
	private int views;
	private int dap_yn;
	private int flag;
	private String mobile;
	private int sec_compl;
	private String email;
	private String truename; 
	
	BoardDto(){}
	
	BoardDto(String board_num, String user_id, Date board_date, String title, String contents, int board_index, int views, int dap_yn, int flag, String mobile, String email, int sec_compl, String truename){
		this.board_num = board_num;
		this.user_id = user_id;
		this.board_date = board_date;
		this.title = title;
		this.contents = contents;
		this.board_index = board_index;
		this.views = views;
		this.dap_yn = dap_yn;
		this.flag = flag;
		this.mobile = mobile;
		this.email = email;
		this.truename = truename;
		this.sec_compl = sec_compl;
	}
	
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getsec_compl() {
		return sec_compl;
	}

	public void setsec_compl(int sec_compl) {
		this.sec_compl = sec_compl;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String gettruename() {
		return truename;
	}

	public void settruename(String truename) {
		this.truename = truename;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public int getDap_yn() {
		return dap_yn;
	}

	public void setDap_yn(int dap_yn) {
		this.dap_yn = dap_yn;
	}

	public int getDap() {
		return dap_yn;
	}

	public void setDap(int dap) {
		this.dap_yn = dap;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getBoard_num() {
		return board_num;
	}

	public void setBoard_num(String board_num) {
		this.board_num = board_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getBoard_date() {
		return board_date;
	}

	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getBoard_index() {
		return board_index;
	}

	public void setBoard_index(int board_index) {
		this.board_index = board_index;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
	
	
