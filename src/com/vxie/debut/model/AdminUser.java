package com.vxie.debut.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.sunrise.sqlpage.intf.RowEntityMapper;

@Entity
@Table(name="T_ADMIN")
public class AdminUser implements RowEntityMapper {
	@Id
	@Column(name="id")
	private Long id;
	
	@Column(name="name")
	private String name;
	
	@Column(name="number")
	private String number;
	
	@Column(name="password")
	private String password;
	
	@Column(name="areaId")
	private Integer areaId;

    @Column(name = "role")
    private Integer role;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    @Transient
	private String areaName;

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    //
	public LinkedHashMap<String, String> entityToRow() {
	   	LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        result.put("number", number);
        result.put("name", name);
        result.put("areaName", areaName);
        result.put("action", "");
        result.put("id", id + "");
		return result;
	}
	
	public Object mapRow(ResultSet rs, int arg1) throws SQLException {
		AdminUser u = new AdminUser();
        u.setNumber(rs.getString(1));
        u.setName(rs.getString(2));
        u.setAreaName(rs.getString(3));
        u.setId(rs.getLong(5));
		return u;
	}
	
}
