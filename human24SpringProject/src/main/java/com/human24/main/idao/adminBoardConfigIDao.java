package com.human24.main.idao;

import java.util.ArrayList;

import com.human24.main.dto.AdminBoardConfigDto;

public interface adminBoardConfigIDao {
	
	//전체 게시판 종류 보여주기
	public ArrayList<AdminBoardConfigDto> boardAllList();
	
	//게시판 상세 
	public ArrayList<AdminBoardConfigDto> boardConfigList(int boardIndex);
	
	//보드 설정 업데이트
	public void boardConfigUpdate(String bdName, 
			String presence, 
			int paging, 
			String deleteCompl, 
			String writeAuth, 
			String writeCompl, 
			String mobileCompl, 
			String emailCompl, 
			String emailReceive,
			String dateCompl, 
			String replyCompl, 
			String commentCompl, 
			String commentAuth, 
			String securityCompl,
			int bdNum
			);
	
	//보드 타이틀 보여주기
	public AdminBoardConfigDto boardTitleView(int boardIndex);
	
	//보드 페이징 입력
	public int boardPaging(int board_index);
	
	//DB 삭제FLAG or 영구삭제 
	public String boardDeleteLogic(int board_index);
	
	public String boardWriteAuth(int board_index);
}
