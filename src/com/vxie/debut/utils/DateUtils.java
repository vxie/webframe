package com.vxie.debut.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.util.Assert;

/**
 * @author Kuajiang Ying
 * @since: 2009-1-13 10:06:43
 */
public class DateUtils extends org.apache.commons.lang.time.DateUtils {
	// public static SimpleDateFormat TIME19 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final String TIME19 = "yyyy-MM-dd HH:mm:ss";
	// public static SimpleDateFormat DATE8 = new SimpleDateFormat("yyyyMMdd");
	private static final String DATE8 = "yyyyMMdd";
	// public static SimpleDateFormat DATE10 = new SimpleDateFormat("yyyy-MM-dd");
	private static final String DATE10 = "yyyy-MM-dd";
	// public static SimpleDateFormat TIME8 = new SimpleDateFormat("HH:mm:ss");
	private static final String TIME8 = "HH:mm:ss";
	// public static SimpleDateFormat TIME14 = new SimpleDateFormat("yyyyMMddHHmmss");
	private static final String TIME14 = "yyyyMMddHHmmss";

	public static String[] dataStringFormats = { "yyyyMMddHHmmss", "yyyyMMdd", "yyyy-MM-dd",
			"yyyy-MM-dd HH:mm:ss" };

	public static String longToString8(long date) {
		return new SimpleDateFormat(DATE8).format(new Date(date));
	}

	public static String long14ToString19(Long date) {
		if (date == null) {
			return null;
		}
		return new SimpleDateFormat(TIME19).format(stringToDate(date.toString()));
	}

	public static String dateToString19(Date time) {
		if (time == null) {
			return null;
		}
		return new SimpleDateFormat(TIME19).format(time);
	}

	public static String long14ToString8(Long date) {
		if (date == null) {
			return null;
		}
		return new SimpleDateFormat(DATE8).format(stringToDate(date.toString()));
	}

	public static String long14ToTime8(Long date) {
		if (date == null) {
			return null;
		}
		return new SimpleDateFormat(TIME8).format(stringToDate(date.toString()));
	}

	public static Long long14ToLong(Long date) {
		if (date == null) {
			return null;
		}
		return stringToDate(date.toString()).getTime();
	}

	public static String longToString19(long date) {
		return new SimpleDateFormat(TIME19).format(new Date(date));
	}

	public static String todayString8() {
		return longToString8(System.currentTimeMillis());
	}

	public static long todayStart() {
		return stringToDate(todayString8()).getTime();
	}

	public static String yestodayString8() {
		return longToString8(System.currentTimeMillis() - 24 * 3600 * 1000);
	}

	public static long longToLong14(long date) {
		return Long.parseLong(dateToString(new Date(date), "yyyyMMddHHmmss"));
	}

	public static String dateToString(Date date, String format) {
		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(date);
	}

	public static long long8ToLong(Long date) {
		return stringToDate(date.toString()).getTime();
	}

	public static String string14toString19(String date) {
		String date19;
		try {
			date19 = long14ToString19(Long.parseLong(date));
		} catch (NumberFormatException e) {
			date19 = date;
		}
		return date19;
	}

	public static String string14toString8(String date) {
		String date8;
		try {
			date8 = long14ToString8(Long.parseLong(date));
		} catch (NumberFormatException e) {
			date8 = date;
		}
		return date8;
	}

	public static Date stringToDate(String dateString) {
		Assert.notNull(dateString, "param is null in stringToDate()");
		Date date = null;
		try {
			date = parseDate(dateString, dataStringFormats);
		} catch (ParseException e) {
			try {
				throw new Exception("string to Date format failed:" + dateString);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		return date;
	}

	public static String dateToStringDate10(Date date) {
		if (date == null) {
			return null;
		}
		return new SimpleDateFormat(DATE10).format(date);
	}

	public static String string14ToString10(String date14) {
		return dateToStringDate10(stringToDate(date14));
	}

	public static Long stringToLong(String dateString) {
		Date date = stringToDate(dateString);
		return date == null ? null : date.getTime();
	}

	// 当前时间
	public static Long currentTime() {
		try {
			return parseToLong(new Date());
		} catch (Exception e) {
			return null;
		}

	}

	// time格式: 20111026171317
	public static Date parseToDate(Long time) throws Exception {
		return new SimpleDateFormat(TIME14).parse("" + time);
	}

	// 返回格式: 20111026171317
	public static Long parseToLong(Date time) throws Exception {
		return Long.parseLong(new SimpleDateFormat(TIME14).format(time));
	}

	// time格式: 20111026171317
	public static Long betweenSeconds(Long nowTime, Long beforeTime) throws Exception {
		return (new SimpleDateFormat(TIME14).parse("" + nowTime).getTime() - new SimpleDateFormat(
				TIME14).parse("" + beforeTime).getTime()) / 1000;
	}

	/**
	 * <p>
	 * Description: 修改月、日，如前一个月、后一个月、前一天、后一天
	 * <p>
	 * 
	 * @param d
	 *            需要改变的日期
	 * @param monCount
	 *            加/减月数
	 * @param dayCount
	 *            加/减天数
	 * @param retFormat
	 *            返回的日期格式
	 * @return
	 */
	public static String changeDate(Date d, int monCount, int dayCount, String retFormat) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(d);
		calendar.add(Calendar.MONTH, monCount);
		calendar.add(Calendar.DATE, dayCount);
		return dateToString(calendar.getTime(), retFormat);
	}

	public static void main(String[] args) {
		System.out.println(changeDate(new Date(), -1, +2, "yyyyMMdd"));
		System.out.println(dateToString19(new Date()));
	}
}
