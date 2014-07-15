package com.vxie.debut.business;

import com.vxie.debut.model.PushInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PushInfoService extends BaseService {
    @Transactional
    public void save(PushInfo pushInfo) {
        dao.saveOrUpdate(pushInfo);
    }

    @Transactional
    public void del(long id) {
        dao.delete(PushInfo.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_pushInfo") + 1L;
    }

}
