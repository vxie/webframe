package com.vxie.debut.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="CUT_ROLE")
public class CutRole {
	@Id
	@Column(name="role_id")
	private Long roleId;
	
	@Column(name="role_Name")
	private String roleName;
	
	@Column(name="role_Memo")
	private String roleMemo;
	
	@Transient
	private String roleMenus;
	
	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getRoleMemo() {
		return roleMemo;
	}
	public void setRoleMemo(String roleMemo) {
		this.roleMemo = roleMemo;
	}

	public String getRoleMenus() {
		return roleMenus;
	}
	public void setRoleMenus(String roleMenus) {
		this.roleMenus = roleMenus;
	}
	
	
	
	
}
