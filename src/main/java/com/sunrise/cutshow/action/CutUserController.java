package com.sunrise.cutshow.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.sunrise.cutshow.business.CutUserService;
import com.sunrise.cutshow.model.CutUser;
import com.sunrise.springext.utils.SystemUtils;

@Controller
@RequestMapping(value = "/user")
public class CutUserController extends AbstractController {

	@Resource
	private CutUserService cutUserService;

	@RequestMapping(value = "/list")
	public String list() {
		return "users/list";
	}

	@RequestMapping(value = "/edit/{id}")
	public String edit(ModelMap map, @PathVariable long id) {
		map.put("oneCutUser", id == 0 ? new CutUser() : cutUserService.getDao()
				.get(CutUser.class, id));
		map.put("roles", cutUserService.getRoles(id));
		return "users/input";
	}

	@RequestMapping(value = "/edit/check")
	@ResponseBody
	public String check(Long userId, String userLoginName) {
		return cutUserService.hasLoginName(userId, userLoginName) ? "1" : "0";
	}

	@SuppressWarnings("static-access")
	@RequestMapping(value = "/edit/save")
	@ResponseBody
	public String save(CutUser cutUser) {
        if(cutUser.getUserId() == null) {
            cutUser.setUserId(cutUserService.genUserId());
        }
		cutUser.setUserPassword(cutUserService.DEFAULT_PWD);
		cutUserService.save(cutUser);
		return "0";
	}

	@RequestMapping(value = "/del/{id}")
	@ResponseBody
	public String del(@PathVariable long id) {
		cutUserService.del(id);
		return "0";
	}

	@RequestMapping(value = "/changepwd")
	public String changePwd() {
		return "users/changepwd";
	}

	@RequestMapping(value = "/changepwd/save")
	@ResponseBody
	public String saveChangePwd(HttpSession session, String oldUserPwd,
			String newUserPwd) {
		int n = 1;
		CutUser cutUser = (CutUser) session.getAttribute("cutUser");
		if (cutUser != null) {
			n = cutUserService.changePwd(cutUser.getUserId(), oldUserPwd,
					newUserPwd);
			if (n == 0)
				cutUser.setUserPassword(newUserPwd);
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
				return cutUserService.handleXlsFile(file);
			} catch (Exception e) {
				e.printStackTrace();
				return e.getMessage();
			}
		} else return "";
	}
}
