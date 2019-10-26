package com.human24.main.idao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.human24.main.dto.GenreDto;
import com.human24.main.dto.MemberDto;
import com.human24.main.dto.bookDto;

public interface adminIDao {
	
	// 관리자 로그인
	public int loginCheck(String userid, String pwd);
	
	// 회원 수 출력
	public int memberCount(String memberIndex);
	
	//검색한 회원 수  출력
	public int schMemberCount(String memberIndex, String sel, String schText);
	
	// 회원 출력
	public ArrayList<MemberDto> memberSelect(String admin_index, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd);
	
	// 회원 검색 출력
	public ArrayList<MemberDto> schMemberSelect(String admin_index, String sel, String schText, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd);
	
	// 블랙리스트 출력
	public ArrayList<MemberDto> memberSelect2();
		
	// 관리자 출력
	public ArrayList<MemberDto> memberSelect3();
	
	// 상세보기 출력
	public MemberDto memberSelect4(String user_id);
	
	// 회원 권한 변경
	public void memberUpdate(int admin_index, String user_id);
	
	
	
	
	
	
	
	// 책 갯수 카운트
	public int bookCount(String field, String value);
	
	// 검색한 책 갯수
	public int genreSelect(String field, String value);
	
	// 책 관리 출력
	public ArrayList<bookDto> genreSelect(String field, String value, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd, @Param("order") String order);
	
	// 책 상세페이지
	public bookDto detailSelect(String booknum);
	
	// 책 장르 전체 가져오기
	public ArrayList<GenreDto> genreAll();
	
	// 책 대장르 리스트 가져오기
	public ArrayList<GenreDto> genreMain();
	
	// 책 소장르 리스트 가져오기
	public ArrayList<GenreDto> genreSub(String field_name, String main_genre_num);
	
	// 책 대장르 이름 가져오기
	public String getMainGenreName(String genre_num);
	
	// 책 소장르 이름 가져오기
	public String getSubGenreName(String genre_num);
	
	// 책 수정
	public void bookModify(String sub_genre_name, String booktitle, String writer, String publisher, String price, double dis_per, String dis_index, String book_intro, String main_genre, String booknum);
	// 책 추가
	public void bookInsert(String sub_genre_name, String booktitle, String writer, String publisher, String price, double dis_per, String dis_index, String book_intro, String main_genre);
	
	// 추가한 책 booknum 가져오기
	public String bookInsertGetBooknum(String sub_genre_name, String booktitle, String writer, String publisher, String price, double dis_per, String dis_index, String book_intro);
	
	// 책 삭제
	public void genreDelete(String booknum);
	
	// 대장르 해당 책 모두 삭제
	public void mgenreBookDelete(String mainGenreName);
	
	// 소장르 해당 책 모두 삭제 
	public void mgenreBookDelete2(String subGenreName);
	
	
	
	// 장르관리 대장르 불러오기
	public ArrayList<GenreDto> mGenreSelect();
	
	// 장르관리 상세페이지
	public GenreDto genreDetail(String main_genre_num); 
	
	// 대장르 수정
	public void bigUpdate(String main_genre_name, String use, String main_genre_num);
	
	// 대장르 수정페이지
	public GenreDto mgenreSelect(String main_genre_num);
	
	// 대장르 삭제
	public void mgenreDelete(String main_genre_num);
	
	// 대장르 추가
	public void mgenreInsert(String main_genre_name, String use);
	
	// 소장르 불러오기
	public ArrayList<GenreDto> subSelect(String main_genre_num);
	
	// 소장르 상세페이지
	public GenreDto subSelect2(String sub_genre_num);
	
	// 소장르 수정
	public void subUpdate(String main_genre_num, String sub_genre_name, String use, String sub_genre_num);
	
	// 소장르 추가
	public void mgenreInsert2(String main_genre_name, String main_genre_num, String sub_genre_name, String use);
	
	// 소장르 삭제
	public void mgenreDelete2(String sub_genre_num);
}
