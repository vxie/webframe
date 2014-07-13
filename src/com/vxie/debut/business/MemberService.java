package com.vxie.debut.business;

import com.sunrise.springext.support.json.JSONException;
import com.vxie.debut.model.Member;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;

@Service
public class MemberService extends BaseService {

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


    public String handleXlsFile(File file) throws JSONException {
        return null;
    }


}
