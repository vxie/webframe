package com.sunrise.cutshow.utils;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

import com.sunrise.springext.utils.Encode;

public class Constants {
	
//	public static final String DB_NAME = "oracle";
	public static final String DB_NAME = "mysql";

	//默认密码
	public static final String DEFAULT_USER_PWD = MD5Encoder.encode("123456");
	
	public static final String SESSION_VALIDATE_MSG = Encode.escape("Session已过期或服务器已重启, 请重新登录!");
	
	public static final String XLS_END_FLAG = "<EOF>";//EXCEL 导入行结束标记
	
	public static final Map<String, String> borderWidth = new HashMap<String, String>();
	public static final Map<String, String> borderColor = new HashMap<String, String>();
	public static final Map<String, String> taskTitle = new HashMap<String, String>();
	public static final Map<String, String> textColor = new HashMap<String, String>();
	
	public static final Set<String> unfilterableUrl = new LinkedHashSet<String>();
	
	static {
		borderWidth.put("1", "4");
		borderWidth.put("2", "5");
		borderColor.put("0", "#FFF");
		borderColor.put("1", "blue");
//		borderColor.put("2", "green");
		borderColor.put("2", "#7CFC00");
		borderColor.put("3", "blue");
//		borderColor.put("4", "green");
		borderColor.put("4", "#7CFC00");
		borderColor.put("5", "red");
		taskTitle.put("0", "操作未开始");
		taskTitle.put("1", "正在执行中");
		taskTitle.put("2", "执行已完成");
		taskTitle.put("3", "正在检查中");
		taskTitle.put("4", "检查已完成");
		taskTitle.put("5", "执行异常");
		textColor.put("0", "black");
		textColor.put("1", "#FFFFFF");
		textColor.put("2", "#FFFFFF");
		textColor.put("3", "#FFFFFF");
		textColor.put("4", "#FFFFFF");
		textColor.put("5", "#FFFFFF");
		
		unfilterableUrl.add("/resources");// 请求资源文件
		unfilterableUrl.add("/index");// 请求资源文件
		unfilterableUrl.add("/login");// 请求资源文件
		unfilterableUrl.add("/common/code");// 请求资源文件
		unfilterableUrl.add("/progress/refresh");// 刷新步骤状态
		unfilterableUrl.add("/progress/taskStatus");// 刷新任务状态
		unfilterableUrl.add("/progress/tasks/get/status");// 刷新任务状态
		unfilterableUrl.add("/progress/steps/start");// 刷新任务状态
	}
}
