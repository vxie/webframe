package com.vxie.debut.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vxie.debut.model.AdminUser;
import net.sf.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.vxie.debut.business.AdminUserService;
import com.sunrise.springext.utils.SystemUtils;

@Controller
@RequestMapping(value = "/user")
public class AdminUserController extends AbstractController {

	@Resource
	private AdminUserService adminUserService;

	@RequestMapping(value = "/list")
	public String list() {
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
//            if (adminUserService.hasLoginName(userid, number)) {
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
            if (adminUserService.hasLoginName(adminUser.getId(), adminUser.getNumber())) {
                throw new RuntimeException("该手机号码已经存在");
            }
            if(adminUser.getId() == null) {
                //新增
                adminUser.setId(adminUserService.genUserId());
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
		adminUserService.del(id);
		return "0";
	}

	@RequestMapping(value = "/changepwd")
	public String changePwd() {
		return "users/changepwd";
	}

	@RequestMapping(value = "/changepwd/save")
	@ResponseBody
	public String saveChangePwd(HttpSession session, String oldpwd,
			String newpwd) {
		int n = 1;
		AdminUser adminUser = (AdminUser) session.getAttribute("adminUser");
		if (adminUser != null) {
			n = adminUserService.changePwd(adminUser.getId(), oldpwd,
					newpwd);
			if (n == 0)
				adminUser.setPassword(newpwd);
		}
		return n + "";
	}

	@RequestMapping(value = "/import")
	public String importXls(HttpServletRequest req) {
		return "users/import";
	}
	
	@RequestMapping(value = "/download/xls")
	public void downloadXls(HttpServletResponse response){
		  String path = SystemUtils.getClassPath()+"/../app/resources/template-xls/user_import_template.xls";
		  try {
			  response.reset();
			  response.setContentType("application/octet-stream");
			  response.setHeader("Content-Disposition", "attachment;filename=user_import_template.xls");
			  BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));
			  FileCopyUtils.copy(bis, response.getOutputStream());
			  
			  //response.flushBuffer();
			  response.getOutputStream().flush();
			  response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	@RequestMapping(value = "/import/save", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFile(@RequestParam("xfile") CommonsMultipartFile uFile) { 
		if (!uFile.isEmpty()) {
			File file = new File(SystemUtils.getClassPath()+"/../tmp/" + new Date().getTime() + ".xls"); // 新建一个文件
			try {
				uFile.getFileItem().write(file);// 将上传的文件写入新建的文件中
				return adminUserService.handleXlsFile(file);
			} catch (Exception e) {
				e.printStackTrace();
				return e.getMessage();
			}
		} else return "";
	}
}
