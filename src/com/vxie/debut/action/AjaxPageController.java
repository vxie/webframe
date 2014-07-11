package com.vxie.debut.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vxie.debut.business.AjaxPageService;

@Controller
@RequestMapping(value="/ajaxpage")
public class AjaxPageController extends AbstractController {
	@Resource 
	private AjaxPageService ajaxPageService;
	
	@ResponseBody
	@RequestMapping(value="/user")
	public String user(HttpServletRequest request) throws Exception{
		return ajaxPageService.userPage(request);
	}

    @ResponseBody
    @RequestMapping(value="/member")
    public String member(HttpServletRequest request) throws Exception{
        return ajaxPageService.memberPage(request);
    }
	
	@ResponseBody
	@RequestMapping(value="/role")
	public String role(HttpServletRequest request) throws Exception{
		return ajaxPageService.rolePage(request);
	}
	
	@ResponseBody
	@RequestMapping(value="/step")
	public String step(HttpServletRequest request, HttpSession session) throws Exception{
		return ajaxPageService.stepPage(request);
	}
}
