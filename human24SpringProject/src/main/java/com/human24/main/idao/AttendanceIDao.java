package com.human24.main.idao;

import java.util.ArrayList;

import com.human24.main.dto.AttendanceDto;

public interface AttendanceIDao {
	public ArrayList<AttendanceDto> attendanceDay(String strID, int year, int month);
	public void doAttendance(String userId, int year, int month, int date);
}
