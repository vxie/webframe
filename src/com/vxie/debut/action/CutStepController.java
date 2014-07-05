package com.vxie.debut.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vxie.debut.business.CutProgressService;
import com.vxie.debut.business.CutStepService;
import com.vxie.debut.model.CutStep;

@Controller
@RequestMapping(value="/step")
public class CutStepController extends AbstractController {
	@Resource
	private CutStepService cutStepService;
	
	@Resource
	private CutProgressService cutProgressService;
	
	@ResponseBody
	@RequestMapping(value="/tasks")
	public String tasks(Long stepId) throws Exception {
		return cutStepService.getTasksByStepId(stepId);
	}
	
	
	//lw  2011-0830
	@RequestMapping(value="/taskinfo/{stepId}")
	public String getTaskInfoById(ModelMap map,@PathVariable Long stepId) throws Exception {
		
		map.put("step", cutStepService.getStepById(stepId));
		map.put("tasks", cutStepService.getTasksByStepId2(stepId));
		map.put("status", cutProgressService.getStepStatus());
		return "progress/oneinfo";
	}

	@RequestMapping(value="/set")
	public String list(){
		return "step/list";
	}
	
	@RequestMapping(value="/edit/{id}")
	public String edit(ModelMap map, @PathVariable long id){
		map.put("cutStep", id==0?new CutStep():cutStepService.getDao().get(CutStep.class, id));
		map.put("stepOwners", cutStepService.getAllStepOwnerRoleUsers());
		map.put("stepCheckers", cutStepService.getAllStepCheckerRoleUsers());
		map.put("taskUsers", cutStepService.getAllTaskUsers(id));
		map.put("status", cutStepService.getStepStatus());
		return "step/input";
	}
	
	@RequestMapping(value="/edit/save")
	@ResponseBody
	public String save(CutStep cutStep){
		cutStepService.save(cutStep);
		return "0";
	}
	
	
	@RequestMapping(value="/del/{id}")
	@ResponseBody
	public String del(@PathVariable long id) {
		cutStepService.del(id);
		return "0";
	}
}
