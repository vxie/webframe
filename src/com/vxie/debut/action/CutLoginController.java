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

import com.vxie.debut.business.CutLoginService;
import com.vxie.debut.model.CutMenu;
import com.vxie.debut.model.CutUser;

@Controller
@RequestMapping(value="/")
public class CutLoginController extends AbstractController {

	@Resource
	private CutLoginService cutLoginService;
	
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
	public String login(HttpServletRequest request, HttpSession session, CutUser cutUser) {
		
		Object res = cutLoginService.checkUser(cutUser.getUserLoginName(), cutUser.getUserPassword());
		if(res.getClass().equals(CutUser.class)) {
			cutUser = (CutUser)res;
			cutUser.setUserPassword(null);
			
//			session.setMaxInactiveInterval(10);//秒钟
			session.removeAttribute("userNotLogin");
			session.setAttribute("cutUserId", cutUser.getUserId());
			session.setAttribute("cutUser", cutUser);
			session.setAttribute("isAdmin", cutLoginService.isAdmin(cutUser.getUserId()));
			
			String clientIP = request.getRemoteAddr();
			log.info("user - {} accessed! IP - {}", cutUser.getUserLoginName(), clientIP);
			
			return "home";
		}else{
			request.setAttribute("cutUser", cutUser);
			request.setAttribute("errorInfo", res.toString());
			return "login";
		}
	}
	
	@RequestMapping(value="left")
	public String left(HttpSession session, ModelMap map){
		Long userId = getSessionLong(session, "cutUserId");
		List<CutMenu> list = cutLoginService.getUserMenus(userId);
		map.put("menus", list);
//		session.setAttribute("isAdmin", cutLoginService.isAdmin(userId, list.size()));
		return "left";
	}
	
	@RequestMapping(value="logout")
	@ResponseBody
	public String logout(HttpSession session){
		session.removeAttribute("cutUserId");
		session.removeAttribute("cutUser");
		session.removeAttribute("isAdmin");
		session.setAttribute("userNotLogin", 1);
		return "0";
	}
	
	@RequestMapping(value="init")
	@ResponseBody
	public String initSys(HttpSession session){
		if(getSessionLong(session, "isAdmin").intValue()==1)
			return cutLoginService.initSys();
		return "1";
	}
	
	@RequestMapping(value="zero")
	@ResponseBody
	public String zero(HttpSession session){
		if(getSessionLong(session, "isAdmin").intValue()==1)
			return cutLoginService.clearZero();
		return "1";
	}
}
