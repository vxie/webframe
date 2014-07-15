package com.vxie.debut.business;


import com.vxie.debut.model.Plan;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PlanService extends BaseService {
    @Transactional
    public void save(Plan plan) {
        dao.saveOrUpdate(plan);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Plan.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForLong("select max(id) from t_plan") + 1;
    }

    public Boolean isExist(Long planid, Long userId, Long groupId) {
        if (planid != null) {
            //编辑
            return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_plan where id <> ? and userId=?" +
                    " and groupId=?", planid, userId, groupId) > 0;
        }
        //新建
        return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_plan where userId=? and groupId=?",
                userId, groupId) > 0;
    }


}
