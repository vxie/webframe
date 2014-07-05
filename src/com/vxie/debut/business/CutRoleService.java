package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vxie.debut.model.CutMenu;
import com.vxie.debut.model.CutRole;

@Service
public class CutRoleService extends BaseService {

	@Transactional
	public void del(long id) {
		dao.delete(CutRole.class, id);
	}

	@Transactional
	public void save(CutRole cutRole) {
		dao.saveOrUpdate(cutRole);
		
		Long roleId = cutRole.getRoleId();
		
		dao.getSimpleJdbcTemplate().update("delete from cut_role_menu where role_id=?", roleId);
		
		List<Object[]> args = new ArrayList<Object[]>();
		Set<Long> set = new HashSet<Long>();
		
		for(String id: cutRole.getRoleMenus().split(",")){
			Long menuId = Long.parseLong(id);
			if(!set.contains(menuId)) {
				set.add(menuId);
				args.add(new Object[]{roleId, menuId});
			}
			Long parentMenuId = dao.get(CutMenu.class, menuId).getMenuParentId();
			if(parentMenuId!=null && !set.contains(parentMenuId)){
				set.add(parentMenuId);
				args.add(new Object[]{roleId, parentMenuId});
			}
		}
		
		dao.getSimpleJdbcTemplate().batchUpdate("insert into cut_role_menu(role_id, menu_id) values(?, ?)", args);

	}

	public List<CutMenu> getAllMenus(Long roleId) {
		String sql = "select distinct m.menu_id, m.menu_name, m.menu_url, m.menu_parent_id, r.role_id from cut_menu m " +
			" left join cut_role_menu r on r.menu_id=m.menu_id and r.role_id=? " +
			" order by m.menu_id";
		return dao.getSimpleJdbcTemplate().query(sql, new RowMapper<CutMenu>() {
			public CutMenu mapRow(ResultSet rs, int arg1) throws SQLException {
				CutMenu m = new CutMenu();
				m.setMenuId(rs.getLong(1));
				m.setMenuName(rs.getString(2));
				m.setMenuUrl(rs.getString(3));
				m.setMenuParentId(rs.getLong(4));
				m.setMenuOthers(rs.getString(5));
				return m;
			}
		}, roleId);
	}
	
}
