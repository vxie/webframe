package com.vxie.debut.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.vxie.debut.business.ImportService;
import com.sunrise.springext.utils.SystemUtils;


@Controller
@RequestMapping(value = "/common/import")
public class ImportController extends AbstractController {

	@Autowired
	private ImportService importService;

	@RequestMapping(value = "/{subject}")
	public String importXls(ModelMap map, @PathVariable String subject) {
		map.put("subject", subject);
		return "/common/import";
	}

	@RequestMapping(value = "/download/{subject}")
	public void downloadXls(HttpServletResponse response, @PathVariable String subject) {
		String fileName = subject + "_import_template.xls";
		try {
			String realPath = SystemUtils.getClassPath() + "/../app/resources/template-xls/" + fileName;
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(realPath));
			FileCopyUtils.copy(bis, response.getOutputStream());
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			log.error("下载模板(" + fileName + ")文件出错！\n" + e.getMessage());
		}
	}

	@ResponseBody
	@RequestMapping(value = "/save/{subject}", method = RequestMethod.POST)
	public String uploadXls(HttpSession session, @RequestParam("xfile") CommonsMultipartFile uFile, @PathVariable String subject) {
		String userId = getSessionString(session, "cutUserId");
		Map<String, String> retMap = new HashMap<String, String>();
		retMap.put("total", "0");
//		if (!uFile.isEmpty() && uFile.getContentType().equals("application/vnd.ms-excel")) {//文件被打开的时候校验失败
		if (!uFile.isEmpty()) {
			try {
				String realPath = SystemUtils.getClassPath() + "/../tmp/" + new Date().getTime() + ".xls";
				File file = new File(realPath);
				uFile.getFileItem().write(file);//将上传的文件写入新建的文件中
				retMap.put("total", importService.handleXlsFile(userId, file, subject));
			} catch (Exception e) {
				log.error("导入数据出错！", e);
				retMap.put("error", e.getMessage());
				return JSONObject.fromObject(retMap).toString();
			}
		}
		return JSONObject.fromObject(retMap).toString();
	}
}
