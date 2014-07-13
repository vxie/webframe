package com.vxie.debut.model;

import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_AREA")
public class Area implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

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


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序
        result.put("name", name);
        result.put("action", "");  //操作列

        result.put("id", id + "");
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Area area = new Area();
        area.setId(rs.getLong("id"));
        area.setName(rs.getString("name"));
        return area;
    }
}
