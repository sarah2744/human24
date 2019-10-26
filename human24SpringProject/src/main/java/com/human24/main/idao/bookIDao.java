package com.human24.main.idao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.human24.main.dto.BoardDto;
import com.human24.main.dto.CartJDto;
import com.human24.main.dto.CommentDto;
import com.human24.main.dto.MemberDto;
import com.human24.main.dto.PointDto;
import com.human24.main.dto.bookDto;
import com.human24.main.dto.orderJDto;

public interface bookIDao {
	// 책 상세페이지
	public bookDto booklist(String booknum);
  
  	// 책 상세페이지 댓글
  	public ArrayList<CommentDto> commentShow(String booknum);
  
  	// 책 상제페이지 댓글 작성
  	public void write(String userid, String booknum, String contents, int grade);
  
  	// comnum 받아오기
  	public int comNumGet(String userid, String booknum);
  	
  	// 책 테이블 댓글 수, 점수 업데이트
  	public void commentUpdate(int gradeNum, String booknum);
  
  	// 댓글 삭제
  	public void comDel(String comnum);
  
  	// 댓글 삭제했을 때 booklist update
  	public void comDelBooklistUpdate(String comnum);
  
  	// 이미 댓글을 달았는지 확인
  	public int comCnt(String booknum, String userid);
  	
  /************************************************************************************/
  	  	
  	// 장바구니에 이미 담겨있는 책인지 check
  	public int checkCartBooknum(String booknum, String userid);
  	
  	// 상세페이지 -> 장바구니 (insert)
  	public void cartin(String cart_booknum, String userid, int cart_count);
  	
  	// 상세페이지 -> 장바구니 (update)
  	public void cartup(int cart_count, String userid, String cart_booknum); 
  	
  	// 장바구니 디비 출력
  	public ArrayList<CartJDto> cartTable(String userid);	
  	
  	// 장바구니 삭제
  	public void deleteCart(String d_cartnum, String userid);
	
	// 장바구니 수량 변경
	public void cartupdate(String count, String cart_num, String userid);
	
	// 구매
	public bookDto buy(String booknum);	
	
	// 구매자 정보 불러오기
	public MemberDto getUserInfo(String userId);

	// 구매했을 때 booklist sales_cnt 수량만큼 update
	public void buyBooklistUpdate(int sales_cnt, String booknum);
	
	// 구매했을 때 유저 총 포인트 업데이트
	public void totalPointUpdate(int point, String userid);
	
	// 구매했을 때 유저 pur_count 한번만 1 증가시키기
	public void purCountUpdate(String userid);
	
	// 구매했을 때 구매테이블에 구매정보 insert
	public void insertPurInfo(String booknum, String userid, int buy_count, int usePoint, int bookSize);
	
	// 구매했을 때 point pointlist에 insert
	public void insertPointList(String userid, int howPoint, int point);
	
	// 댓글 작성 했을 때 point pointlist에 insert
	public void WriteCommentInsertPointList(String userid, int howPoint, int point, String booknum);
	
	// 이미 작성한 댓글인지 확인
	public int comCount(String userid, String booknum);
	
	// 구매한 책에 대해서 포인트 주기 (구매 기록 확인)
	public int buyRecord(String userid, String booknum);
	
	// 포인트를 받았던 책인지 확인
	public int receivePoint(String userid, String booknum);

	// 구매한 책 장바구니에서 삭제
	public void buyDeleteCart(String userid, String booknum);
		
	// pointlist 출력
	public ArrayList<PointDto> pointList(String userid);
	
	// totalpoint 가져오기
	public int totalPoint(String userid);
	
	// 구매 기록 가져오기
	public ArrayList<orderJDto> buyRecordSelect(String userid);
	
	
	
	// 게시판 불러오기
	public ArrayList<BoardDto> NoticeCall(String boardIndex, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd);
	  
	// 게시판 플래그 불러오기
	public ArrayList<BoardDto> NoticeFlagCall(String boardIndex, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd);

	// 게시판 작성
	public void NoticeInsert(String userid, String title, String contents, String board_index, String truename);
	
	// 게시판 config 작성
	public void NoticeConfigInsert(HashMap<String, Object> HashMap);
	
	// 게시판 수정
	public void NoticeUpdate(String title, String contents, String board_num);
	
	// 게시판 config 수정
	public void NoticeConfigUpdate(HashMap<String, Object> HashMap);
	
	// 게시판 삭제
	public void NoticeDelete(String boardnum);
	 
	// 게시판 플래그 삭제
	public void NoticeFlagDelete(String boardnum);
	
	// 게시판 상세 페이지
	public BoardDto NoticeDetail(String boardnum);
	   
	// 해당 게시판 갯수 가져오기   
	public int NoticeCount(String board_index);
	
	// 해당 게시판 플래그 갯수 가져오기   
	public int NoticeFlagCount(String board_index);
	
	// 조회수 증가 
	public void viewsUpdate(String boardnum);
	
	// 관리자인지 확인
	public int adminYN(String userid);
	
	// 답글 달기
	public void dapInsert(int board_num, String user_id, String title, String contents);
	
	// 답글 달았을 때 시퀀스 미루기 
	public void boardNumUpdate(int boardnum);
	
	
}
