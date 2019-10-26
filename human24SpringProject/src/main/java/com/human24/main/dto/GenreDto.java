package com.human24.main.dto;

public class GenreDto {
	private String main_genre_num;
	private String main_genre_name;
	private String sub_genre_num;
	private String sub_genre_name;
	private String use;
	
	public GenreDto(){}

	
	public GenreDto(String main_genre_num, String main_genre_name, String sub_genre_num, String sub_genre_name, String use) {
		this.main_genre_num = main_genre_num;
		this.main_genre_name = main_genre_name;
		this.sub_genre_num = sub_genre_num;
		this.sub_genre_name = sub_genre_name;
		this.use = use;
	}


	public String getMain_genre_num() {
		return main_genre_num;
	}

	public void setMain_genre_num(String main_genre_num) {
		this.main_genre_num = main_genre_num;
	}

	public String getMain_genre_name() {
		return main_genre_name;
	}

	public void setMain_genre_name(String main_genre_name) {
		this.main_genre_name = main_genre_name;
	}

	public String getSub_genre_num() {
		return sub_genre_num;
	}

	public void setSub_genre_num(String sub_genre_num) {
		this.sub_genre_num = sub_genre_num;
	}

	public String getSub_genre_name() {
		return sub_genre_name;
	}

	public void setSub_genre_name(String sub_genre_name) {
		this.sub_genre_name = sub_genre_name;
	}

	public String getUse() {
		return use;
	}

	public void setUse(String use) {
		this.use = use;
	}
	
}
