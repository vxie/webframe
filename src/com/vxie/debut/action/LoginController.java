package com.vxie.debut.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vxie.debut.business.LoginService;
import com.vxie.debut.model.AdminUser;

@Controller
@RequestMapping(value="/")
public class LoginController extends AbstractController {

	@Resource
	private LoginService loginService;
	
	@RequestMapping
	public String welcome(){
		return "login";
	}
	
	@RequestMapping(value="login/{name}/{pwd}")
	public String welcome(ModelMap map, @PathVariable String name, @PathVariable String pwd){
		map.put("loginname", name);
		map.put("loginpwd", pwd);
		return "login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(HttpServletRequest request, HttpSession session, AdminUser adminUser) {
		
		Object res = loginService.checkUser(adminUser.getNumber(), adminUser.getPassword());
		if(res.getClass().equals(AdminUser.class)) {
			adminUser = (AdminUser)res;
			adminUser.setPassword(null);

			session.setAttribute("adminUser", adminUser);
			session.setAttribute("isSA", adminUser.getRole() == 0);
			
			String clientIP = request.getRemoteAddr();
			log.info("user - {} accessed! IP - {}", adminUser.getNumber(), clientIP);
			
			return "home";
		}else{
			request.setAttribute("adminUser", adminUser);
			request.setAttribute("errorInfo", res.toString());
			return "login";
		}
	}
	
	@RequestMapping(value="left")
	public String left(HttpSession session, ModelMap map){
		return "left";
	}
	
	@RequestMapping(value="logout")
	@ResponseBody
	public String logout(HttpSession session){
		session.removeAttribute("adminUser");
		session.removeAttribute("isSA");
		return "0";
	}

}
