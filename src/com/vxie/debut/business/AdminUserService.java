package com.vxie.debut.business;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.vxie.debut.model.AdminUser;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vxie.debut.utils.Constants;
import com.vxie.debut.utils.MD5Encoder;
import com.sunrise.springext.support.json.JSONException;
import com.sunrise.springext.support.json.JSONUtil;

@Service
public class AdminUserService extends BaseService {
	
	@Autowired
	private DictService dictService;
	
	private static final String addUserSql = "insert into cut_user(user_id, user_login_name, user_real_name, user_password) values(?,?,?,?)";
	private static final String addUserRoleSql = "insert into cut_user_role(user_id, role_id) values(?, ?)";
	
	public static final String DEFAULT_PWD = MD5Encoder.encode("123456");
	private static final String XLS_END_FLAG = "<EOF>";

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
	
	public Boolean hasLoginName(Long userid, String number){
		if(userid != null){
            //编辑用户时
			return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_admin where id <>? and number=?", userid, number) > 0;
		}
        //新建用户时
		return dao.getSimpleJdbcTemplate().queryForInt("select count(id) from t_admin where number=?", number) > 0;
	}

    public Long genUserId() {
        return dao.getSimpleJdbcTemplate().queryForInt("select max(id) from t_admin") + 1L;
    }

    public String handleXlsFile(File file) throws JSONException {
		Workbook book = null;
		Map<String, Integer> m = new HashMap<String, Integer>();
		int i = 2;
		int s = 0;
		int f = 0;
		try {
			book = Workbook.getWorkbook(file);
			Sheet sheet = book.getSheet(0);
			while(true){
				Cell[] c = sheet.getRow(i);
				if(c!=null && c.length > 0){
					String loginName = c[0].getContents().trim();
					if(!loginName.equals("")){
						
						if(loginName.equals(XLS_END_FLAG)) break;
						
						AdminUser adminUser = new AdminUser();
//						adminUser.setUserLoginName(loginName);
//						adminUser.setUserRealName(c[1].getContents().trim());
//						adminUser.setUserPassword(DEFAULT_PWD);
//						adminUser.setUserRoles(c[2].getContents().trim());
						try {
							this.save(adminUser);
							s++;
						} catch (Exception e) {
							e.printStackTrace();
							f++;
						}
					}
					
				}else break;
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
        	if(book != null){
        		book.close();
        		book = null;
        		file.delete();
        	}
        }
		m.put("CountItems", i - 2);
		m.put("HandledItems", f+s);
		m.put("Success", s);
		m.put("Fail", f);
		return JSONUtil.serialize(m);
	}

	/**
	 * <p>Description: <p>
	 * @param book
	 * @return
	 */
	public String importCutUser(Workbook book) throws Exception {
		List<Object[]> userParams = new ArrayList<Object[]>();
		List<Object[]> userRoleParams = new ArrayList<Object[]>();
		Map<String, String> userLoginNameMap = dictService.id2Name("user_login_name", "user_id", "cut_user");
		Map<String, String> userIdMap = dictService.id2Name("user_id", "user_login_name", "cut_user");
		Map<String, String> roleIdMap = dictService.id2Name("role_id", "role_name", "cut_role");
		int curRow = 2;
		String userId;
		String userLoginName;
		String userName;
		String errorMsg = "";
		Object[] userParam;
		Object[] userRoleParam;
		Sheet sheet = book.getSheet(0);//第一个工作表
		while(true){
			Cell[] c = sheet.getRow(curRow);//第三行开始
			if(c != null && c.length > 0){
				if(StringUtils.isEmpty(c[0].getContents())){
					userId = getSequence().toString();
				} else {
					userId = c[0].getContents().trim();
					if(Constants.XLS_END_FLAG.equals(userId)){
						log.info("已载入全部数据！");
						break;
					}
					if(StringUtils.isNotEmpty(userIdMap.get(userId))){
						errorMsg = "用户ID已存在！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
				}
				userLoginName = c[1].getContents();
				if(StringUtils.isEmpty(userLoginName)){
					errorMsg = "登录名不能为空！行号：" + (++curRow);
					log.error(errorMsg);
					throw new Exception(errorMsg);
				} else {
					userLoginName = userLoginName.trim();
					if(StringUtils.isNotEmpty(userLoginNameMap.get(userLoginName))){
						errorMsg = "登录名已存在！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					} else {
						userLoginNameMap.put(userLoginName, userId);
						userIdMap.put(userId, userLoginName);
					}
					userName = c[2].getContents().trim();//userName
					if(StringUtils.isEmpty(userName)){
						errorMsg = "用户名称不能为空！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
					
					userParam = new Object[4];
					userParam[0] = userId;
					userParam[1] = userLoginName;
					userParam[2] = userName;
					userParam[3] = Constants.DEFAULT_USER_PWD;
//					userParam[4] = c[3].getContents();//desc
					userParams.add(userParam);
					//用户-角色
					String roleIds = c[3].getContents().trim();
					if(StringUtils.isNotEmpty(roleIds)){
						for(String roleId: roleIds.split(",")){
							userRoleParam = new Object[2];
							userRoleParam[0] = userId;
							if(StringUtils.isEmpty(roleIdMap.get(roleId))){
								errorMsg = "角色ID:" + roleId + "不存在！行号：" + (++curRow);
								log.error(errorMsg);
								throw new Exception(errorMsg);
							}
							userRoleParam[1] = roleId;
							userRoleParams.add(userRoleParam);
						}
					}
					curRow ++;
				}
			} else {
				throw new Exception("行数据不能为空！行号：" + (++curRow));
			}
		}
		if(!userParams.isEmpty()){
			insertUsers(userParams, userRoleParams);
			return (userParams.size()) + "";
		}
		return "0";
	}

	/**
	 * <p>Description: <p>
	 * @param userParams
	 * @param userRoleParams
	 */
	@Transactional
	private void insertUsers(List<Object[]> userParams, List<Object[]> userRoleParams) {
		dao.getSimpleJdbcTemplate().batchUpdate(addUserSql, userParams);
		dao.getSimpleJdbcTemplate().batchUpdate(addUserRoleSql, userRoleParams);
	}
	
}
