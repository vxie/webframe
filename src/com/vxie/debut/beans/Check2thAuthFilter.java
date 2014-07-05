package com.vxie.debut.beans;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Check2thAuthFilter implements Filter {
	private static final String REQ_PARAM_NAME = "needToCheck2thAuthMenuId";
	
	public void doFilter(ServletRequest req, ServletResponse rsp, FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) rsp;
		
		if(request.getParameter(REQ_PARAM_NAME)!=null){

		}
		
		//String currentURL = request.getRequestURI();

		filterChain.doFilter(request, response);
	}
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}
