package com.vxie.debut.model;


import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_USER")
public class Member implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "phoneNumber")
    private String phoneNumber;

    @Column(name = "medicalRecordId")
    private Long medicalRecordId;

    @Column(name = "address")
    private String address;

    @Column(name = "groupId")
    private Long groupId; // *

    @Column(name = "age")
    private Integer age;

    @Column(name = "password")
    private String password;

    @Column(name = "time")
    private Date time;

    @Column(name = "brithday")
    private String brithday;

    @Column(name = "areaId")
    private String areaId; // *

    @Column(name = "filename")
    private String filename;


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

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Long getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(Long medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getBrithday() {
        return brithday;
    }

    public void setBrithday(String brithday) {
        this.brithday = brithday;
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    @Transient
    private String areaName;

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序
        result.put("id", id + "");
        result.put("name", name);
        result.put("phoneNumber", phoneNumber);
        result.put("medicalRecordId", medicalRecordId + "");
        result.put("address", address);
        result.put("groupId", groupId + "");
        result.put("age", age + "");
        result.put("time", time == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));
        result.put("brithday", brithday);
        result.put("areaId", areaId);
        result.put("filename", filename);
        result.put("action", "");  //操作列

        result.put("password", password);

        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Member member = new Member();
        member.setName(rs.getString("name"));
        member.setPhoneNumber(rs.getString("phoneNumber"));
        member.setMedicalRecordId(rs.getLong("medicalRecordId"));
        member.setAddress(rs.getString("address"));
        member.setGroupId(rs.getLong("groupId"));
        member.setAge(rs.getInt("age"));
        member.setTime(rs.getTimestamp("time"));
        member.setBrithday(rs.getString("brithday"));
        member.setAreaId(rs.getString("areaId"));
        member.setFilename(rs.getString("filename"));
        member.setId(rs.getLong("id"));
        member.setPassword(rs.getString("password"));
        return member;
    }
}
