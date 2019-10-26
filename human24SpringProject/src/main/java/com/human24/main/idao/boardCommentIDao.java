package com.human24.main.idao;

import java.util.ArrayList;

import com.human24.main.dto.BoardCommentDto;

public interface boardCommentIDao {
	public ArrayList<BoardCommentDto> boardCommentList(String boardIndex, String boardNum);
	
	public void boardCommentWrite(int boardIndex, String boardNum, String comments,  String userName); 
	
	public void boardCommentReWrite(int boardIndex, String boardNum, String comments, String userName);
	
	public void boardCommentErase(int commentNum);
	
	public void boardCommentAllErase(String boardIndex, String boardNum);
	
	public void boardCommentNumUpdate(int commentNum);
}
