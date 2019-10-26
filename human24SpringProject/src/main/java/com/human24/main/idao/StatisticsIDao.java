package com.human24.main.idao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.human24.main.dto.StatisticsDto;

public interface StatisticsIDao {
	
	// 회원 통계
	
		// 회원 남자 몇 명?
	public int maCnt();
	
		// 회원 여자 몇 명?
	public int feCnt();
	
		// 회원 연령대
	public ArrayList<StatisticsDto> ageArr(@Param("flag") int flag);
	
	
	// 판매 통계
	
		// 대장르 통계
	public ArrayList<StatisticsDto> mainGenreStat(@Param("flag") int flag);
	
		// 소장르 통계
	public ArrayList<StatisticsDto> subGenreStat(@Param("flag") int flag);
	
	
	// 로그인 통계
	
		// 오전/오후
	public int amList(String fromDate, String toDate);
	public int pmList(String fromDate, String toDate);
	
		// 연도
	public ArrayList<StatisticsDto> yearList(String fromDate, String toDate);
		
		// 월
	public ArrayList<StatisticsDto> monthList(String fromDate, String toDate);
	
		// 일
	public ArrayList<StatisticsDto> dateList(String statYear, String statMon);
	
		// 시간
	public ArrayList<StatisticsDto> dayList(String fromDate, String toDate);
	
		// 요일
	public ArrayList<StatisticsDto> timeList(String fromDate, String toDate);
}



