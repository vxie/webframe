package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.vxie.debut.model.AdminUser;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.vxie.debut.utils.Constants;
import com.sunrise.springext.utils.DataSourceUtils;
import com.sunrise.sqlpage.Pageable;
import com.sunrise.sqlpage.SQLPage;
import com.sunrise.sqlpage.intf.EntitiesHandler;


@Service
public class AjaxPageService extends BaseService {
	
	public String userPage(HttpServletRequest request) throws Exception {
		String sql = "select number, name, '' areaName, '' action, id  from t_admin where  role <> 0";
		
		Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
		
		page.registerQueryParams("param_number", "number = ?", String.class);
		page.registerQueryParams("param_name", "name like ?", String.class);
		page.registerQueryParams("param_areaId", "areaId = ?", String.class);

		return page.generatePageContent(request, AdminUser.class, new EntitiesHandler<AdminUser>(){
        	public List<AdminUser> handle(List<AdminUser> rows) throws Exception {
        		for (AdminUser adminUser : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_area a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1)
                                        throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            adminUser.getAreaId()
                    );
                    adminUser.setAreaName(list.size() > 0 ? list.get(0) : "");
                }
        		return rows;
        	}
        });
	}
	
	public String rolePage(HttpServletRequest request) throws Exception {
		String sql = "select role_id, role_name, role_memo from cut_role where 1=1 ";
		
		Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by role_id");
		
		page.registerQueryParams("roleName", "role_name like ?", String.class);
		
		return page.generatePageContent(request);
	}
	
	public String stepPage(HttpServletRequest request) throws Exception {
		String sql = "select s.step_index, s.step_name, s.step_weight_value, cast(s.step_times / 60 as dec(18,2)) step_times, u.user_real_name step_owner, t.user_real_name step_checker, '' step_action, s.step_id, s.step_owner_id from cut_step s " +
			" left join cut_user u on u.user_id=s.step_owner_id " +
			" left join cut_user t on t.user_id=s.step_checker_id " +
			" where 1=1 ";
		
		Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by step_index");
		
		page.registerQueryParams("stepName", "step_name like ?", String.class);
		
		return page.generatePageContent(request);
	}
}
