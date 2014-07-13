package com.vxie.debut.action;


import com.vxie.debut.business.AreaService;
import com.vxie.debut.model.Area;
import com.vxie.debut.model.Group;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/area")
public class AreaController extends AbstractController {
    @Resource
    private AreaService areaService;


    @RequestMapping(value = "/list")
    public String list() {
        return "area/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currArea", id == 0 ? new Area() : areaService.getDao().get(Area.class, id));
        return "area/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Area area) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            if (areaService.isExist(area.getId(), area.getName())) {
                throw new RuntimeException("该地区已经存在");
            }
            if (area.getId() == null) {
                //新增
                area.setId(areaService.genId());
            }
            areaService.save(area);
        } catch (Exception e) {
            log.error("AreaController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "地区信息保存失败：" + e.getMessage());
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
            areaService.del(id);
        } catch (Exception e) {
            log.error("AreaController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除地区失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


}
