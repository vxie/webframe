package com.vxie.debut.action;

import com.vxie.debut.business.PushInfoService;
import com.vxie.debut.model.PushInfo;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/pushinfo")
public class PushInfoController extends AbstractController {
    @Resource
    private PushInfoService pushInfoService;


    @RequestMapping(value = "/list")
    public String list() {
        return "pushinfo/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currPushInfo", id == 0 ? new PushInfo() : pushInfoService.getDao().get(PushInfo.class, id));
        return "pushinfo/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(PushInfo pushInfo) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {

            if (pushInfo.getId() == null) {
                //新增
                pushInfo.setId(pushInfoService.genId());
            }
            pushInfoService.save(pushInfo);
        } catch (Exception e) {
            log.error("PushInfoController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "推送信息保存失败：" + e.getMessage());
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
            pushInfoService.del(id);
        } catch (Exception e) {
            log.error("PushInfoController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除推送失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

}



