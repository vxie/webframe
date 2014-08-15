package com.vxie.debut.business;

import com.vxie.debut.model.AdminUser;
import com.vxie.debut.utils.MD5Encoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminUserService extends BaseService {
	
	@Autowired
	private DictService dictService;

	public static final String DEFAULT_PWD = MD5Encoder.encode("123456");

	public Map<Long, String[]> getRoles(Long id) {
		final Map<Long, String[]> map = new LinkedHashMap<Long, String[]>();
		dao.getSimpleJdbcTemplate().query(
				" select r.role_id, r.role_name, u.user_id from cut_role r "+
				" left join cut_user_role u on u.role_id=r.role_id and u.user_id=? "+
				" order by r.role_id",
				new RowMapper<Object>() {
					public Map<String, Long> mapRow(ResultSet rs, int arg1)
							throws SQLException {
						map.put(rs.getLong(1), new String[]{rs.getString(2), rs.getString(3)});
						return null;
					}
				},
				id
		);
		return map;
	}

	@Transactional
	public void save(AdminUser adminUser) {
		dao.saveOrUpdate(adminUser);
	}

	@Transactional
	public void del(long id) {
		dao.delete(AdminUser.class, id);
	}

    @Transactional
    public void changePwd(Long userId, String oldpwd, String newpwd) {
        List<AdminUser> adminUsers = dao.find(AdminUser.class, "from AdminUser u where u.id=? and u.password=?", userId, MD5Encoder.encode(oldpwd));
        if (adminUsers.isEmpty()) {
            throw new RuntimeException("旧密码错误，请重新输入旧密码");
        }
        adminUsers.get(0).setPassword(MD5Encoder.encode(newpwd));
        dao.save(adminUsers.get(0));
    }
	
	public Boolean isExist(Long userid, String number){
		if(userid != null){
            //编辑用户时
			return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_admin where id <>? and number=?", userid, number) > 0;
		}
        //新建用户时
		return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_admin where number=?", number) > 0;
	}

    public Long genId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_admin") + 1L;
    }

}
