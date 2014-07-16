package com.vxie.debut.model;


import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_SPACE")
public class Space implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "userId")
    private Long userId;

    @Column(name = "picName")
    private String picName;

    @Column(name = "time")
    private Date time;

    @Column(name = "content")
    private String content;

    @Column(name = "state")
    private Integer state; //审核状态,0=未审核,1=审核通过,2=审核不通过


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Transient
    private String userName;  //作者名称

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    /* CREATE TABLE `t_space` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `content` text COMMENT '发表的文字内容.',
                `picName` varchar(100) DEFAULT NULL COMMENT '会员发表文章包含的图片名称',
                `userId` int(11) DEFAULT NULL COMMENT '作者ID',
                `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '发布的时间',
                `state` int(11) DEFAULT '0' COMMENT '审核状态,0=未审核,1=审核通过,2=审核不通过',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=gbk;
    */


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序
        result.put("id", id + "");
        result.put("userId", userId + "");
        result.put("userName", userName);
        result.put("picName", picName);
        result.put("time", time == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));
        result.put("content", content);
        String stateDisp = "未审核";
        if (state == 1) {
            stateDisp = "审核通过";
        } else if (state == 2) {
            stateDisp = "审核不通过";
        }
        result.put("state", stateDisp);

        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Space space = new Space();
        space.setId(rs.getLong("id"));
        space.setUserId(rs.getLong("userId"));
        space.setPicName(rs.getString("picName"));
        space.setTime(rs.getTimestamp("time"));
        space.setContent(rs.getString("content"));
        space.setState(rs.getInt("state"));

        return space;
    }
}
