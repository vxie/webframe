package com.sunrise.cutshow.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class AbstractController {
	protected static final Logger log = LoggerFactory.getLogger(AbstractController.class);
	
	protected static Long getReqLong(HttpServletRequest request, String attrName){
		Object o = request.getParameter(attrName);
		return o==null?null:Long.parseLong(o.toString());
	}
	
	protected static String getReqString(HttpServletRequest request, String attrName){
		Object o = request.getParameter(attrName);
		return o==null?null:o.toString();
	}
	
	protected static Long getSessionLong(HttpSession session, String attrName){
		Object o = session.getAttribute(attrName);
		return o==null?null:Long.parseLong(o.toString());
	}
	
	protected static String getSessionString(HttpSession session, String attrName){
		Object o = session.getAttribute(attrName);
		return o==null?null:o.toString();
	}
}
