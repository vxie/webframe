package com.vxie.debut.business;

import com.vxie.debut.model.Layout;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LayoutService extends BaseService {
    @Transactional
    public void save(Layout layout) {
        dao.saveOrUpdate(layout);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Layout.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_layout") + 1L;
    }

}
