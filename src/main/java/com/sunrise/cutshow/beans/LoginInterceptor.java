package com.sunrise.cutshow.beans;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sunrise.cutshow.utils.Constants;
import com.sunrise.springext.utils.Encode;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	private static final String sessionValidMsg = Encode.escape("Session已过期或服务器已重启, 请重新登录!");
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
        
	    if(request.getRequestedSessionId()==null){//first login
	    	session.setAttribute("userNotLogin", 1);
	    	return super.preHandle(request, response, handler);
        }
	    
        if(session.getAttribute("userNotLogin")==null && session.getAttribute("cutUserId")==null){
			session.setAttribute("userNotLogin", 1);
			String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + request.getContextPath() + "/login";
			//response.setContentType("text/html; charset=UTF-8");
			response.getOutputStream().print("<script>alert(unescape('"+sessionValidMsg+"'));window.top.location.href='"+url+"'</script>");
			return false;
        }
        
        String url = request.getRequestURI();
        for(String unfilterableUrl : Constants.unfilterableUrl){
			if(url.startsWith(unfilterableUrl) || url.equals("/")){
				return super.preHandle(request, response, handler);
			}
		}
        
        String queryString = request.getQueryString();
		queryString = queryString == null ? "" : "?" + queryString;
		logger.info("userId : " + session.getAttribute("cutUserId") + "[" + request.getRemoteAddr() + "] |URL:" + url + queryString);
		
		return super.preHandle(request, response, handler);
	}
	
}
