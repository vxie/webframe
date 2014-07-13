package com.vxie.debut.action;

import com.vxie.debut.business.BranchService;
import com.vxie.debut.model.Branch;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/branch")
public class BranchController extends AbstractController {
    @Resource
    private BranchService branchService;


    @RequestMapping(value = "/list")
    public String list() {
        return "branch/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currBranch", id == 0 ? new Branch() : branchService.getDao().get(Branch.class, id));
        return "branch/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Branch branch) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            if (branchService.isExist(branch.getId(), branch.getName())) {
                throw new RuntimeException("该分店已经存在");
            }
            if (branch.getId() == null) {
                //新增
                branch.setId(branchService.genId());
            }
            branchService.save(branch);
        } catch (Exception e) {
            log.error("BranchController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "分店信息保存失败：" + e.getMessage());
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
            branchService.del(id);
        } catch (Exception e) {
            log.error("BranchController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除分店失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


}
