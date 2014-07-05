package com.vxie.debut.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="CUT_MENU")
public class CutMenu {
	@Id
	@Column(name="menu_id")
	private Long menuId;
	
	@Column(name="menu_Name")
	private String menuName;
	
	@Column(name="menu_url")
	private String menuUrl;
	
	@Column(name="menu_parent_id")
	private Long menuParentId;
	
	@Transient
	private String menuOthers;
	
	public Long getMenuId() {
		return menuId;
	}
	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	public Long getMenuParentId() {
		return menuParentId;
	}
	public void setMenuParentId(Long menuParentId) {
		this.menuParentId = menuParentId;
	}
	
	public String getMenuOthers() {
		return menuOthers;
	}
	public void setMenuOthers(String menuOthers) {
		this.menuOthers = menuOthers;
	}
}
