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
    @RequestMapping(value = "/group")
    public String group(HttpServletRequest request) throws Exception {
        return ajaxPageService.groupPage(request);
    }

    @ResponseBody
    @RequestMapping(value = "/area")
    public String area(HttpServletRequest request) throws Exception {
        return ajaxPageService.areaPage(request);
    }


    @ResponseBody
    @RequestMapping(value = "/branch")
    public String branch(HttpServletRequest request) throws Exception {
        return ajaxPageService.branchPage(request);
    }

    @ResponseBody
    @RequestMapping(value = "/space")
    public String space(HttpServletRequest request) throws Exception {
        return ajaxPageService.spacePage(request);
    }

    @ResponseBody
    @RequestMapping(value = "/pushinfo")
    public String pushinfo(HttpServletRequest request) throws Exception {
        return ajaxPageService.spacePage(request);
    }

    @ResponseBody
    @RequestMapping(value = "/layout")
    public String layout(HttpServletRequest request) throws Exception {
        return ajaxPageService.layoutPage(request);
    }


    @ResponseBody
    @RequestMapping(value = "/plan")
    public String plan(HttpServletRequest request, HttpSession session) throws Exception {
        return ajaxPageService.planPage(request, session);
    }


    /////////////////////////////////
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
