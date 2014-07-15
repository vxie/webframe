package com.vxie.debut.action;

import com.vxie.debut.business.LayoutService;
import com.vxie.debut.model.Layout;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/layout")
public class LayoutController extends AbstractController {
    @Resource
    private LayoutService layoutService;


    @RequestMapping(value = "/list")
    public String list() {
        return "layout/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currLayout", id == 0 ? new Layout() : layoutService.getDao().get(Layout.class, id));
        return "layout/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Layout layout) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {

            if (layout.getId() == null) {
                //新增
                layout.setId(layoutService.genId());
            }
            layoutService.save(layout);
        } catch (Exception e) {
            log.error("LayoutController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "主界面保存失败：" + e.getMessage());
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
            layoutService.del(id);
        } catch (Exception e) {
            log.error("LayoutController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除主界面失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

}
