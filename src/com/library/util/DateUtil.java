package com.library.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期工具类
 * 
 * @author yshin1992
 *
 */
public class DateUtil {

	/**
	 * 按照yyyy-MM-dd HH:mm:ss的格式格式化当前日期
	 * 
	 * @return
	 */
	public static String getStringDate() {
		return getStringDate("yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 格式化当前的日期
	 * 
	 * @param pattern
	 * @return
	 */
	public static String getStringDate(String pattern) {
		return getStringDate(new Date(), pattern);
	}

	/**
	 * 格式化指定的日期
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String getStringDate(Date date, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(date);
	}
}
