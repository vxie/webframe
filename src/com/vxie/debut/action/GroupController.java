package com.vxie.debut.action;

import com.vxie.debut.business.GroupService;
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
@RequestMapping(value = "/group")
public class GroupController extends AbstractController {

    @Resource
    private GroupService groupService;


    @RequestMapping(value = "/list")
    public String list() {
        return "group/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currGroup", id == 0 ? new Group() : groupService.getDao().get(Group.class, id));
        return "group/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Group group) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            if (groupService.isExist(group.getId(), group.getName())) {
                throw new RuntimeException("该分组已经存在");
            }
            if(group.getId() == null) {
                //新增
                group.setId(groupService.genId());
            }
            groupService.save(group);
        } catch (Exception e) {
            log.error("MemberController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "分组信息保存失败：" + e.getMessage());
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
            groupService.del(id);
        } catch (Exception e) {
            log.error("MemberController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除分组失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

}
