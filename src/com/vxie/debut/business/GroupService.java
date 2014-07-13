package com.vxie.debut.business;


import com.vxie.debut.model.Group;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GroupService extends BaseService {
    @Transactional
    public void save(Group group) {
        dao.saveOrUpdate(group);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Group.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_group") + 1L;
    }


    public Boolean isExist(Long groupid, String name) {
        if (groupid != null) {
            //编辑
            return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_group where id <> ? and name=?",
                    groupid, name) > 0;
        }
        //新建
        return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_group where name=?", name) > 0;
    }

}
