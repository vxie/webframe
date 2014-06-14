package com.sunrise.cutshow.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sunrise.cutshow.business.CutTaskService;
import com.sunrise.cutshow.model.CutTask;

@Controller
@RequestMapping(value="/task")
public class CutTaskController extends AbstractController {
	@Resource
	private CutTaskService cutTaskService;
	
	@RequestMapping(value="/set")
	public String setup(HttpSession session, ModelMap map){
		Long userId = getSessionLong(session, "cutUserId");
		if(userId != null){
			map.put("steps", cutTaskService.getVisitSteps(userId, getSessionLong(session, "isAdmin").intValue() > 0));
		} else {
			log.error("session timeout, please relogin or refresh !");
		}
		return "task/set";
	}
	
	
	@RequestMapping(value="/edit/{id}/{stepId}")
	public String edit(ModelMap map, @PathVariable long id, @PathVariable long stepId){
		map.put("cutTask", id==0?new CutTask(stepId):cutTaskService.getDao().get(CutTask.class, id));
		map.put("taskOperaters", cutTaskService.getTaskOperaters(id));
		map.put("taskCheckers", cutTaskService.getTaskCheckers(id));
		return "task/input";
	}
	
	@RequestMapping(value="/edit/save")
	@ResponseBody
	public String save(CutTask cutTask){
		cutTaskService.save(cutTask);
		return "0";
	}
	
	@RequestMapping(value="/del/{id}")
	@ResponseBody
	public String del(HttpSession session, @PathVariable long id) {
		cutTaskService.del(id);
		return "0";
	}
}
