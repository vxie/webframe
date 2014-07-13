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
@Table(name = "T_BRANCH")
public class Branch implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "address")
    private String address;

    @Column(name = "longitude")
    private String longitude; //经度

    @Column(name = "latitude")
    private String latitude;  //纬度

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }


    /*
    DROP TABLE IF EXISTS `t_branch`;
    CREATE TABLE `t_branch` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `name` varchar(200) DEFAULT NULL COMMENT '分店名称',
            `address` varchar(200) DEFAULT NULL COMMENT '地址',
            `longitude` varchar(200) DEFAULT NULL COMMENT '地理位置上的经度',
            `latitude` varchar(200) DEFAULT NULL COMMENT '地理位置上的纬度',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=gbk;
    */

    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序
        result.put("name", name);
        result.put("address", address);
        result.put("longitude", longitude);
        result.put("latitude", latitude);
        result.put("action", "");  //操作列

        result.put("id", id + "");
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Branch branch = new Branch();
        branch.setId(rs.getLong("id"));
        branch.setName(rs.getString("name"));
        branch.setAddress(rs.getString("address"));
        branch.setLongitude(rs.getString("longitude"));
        branch.setLatitude(rs.getString("latitude"));
        return branch;
    }
}
