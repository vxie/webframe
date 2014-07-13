package com.vxie.debut.model;

import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_GROUP")
public class Group implements RowEntityMapper {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "headId")
    private Long headId;

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

    public Long getHeadId() {
        return headId;
    }

    public void setHeadId(Long headId) {
        this.headId = headId;
    }

    @Transient
    private String headName;

    public String getHeadName() {
        return headName;
    }

    public void setHeadName(String headName) {
        this.headName = headName;
    }


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序
        result.put("name", name);
        result.put("headName", headName);
        result.put("action", "");  //操作列

        result.put("headId", headId + "");
        result.put("id", id + "");
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Group group = new Group();
        group.setId(rs.getLong("id"));
        group.setName(rs.getString("name"));
        group.setHeadId(rs.getLong("headId"));
        return group;
    }
}
