package com.sunrise.cutshow.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.sunrise.cutshow.business.CutRoleService;
import com.sunrise.cutshow.model.CutRole;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/role")
public class CutRoleController extends AbstractController {
	@Resource
	private CutRoleService cutRoleService;
	
	@RequestMapping(value="/list")
	public String list(){
		return "roles/list";
	}
	
	@RequestMapping(value="/edit/{id}")
	public String edit(HttpSession session, ModelMap map, @PathVariable long id){
		map.put("cutRole", id==0?new CutRole():cutRoleService.getDao().get(CutRole.class, id));
		map.put("menus", cutRoleService.getAllMenus(id));
		return "roles/input";
	}
	
	@RequestMapping(value="/edit/save")
	@ResponseBody
	public String save(CutRole cutRole){
		cutRoleService.save(cutRole);
		return "0";
	}
	
	@RequestMapping(value="/del/{id}")
	@ResponseBody
	public String save(@PathVariable long id) {
		cutRoleService.del(id);
		return "0";
	}
}
