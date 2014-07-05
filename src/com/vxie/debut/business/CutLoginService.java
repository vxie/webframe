package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vxie.debut.model.CutMenu;
import com.vxie.debut.model.CutUser;
import com.vxie.debut.utils.MD5Encoder;

@Service
public class CutLoginService extends BaseService {
	
	private CutUser findUser(String loginName){
		List<CutUser> res = dao.find(CutUser.class, "from CutUser c where c.userLoginName=?", loginName);		
		return (res.size()==0 || res.size()>1)?null:res.get(0);
	}
	
	
	public Object checkUser(String loginName, String pwd){
		CutUser user = findUser(loginName);
		if(user!=null){
			if(user.getUserPassword().equals(MD5Encoder.encode(pwd))){
				return user;
			}else{
				return "密码错误";
			}
		}
		return "帐号不存在";
	}
	
	public List<CutMenu> getUserMenus(Long cutUserId) {
		String sql = "select distinct m.menu_id, m.menu_name, m.menu_url, m.menu_parent_id from cut_user_role u "+
			" left join cut_role_menu r on r.role_id=u.role_id "+
			" left join cut_menu m on m.menu_id=r.menu_id "+
			" where u.user_id=?"+
			" order by m.menu_id";
		return dao.getSimpleJdbcTemplate().query(sql, new RowMapper<CutMenu>() {
			public CutMenu mapRow(ResultSet rs, int arg1) throws SQLException {
				CutMenu m = new CutMenu();
				m.setMenuId(rs.getLong(1));
				m.setMenuName(rs.getString(2));
				m.setMenuUrl(rs.getString(3));
				m.setMenuParentId(rs.getLong(4));
				return m;
			}
		}, cutUserId);
	}


	public int isAdmin(Long userId, int menuSize) {
		return (dao.queryForInt("select count(*) from cut_menu", 0) == menuSize && menuSize!=0)?1:0;
	}

	public int isAdmin(Long userId){
		return dao.queryForInt("select count(user_id) from cut_user_role where user_id=? and role_id=1", 0, userId) > 0 ? 1 : 0;
	}

	@Transactional
	public String initSys() {
		String initSql = globalConfig.getStringItemByArea("Sys_DB_Init", "sql");
		List<String> list = new ArrayList<String>();
		for(String str : initSql.split(";")){
			String sql = str.trim();
			if(sql.length()>0) list.add(sql);
		}
		dao.getSimpleJdbcTemplate().getJdbcOperations().batchUpdate(list.toArray(new String[]{}));
		return "0";
	}


	public String clearZero() {
		String initSql = globalConfig.getStringItemByArea("Sys_DB_Clear_Zero", "sql");
		List<String> list = new ArrayList<String>();
		for(String str : initSql.split(";")){
			String sql = str.trim();
			if(sql.length()>0) list.add(sql);
		}
		dao.getSimpleJdbcTemplate().getJdbcOperations().batchUpdate(list.toArray(new String[]{}));
		return "0";
	}
}
