package com.vxie.debut.action;


import com.sunrise.springext.utils.SystemUtils;
import com.vxie.debut.business.MemberService;
import com.vxie.debut.model.Member;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/member")
public class MemberController extends AbstractController {

    @Resource
    private MemberService memberService;


    @RequestMapping(value = "/list")
    public String list() {
        return "member/list";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(ModelMap map, @PathVariable long id) {
        map.put("currMember", id == 0 ? new Member() : memberService.getDao().get(Member.class, id));
        return "member/input";
    }


    @SuppressWarnings("static-access")
    @RequestMapping(value = "/edit/save")
    @ResponseBody
    public String save(Member member) {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("SUCCESS", "TRUE");
        result.put("MSG", "succeed");
        try {
            if (memberService.isExist(member.getId(), member.getPhoneNumber(), member.getName())) {
                throw new RuntimeException("该会员已经存在");
            }
            if(member.getId() == null) {
                //新增
                member.setId(memberService.genId());

            }
            memberService.save(member);
        } catch (Exception e) {
            log.error("MemberController.save error", e);
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "会员信息保存失败：" + e.getMessage());
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
            memberService.del(id);
        } catch (Exception e) {
            log.error("MemberController.del error");
            result.put("SUCCESS", "FALSE");
            result.put("MSG", "删除会员失败：" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


    @RequestMapping(value = "/import")
    public String importXls(HttpServletRequest req) {
        return "member/import";
    }

    @RequestMapping(value = "/download/xls")
    public void downloadXls(HttpServletResponse response) {
        String path = SystemUtils.getClassPath() + "/../app/resources/template-xls/user_import_template.xls";
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
            log.error("MemberController.downloadXls error", e);
        }
    }


    @RequestMapping(value = "/import/save", method = RequestMethod.POST)
    @ResponseBody
    public String uploadFile(@RequestParam("xfile") CommonsMultipartFile uFile) {
        if (!uFile.isEmpty()) {
            File file = new File(SystemUtils.getClassPath() + "/../tmp/" + new Date().getTime() + ".xls"); // 新建一个文件
            try {
                uFile.getFileItem().write(file);// 将上传的文件写入新建的文件中
                return memberService.handleXlsFile(file);
            } catch (Exception e) {
                log.error("MemberController.uploadFile error", e);
                return e.getMessage();
            }
        }
        return "";
    }


}
