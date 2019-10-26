package com.human24.main.dto;

public class BoardCommentDto {
	private String board_index;
	private String board_num;
	private String user_id;
	private String comments;
	private String write_date;
	private int comment_num;
	private int dap_yn;

	
	public int getDap_yn() {
		return dap_yn;
	}



	public void setDap_yn(int dap_yn) {
		this.dap_yn = dap_yn;
	}



	public BoardCommentDto() {}
	
	
	
	public BoardCommentDto(String board_index, String board_num, String user_id, String comments, String write_date, int comment_num, int dap_yn) {
		this.board_index = board_index;
		this.board_num = board_num;
		this.user_id = user_id;
		this.comments = comments;
		this.write_date = write_date;
		this.comment_num = comment_num;
		this.dap_yn = dap_yn;
	}

	public int getComment_num() {
		return comment_num;
	}



	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}



	public String getWrite_date() {
		return write_date;
	}



	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}



	public String getUser_id() {
		return user_id;
	}

	

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getBoard_index() {
		return board_index;
	}

	public void setBoard_index(String board_index) {
		this.board_index = board_index;
	}

	public String getBoard_num() {
		return board_num;
	}

	public void setBoard_num(String board_num) {
		this.board_num = board_num;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
}
