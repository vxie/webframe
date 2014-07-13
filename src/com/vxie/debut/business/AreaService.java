package com.vxie.debut.business;


import com.vxie.debut.model.Area;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AreaService extends BaseService {
    @Transactional
    public void save(Area area) {
        dao.saveOrUpdate(area);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Area.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_area") + 1L;
    }


    public Boolean isExist(Long areaid, String name) {
        if (areaid != null) {
            //编辑
            return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_area where id <> ? and name=?",
                    areaid, name) > 0;
        }
        //新建
        return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_area where name=?", name) > 0;
    }

}
