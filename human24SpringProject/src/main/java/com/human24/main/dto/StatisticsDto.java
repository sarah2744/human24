package com.human24.main.dto;

public class StatisticsDto {
	
	private String statProperty;
	private int statValue;
	
	public StatisticsDto() {}
	
	public StatisticsDto(String statProperty, int statValue) {	
		this.statProperty = statProperty;
		this.statValue = statValue;
	}

	public String getStatProperty() {
		return statProperty;
	}

	public void setStatProperty(String statProperty) {
		this.statProperty = statProperty;
	}

	public int getStatValue() {
		return statValue;
	}

	public void setStatValue(int statValue) {
		this.statValue = statValue;
	}
	
}
