package com.human24.main.idao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.human24.main.dto.GenreDto;
import com.human24.main.dto.bookDto;

public interface StoreIDao {
	public int totalCount(String genre);
	public ArrayList<bookDto> bookListPage(String genre, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd, @Param("value") String value);
	public ArrayList<bookDto> weekOrBestBook(@Param("value") String value);
	public ArrayList<bookDto> search(String searchText);
	public ArrayList<GenreDto> useMainGenre();
	public ArrayList<GenreDto> genreSub(String mainGenre);
}
