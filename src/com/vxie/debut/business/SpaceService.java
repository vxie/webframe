package com.vxie.debut.business;

import com.vxie.debut.model.Space;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SpaceService extends BaseService {

    @Transactional
    public void save(Space space) {
        dao.saveOrUpdate(space);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Space.class, id);
    }

    @Transactional
    public void pass(long id) {
        //审核通过
        dao.getSimpleJdbcTemplate().update("update t_space set state=1 where id=?", id);
    }

    @Transactional
    public void reject(long id) {
        //审核不通过
        dao.getSimpleJdbcTemplate().update("update t_space set state=2 where id=?", id);
    }


}
