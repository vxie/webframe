package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.vxie.debut.model.*;
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
		String sql = "select id, number, name, '' areaName, '' action from t_admin where  role <> 0";
		
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
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select  id, name, phoneNumber, medicalRecordId, address, groupId, age, time, brithday, areaId, " +
                "filename, '' action, password from t_user where 1=1";

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

    public String groupPage(HttpServletRequest request) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select id, name, '' headName, '' action, headId from t_group where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("id", "id = ?", String.class);
        page.registerQueryParams("name", "name like ?", String.class);
        page.registerQueryParams("headId", "headId = ?", String.class);

        return page.generatePageContent(request, Group.class, new EntitiesHandler<Group>() {
            public List<Group> handle(List<Group> rows) throws Exception {
                for (Group group : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_admin a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            group.getHeadId()
                    );
                    group.setHeadName(list.size() > 0 ? list.get(0) : "");
                }
                return rows;
            }
        });
    }


    public String areaPage(HttpServletRequest request) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select id, name, '' action from t_area where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("id", "id = ?", String.class);
        page.registerQueryParams("name", "name like ?", String.class);

        return page.generatePageContent(request, Area.class, new EntitiesHandler<Area>() {
            public List<Area> handle(List<Area> rows) throws Exception {
                //
                return rows;
            }
        });
    }


    public String branchPage(HttpServletRequest request) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select id, name, address, longitude, latitude, '' action from t_branch where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("name", "name like ?", String.class);
        page.registerQueryParams("address", "address like ?", String.class);
        page.registerQueryParams("longitude", "longitude = ?", String.class);
        page.registerQueryParams("latitude", "latitude = ?", String.class);

        return page.generatePageContent(request, Branch.class, new EntitiesHandler<Branch>() {
            public List<Branch> handle(List<Branch> rows) throws Exception {
                //
                return rows;
            }
        });
    }


    public String spacePage(HttpServletRequest request) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select id, userId, '' userName, picName, time, content, state from t_space where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("id", "id = ?", String.class);
        page.registerQueryParams("userId", "userId = ?", String.class);
        page.registerQueryParams("content", "content like ?", String.class);

        return page.generatePageContent(request, Space.class, new EntitiesHandler<Space>() {
            public List<Space> handle(List<Space> rows) throws Exception {
                for (Space space : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_user a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            space.getUserId()
                    );
                    space.setUserName(list.size() > 0 ? list.get(0) : "");
                }
                return rows;
            }
        });
    }


    public String pushinfoPage(HttpServletRequest request) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select id, adminId, '' adminName, time, content, '' action from t_pushinfo where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("id", "id = ?", String.class);
        page.registerQueryParams("adminId", "adminId = ?", String.class);
        page.registerQueryParams("content", "content like ?", String.class);

        return page.generatePageContent(request, PushInfo.class, new EntitiesHandler<PushInfo>() {
            public List<PushInfo> handle(List<PushInfo> rows) throws Exception {
                for (PushInfo pushInfo : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_admin a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            pushInfo.getAdminId()
                    );
                    pushInfo.setAdminName(list.size() > 0 ? list.get(0) : "");
                }
                return rows;
            }
        });
    }


    public String layoutPage(HttpServletRequest request) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select id, textContent, picName, disorder, useing, updatetime, '' action from t_layout where 1=1";

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("textContent", "textContent = ?", String.class);
        page.registerQueryParams("picName", "picName = ?", String.class);
        page.registerQueryParams("useing", "useing = ?", String.class);

        return page.generatePageContent(request, Layout.class, new EntitiesHandler<Layout>() {
            public List<Layout> handle(List<Layout> rows) throws Exception {
                //
                return rows;
            }
        });
    }


    public String planPage(HttpServletRequest request, HttpSession session) throws Exception {
        AdminUser adminUser = (AdminUser) session.getAttribute("adminUser");  //当显示当前营养师的记录
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select p.id, p.groupId, p.userId, '' userName, p.breakfast, p.lunch, p.dinner, p.sendTime, p.makeTime," +
                " p.remarks, '' action from t_plan p, t_group g where p.groupId=g.id and g.headId="
                + adminUser.getId();

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");
        page.registerQueryParams("id", "id =", String.class);
        page.registerQueryParams("groupId", "groupId =", String.class);
        page.registerQueryParams("userId", "userId =", String.class);

        return page.generatePageContent(request, Plan.class, new EntitiesHandler<Plan>() {
            public List<Plan> handle(List<Plan> rows) throws Exception {
                for (Plan plan : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_user a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            plan.getUserId()
                    );
                    plan.setUserName(list.size() > 0 ? list.get(0) : "");
                }
                return rows;
            }
        });
    }


    public String scorePage(HttpServletRequest request, String headId) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select s.userId, '' userName, s.planId, s.score, s.time, s.id from t_score s, t_plan p, t_group g" +
                " where p.groupId=g.id and s.planId=p.id and g.headId=" + headId;

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");

        return page.generatePageContent(request, Score.class, new EntitiesHandler<Score>() {
            public List<Score> handle(List<Score> rows) throws Exception {
                for (Score score : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_user a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            score.getUserId()
                    );
                    score.setUserName(list.size() > 0 ? list.get(0) : "");
                }
                return rows;
            }
        });
    }


    public String feedbackPage(HttpServletRequest request, String headId) throws Exception {
        //select 的字段顺序要严格对应页面列表中的顺序
        String sql = "select f.userId, '' userName, f.planId, f.content, f.time, f.id from t_feedback f, t_plan p, t_group g" +
                " where p.groupId=g.id and f.planId=p.id and g.headId=" + headId;

        Pageable page = SQLPage.newInstance(Constants.DB_NAME, DataSourceUtils.getDataSource(dao), sql, "order by id");

        return page.generatePageContent(request, Feedback.class, new EntitiesHandler<Feedback>() {
            public List<Feedback> handle(List<Feedback> rows) throws Exception {
                for (Feedback feedback : rows) {
                    List<String> list = dao.getSimpleJdbcTemplate().query(
                            "select a.name from t_user a where a.id=?",
                            new RowMapper<String>() {
                                public String mapRow(ResultSet rs, int arg1) throws SQLException {
                                    return rs.getString(1);
                                }
                            },
                            feedback.getUserId()
                    );
                    feedback.setUserName(list.size() > 0 ? list.get(0) : "");
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
