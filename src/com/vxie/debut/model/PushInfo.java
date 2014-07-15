package com.vxie.debut.model;

import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_PUSHINFO")
public class PushInfo implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "adminId")
    private Long adminId;

    @Column(name = "time")
    private Date time;

    @Column(name = "content")
    private String content;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }


    @Transient
    private String adminName;

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    /* CREATE TABLE `t_pushInfo` (
         `id` int(11) NOT NULL AUTO_INCREMENT,
         `content` text COMMENT '推送信息的内容',
         `time` timestamp NULL DEFAULT NULL COMMENT '发布的时间',
         `adminId` int(11) DEFAULT NULL COMMENT '发布人的id',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=gbk;*/


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序
        result.put("adminId", adminId + "");
        result.put("adminName", adminName);
        result.put("time", time == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));
        result.put("content", content);
        result.put("action", "");  //操作列

        result.put("id", id + "");   //select adminId, '' adminName, time, content, '' action, id from t_pushinfo
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        PushInfo pushInfo = new PushInfo();
        pushInfo.setId(rs.getLong("id"));
        pushInfo.setAdminId(rs.getLong("adminId"));
        pushInfo.setTime(rs.getTimestamp("time"));
        pushInfo.setContent(rs.getString("content"));
        return pushInfo;
    }

}
