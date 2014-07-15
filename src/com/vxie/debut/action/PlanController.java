package com.vxie.debut.action;

import com.vxie.debut.business.PlanService;
import com.vxie.debut.model.Plan;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/plan")
public class PlanController extends AbstractController {
    @Resource
    private PlanService planService;

    @RequestMapping(value = "/list")
    public String list() {
        return "plan/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currPlan", id == 0 ? new Plan() : planService.getDao().get(Plan.class, id));
        return "plan/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Plan plan) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
//            if (planService.isExist(plan.getId(), plan.getUserId(), plan.getGroupId())) {
//                throw new RuntimeException("该方案已经存在");
//            }
            if (plan.getId() == null) {
                //新增
                plan.setId(planService.genId());
            }
            plan.setMakeTime(new Date()); //更新时间
            planService.save(plan);
        } catch (Exception e) {
            log.error("PlanController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "方案保存失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

    @RequestMapping(value = "/del/{id}")
    @ResponseBody
    public String del(@PathVariable long id) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            planService.del(id);
        } catch (Exception e) {
            log.error("PlanController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除方案失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


}
