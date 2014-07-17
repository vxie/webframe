package com.vxie.debut.action;

import com.vxie.debut.business.AssessmentService;
import com.vxie.debut.model.Assessment;
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
@RequestMapping(value = "/assessment")
public class AssessmentController extends AbstractController {
    @Resource
    private AssessmentService assService;


    @RequestMapping(value = "/list/{adminId}")
    public String list(ModelMap map, @PathVariable String adminId) {
        map.put("adminId", adminId);
        return "assessment/list";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Assessment assessment) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            if (assessment.getId() == null) {
                //新增
                assessment.setId(assService.genId());
            }
            assessment.setTime(new Date());
            assService.save(assessment);
        } catch (Exception e) {
            log.error("AssessmentController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "考核失败：" + e.getMessage());
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
            assService.del(id);
        } catch (Exception e) {
            log.error("AssessmentController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除考核记录失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


}
