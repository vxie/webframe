package com.vxie.debut.action;

import com.vxie.debut.business.AdminUserService;
import com.vxie.debut.business.AreaService;
import com.vxie.debut.model.AdminUser;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/user")
public class AdminUserController extends AbstractController {

	@Resource
	private AdminUserService adminUserService;

    @Resource
    private AreaService areaService;

    @RequestMapping(value = "/list")
	public String list(ModelMap map) {
        map.put("areaList", areaService.queryAreaList());
		return "users/list";
	}

	@RequestMapping(value = "/edit/{id}")
	public String edit(ModelMap map, @PathVariable long id) {
		map.put("currUser", id == 0 ? new AdminUser() : adminUserService.getDao()
				.get(AdminUser.class, id));
		return "users/input";
	}

	@RequestMapping(value = "/edit/check")
	@ResponseBody
	public String check(String userid, String number) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "check succeed");
        try {
//            if (adminUserService.isExist(userid, number)) {
//                throw new RuntimeException("该手机号码已经存在");
//            }
        } catch (Exception e) {
            log.error("AdminUserController.check error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "操作失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

	@SuppressWarnings("static-access")
	@RequestMapping(value = "/edit/save")
	@ResponseBody
	public String save(AdminUser adminUser) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            if (adminUserService.isExist(adminUser.getId(), adminUser.getNumber())) {
                throw new RuntimeException("该手机号码已经存在");
            }
            if(adminUser.getId() == null) {
                //新增
                adminUser.setId(adminUserService.genId());
                adminUser.setPassword(adminUserService.DEFAULT_PWD);
                adminUser.setRole(1);
            } else {
                //编辑
                AdminUser inuser = adminUserService.getDao().get(AdminUser.class, adminUser.getId());
                if(inuser != null) {
                    inuser.setNumber(adminUser.getNumber());
                    inuser.setName(adminUser.getName());
                    inuser.setAreaId(adminUser.getAreaId());
                    adminUser = inuser;
                }
            }
            adminUserService.save(adminUser);
        } catch (Exception e) {
            log.error("AdminUserController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "用户信息保存失败：" + e.getMessage());
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
            adminUserService.del(id);
        } catch (Exception e) {
            log.error("AdminUserController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除用户失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

	@RequestMapping(value = "/changepwd")
	public String changePwd() {
		return "users/changepwd";
	}

	@RequestMapping(value = "/changepwd/save")
	@ResponseBody
	public String saveChangePwd(HttpSession session, String oldpwd,
			String newpwd) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            AdminUser adminUser = (AdminUser) session.getAttribute("adminUser");
            if (adminUser != null) {
                adminUserService.changePwd(adminUser.getId(), oldpwd, newpwd);
            }
        } catch (Exception e) {
            log.error("AdminUserController.saveChangePwd error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "密码修改失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

}
