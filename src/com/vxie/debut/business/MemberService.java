package com.vxie.debut.business;

import com.sunrise.springext.support.json.JSONException;
import com.sunrise.springext.support.json.JSONUtil;
import com.vxie.debut.model.Member;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class MemberService extends BaseService {
    private static final String XLS_END_FLAG = "<EOF>";

    @Transactional
    public void save(Member member) {
        dao.saveOrUpdate(member);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Member.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_user") + 1L;
    }


    public Boolean isExist(Long userid, String phoneNumber, String name) {
        if (userid != null) {
            //编辑用户时
            return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_user where id <> ? and phoneNumber=? and name=?",
                    userid, phoneNumber, name) > 0;
        }
        //新建用户时
        return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_user where phoneNumber=? and name=?",
                phoneNumber, name) > 0;
    }


    public Map<String, String> handleXlsFile(File file) throws JSONException {
        Map<String, String> result = new HashMap<String, String>();
        int rowCount = 2;
        int succCount = 0;
        int failCount = 0;

        Workbook book = null;
        try {
            book = Workbook.getWorkbook(file);
            Sheet sheet = book.getSheet(0);
            while (true) {
                //会员名	联系电话	地址	分组ID	年龄	密码	注册时间	生日	地区ID	病历附件名 病历ID
                Cell[] cells = sheet.getRow(rowCount);
                if (cells == null || cells.length == 0) {
                    break;
                }
                String name = cells[0].getContents();
                if (XLS_END_FLAG.equals(name)) {
                    break;
                }
                Member member = new Member();
                member.setId(genId());
                member.setName(name);
                member.setPhoneNumber(cells[1].getContents());
                member.setAddress(cells[2].getContents());
                try {
                    member.setGroupId(Long.parseLong(cells[3].getContents()));
                } catch (NumberFormatException e) {
                    //ignore
                }
                try {
                    member.setAge(Integer.parseInt(cells[4].getContents()));
                } catch (NumberFormatException e) {
                    //ignore
                }

                String password = cells[5].getContents();
                if (password == null || password.trim().length() == 0) {
                    password = "123456";
                }
                member.setPassword(password.trim());
                member.setTime(new Date());//默认为当前时间
                String regdate = cells[6].getContents();
                if (regdate != null && regdate.trim().length() > 0) {
                    try {
                        member.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(regdate));
                    } catch (ParseException e) {
                        //ignore
                    }
                }
                member.setBrithday(cells[7].getContents());
                member.setAreaId(cells[8].getContents());
                member.setFilename(cells[9].getContents());
                try {
                    member.setMedicalRecordId(Long.parseLong(cells[10].getContents()));
                } catch (NumberFormatException e) {
                    //ignore
                }

                try {
                    this.save(member);
                    succCount++;
                } catch (Exception e) {
                    log.error("MemberService.handleXlsFile error--row:" + rowCount, e);
                    failCount++;
                }
                rowCount++;
            }

        } catch (Exception e) {
            log.error("MemberService.handleXlsFile error", e);
        } finally {
            if (book != null) {
                try {
                    book.close();
                    file.delete();
                } catch (Exception e) {
                    //ignore
                }
            }
        }
        result.put("CountItems", (rowCount - 2) + "");
        result.put("HandledItems", (failCount + succCount) + "");
        result.put("Success", succCount + "");
        result.put("Fail", failCount + "");
        return result;
    }


}
