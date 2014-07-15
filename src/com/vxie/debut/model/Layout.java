package com.vxie.debut.model;

import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_LAYOUT")
public class Layout  implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "textContent")
    private String textContent;

    @Column(name = "picName")
    private String picName;

    @Column(name = "disorder")
    private Integer disorder;

    @Column(name = "useing")
    private Integer useing; //是否显示,0=显示,1=不显示

    @Column(name = "updatetime")
    private Date updatetime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTextContent() {
        return textContent;
    }

    public void setTextContent(String textContent) {
        this.textContent = textContent;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public Integer getDisorder() {
        return disorder;
    }

    public void setDisorder(Integer disorder) {
        this.disorder = disorder;
    }

    public Integer getUseing() {
        return useing;
    }

    public void setUseing(Integer useing) {
        this.useing = useing;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }


    /*CREATE TABLE `t_layout` (
         `id` int(11) NOT NULL AUTO_INCREMENT,
         `textContent` varchar(500) DEFAULT NULL COMMENT '文字内容',
         `picName` varchar(100) DEFAULT NULL COMMENT '图片名称',
         `disorder` int(11) DEFAULT NULL COMMENT '显示的序号',
         `useing` int(11) DEFAULT '1' COMMENT '是否显示,0=显示,1=不显示',
         `updatetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '图片上传时间',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=gbk;*/



    public LinkedHashMap<String, String> entityToRow() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public Object mapRow(ResultSet resultSet, int i) throws SQLException {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
