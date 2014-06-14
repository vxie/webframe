package com.sunrise.cutshow.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.sunrise.sqlpage.intf.RowEntityMapper;

@Entity
@Table(name="CUT_USER")
//@SequenceGenerator(name="SEQ_CUT_SHOW", allocationSize=1, sequenceName = "SEQ_CUT_SHOW")
public class CutUser implements RowEntityMapper {
	@Id
	@Column(name="user_id")
	//@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CUT_SHOW")
	private Long userId;
	
	@Column(name="user_Real_Name")
	private String userRealName;
	
	@Column(name="user_Login_Name")
	private String userLoginName;
	
	@Column(name="user_Password")
	private String userPassword;
	
	@Column(name="user_Memo")
	private String userMemo;
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getUserRealName() {
		return userRealName;
	}
	public void setUserRealName(String userRealName) {
		this.userRealName = userRealName;
	}
	public String getUserLoginName() {
		return userLoginName;
	}
	public void setUserLoginName(String userLoginName) {
		this.userLoginName = userLoginName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserMemo() {
		return userMemo;
	}
	public void setUserMemo(String userMemo) {
		this.userMemo = userMemo;
	}
	
	
	@Transient
	private String userRoles;
	public String getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(String userRoles) {
		this.userRoles = userRoles;
	}
	
	//
	public LinkedHashMap<String, String> entityToRow() {
	   	LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
    	result.put("user_login_name", userLoginName);
    	result.put("user_real_name", userRealName);
    	result.put("user_roles_name", userRoles);
    	result.put("user_memo", userMemo);
    	result.put("userAction", "");
    	result.put("user_id", userId+"");
		return result;
	}
	
	public Object mapRow(ResultSet rs, int arg1) throws SQLException {
		CutUser u = new CutUser();
		u.setUserLoginName(rs.getString(1));
		u.setUserRealName(rs.getString(2));
		u.setUserRoles(rs.getString(3));
		u.setUserMemo(rs.getString(5));
		u.setUserId(rs.getLong(6));
		return u;
	}
	
}
