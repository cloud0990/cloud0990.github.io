package com.cloud.web.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil{

	/**
	 * getDateDay
	 * @param String date, String dateType
	 * @return String
	 */
	public static String getDateDay(String date, String dateType) throws ParseException {
		
		SimpleDateFormat df = new SimpleDateFormat(dateType); //dateType : yyyy-MM-dd
		Date dfDate = df.parse(date);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(dfDate);
		
		/* Calendar.DAY_OF_WEEK : 한 주의 해당하는 중 요일 return int */
		String day = "";	
		int dayNum = cal.get(Calendar.DAY_OF_WEEK);

		if(dayNum==1) {
			day = "일";
		}else if(dayNum==2) {
			day = "월";
		}else if(dayNum==3) {
			day = "화";
		}else if(dayNum==4) {
			day = "수";
		}else if(dayNum==5) {
			day = "목";
		}else if(dayNum==6) {
			day = "금";
		}else if(dayNum==7){
			day = "토";
		}
		
		return day;
	}
	
}	