package com.vxie.debut.business;


import com.vxie.debut.model.Branch;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BranchService  extends BaseService {
    @Transactional
    public void save(Branch branch) {
        dao.saveOrUpdate(branch);
    }

    @Transactional
    public void del(long id) {
        dao.delete(Branch.class, id);
    }

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_branch") + 1L;
    }


    public Boolean isExist(Long branchid, String name) {
        if (branchid != null) {
            //编辑
            return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_branch where id <> ? and name=?",
                    branchid, name) > 0;
        }
        //新建
        return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_branch where name=?", name) > 0;
    }


}
