package com.vxie.debut.business;

import com.vxie.debut.model.Assessment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AssessmentService extends BaseService {

    @Transactional
    public void save(Assessment assessment) {
        dao.saveOrUpdate(assessment);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Assessment.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForLong("select max(id) from t_assessment") + 1;
    }
}
