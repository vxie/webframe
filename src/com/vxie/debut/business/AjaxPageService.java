package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.vxie.debut.model.AdminUser;
import com.vxie.debut.model.Member;
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
		
		page.registerQueryParams("number", "number = ?", String.class);
		page.registerQueryParams("name", "name like ?", String.class);
		page.registerQueryParams("areaid", "areaid = ?", String.class);

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

    public String memberPage(HttpServletRequest request) throws Exception {
        String sql = "select name, phoneNumber, medicalRecordId, address, groupId, age, time, brithday, areaId, " +
                "filename, id, password from t_user where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("name", "name like ?", String.class);
        page.registerQueryParams("phoneNumber", "phoneNumber = ?", String.class);
        page.registerQueryParams("medicalRecordId", "medicalRecordId = ?", String.class);
        page.registerQueryParams("groupId", "groupId = ?", String.class);
        page.registerQueryParams("areaId", "areaId = ?", String.class);
        page.registerQueryParams("filename", "filename like ?", String.class);
        page.registerQueryParams("address", "address like ?", String.class);

        return page.generatePageContent(request, Member.class, new EntitiesHandler<Member>() {
            public List<Member> handle(List<Member> rows) throws Exception {
                for (Member member : rows) {
                    //翻译地区名称
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_area a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            member.getAreaId()
                    );
                    member.setAreaName(list.size() > 0 ? list.get(0) : "");
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
