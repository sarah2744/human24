package com.human24.main.dto;

public class AdminBoardConfigDto {
	private String board_name;  //게시판명
	private int board_index;		//게시판번호
	private String presence;  //사용여부
	private int paging;  //리스트 갯수
	private String delete_compl;  //게시글 삭제 여부
	private String write_auth;  //글쓰기 권한
	private String writer_compl;  //작성자 사용 여부
	private String mobile_compl;  //연락처 사용 여부
	private String email_receive;  //이메일 수신 여부
	private String email_compl;  //이메일 사용 여부
	private String date_compl;  //날짜 사용 여부
	private String reply_compl;  //답글쓰기 사용 여부
	private String comment_compl;  //댓글 사용 여부
	private String comment_auth;  //댓글 사용 여부
	private String security_compl;  //비밀글 사용 여부
	private String update_date;  //업데이트 갱신 날짜;
	
	public AdminBoardConfigDto() {
		// TODO Auto-generated constructor stub
	}
	
	public String getBoard_name() {
		return board_name;
	}

	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public int getBoard_index() {
		return board_index;
	}

	public void setBoard_index(int board_index) {
		this.board_index = board_index;
	}

	public String getPresence() {
		return presence;
	}

	public void setPresence(String presence) {
		this.presence = presence;
	}

	public int getPaging() {
		return paging;
	}

	public void setPaging(int paging) {
		this.paging = paging;
	}

	public String getDelete_compl() {
		return delete_compl;
	}

	public void setDelete_compl(String delete_compl) {
		this.delete_compl = delete_compl;
	}

	public String getWrite_auth() {
		return write_auth;
	}

	public void setWrite_auth(String write_auth) {
		this.write_auth = write_auth;
	}

	public String getWriter_compl() {
		return writer_compl;
	}

	public void setWriter_compl(String writer_compl) {
		this.writer_compl = writer_compl;
	}

	public String getMobile_compl() {
		return mobile_compl;
	}

	public void setMobile_compl(String mobile_compl) {
		this.mobile_compl = mobile_compl;
	}

	public String getEmail_receive() {
		return email_receive;
	}

	public void setEmail_receive(String mobile_receive) {
		this.email_receive = mobile_receive;
	}

	public String getEmail_compl() {
		return email_compl;
	}

	public void setEmail_compl(String email_compl) {
		this.email_compl = email_compl;
	}

	public String getDate_compl() {
		return date_compl;
	}

	public void setDate_compl(String date_compl) {
		this.date_compl = date_compl;
	}

	public String getReply_compl() {
		return reply_compl;
	}

	public void setReply_compl(String reply_compl) {
		this.reply_compl = reply_compl;
	}

	public String getComment_compl() {
		return comment_compl;
	}

	public void setComment_compl(String comment_compl) {
		this.comment_compl = comment_compl;
	}

	public String getComment_auth() {
		return comment_auth;
	}

	public void setComment_auth(String comment_auth) {
		this.comment_auth = comment_auth;
	}

	public String getSecurity_compl() {
		return security_compl;
	}

	public void setSecurity_compl(String security_compl) {
		this.security_compl = security_compl;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	
}
