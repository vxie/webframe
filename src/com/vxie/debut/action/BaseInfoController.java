package com.vxie.debut.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vxie.debut.business.BaseInfoService;
import com.vxie.debut.model.CutBaseInfo;

@Controller
@RequestMapping(value="/baseinfo")
public class BaseInfoController extends AbstractController {
	@Resource
	private BaseInfoService baseInfoService;
	
	@RequestMapping(value="/set")
	public String list(ModelMap map){
		map.put("baseInfo", baseInfoService.find());
		map.put("cutOwners", baseInfoService.cutOwners());
		return "baseinfo/set";
	}
	
	@RequestMapping(value="/save")
	public String save(ModelMap map, CutBaseInfo cutBaseInfo){
		baseInfoService.save(cutBaseInfo);
		map.put("baseInfo", cutBaseInfo);
		return "baseinfo/set";
	}
	
}
