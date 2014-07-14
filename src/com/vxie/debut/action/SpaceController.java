package com.vxie.debut.action;

import com.vxie.debut.business.SpaceService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/space")
public class SpaceController extends AbstractController {
    @Resource
    private SpaceService spaceService;


    @RequestMapping(value = "/list")
    public String list() {
        return "space/list";
    }


    @RequestMapping(value = "/del/{id}")
    @ResponseBody
    public String del(@PathVariable long id) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            spaceService.del(id);
        } catch (Exception e) {
            log.error("SpaceController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除信息失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


    @RequestMapping(value = "/pass/{id}")
    @ResponseBody
    public String pass(@PathVariable long id) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            spaceService.pass(id);
        } catch (Exception e) {
            log.error("SpaceController.pass error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "信息审核失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


    @RequestMapping(value = "/reject/{id}")
    @ResponseBody
    public String reject(@PathVariable long id) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            spaceService.reject(id);
        } catch (Exception e) {
            log.error("SpaceController.reject error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "信息审核失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


}
