package com.vxie.debut.beans;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vxie.debut.model.AdminUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.vxie.debut.utils.Constants;
import com.sunrise.springext.utils.Encode;

import java.util.ArrayList;
import java.util.List;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	private static final String sessionValidMsg = Encode.escape("会话已经过期, 请重新登录!");
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
        String contextPath = request.getContextPath();
        List<String> loginURI = new ArrayList<String>();
        loginURI.add(contextPath);
        loginURI.add(contextPath + "/");
        loginURI.add(contextPath + "/login");
        loginURI.add(contextPath + "/login/");
        if(request.getRequestURI().contains("resources/")) {
            return true;
        }
        if (request.getRequestedSessionId() == null || loginURI.contains(request.getRequestURI())) {
            return super.preHandle(request, response, handler);
        }

        if (session.getAttribute("adminUser") == null
                || !session.getAttribute("adminUser").getClass().equals(AdminUser.class)) {
			String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + request.getContextPath() + "/login";
			//response.setContentType("text/html; charset=UTF-8");
			response.getOutputStream().print("<script>alert(unescape('"+sessionValidMsg+"'));window.top.location.href='"+url+"'</script>");
			return false;
        }
//
//        String url = request.getRequestURI();
//        for(String unfilterableUrl : Constants.unfilterableUrl){
//			if(url.startsWith(unfilterableUrl) || url.equals("/")){
//				return super.preHandle(request, response, handler);
//			}
//		}

		return super.preHandle(request, response, handler);
	}
	
}
