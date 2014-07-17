package com.vxie.debut.model;

import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_FEEDBACK")
public class Feedback implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "userId")
    private Long userId;

    @Column(name = "planId")
    private Long planId;

    @Column(name = "content")
    private String content;

    @Column(name = "time")
    private Date time;

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

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
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


    @Transient
    String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    /* CREATE TABLE `t_feedback` (
         `id` int(11) NOT NULL AUTO_INCREMENT,
         `userId` int(11) DEFAULT NULL COMMENT '作出反馈的会员的id',
         `planId` int(11) DEFAULT NULL COMMENT '被反馈的搭配计划的id',
         `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '反馈时间',
         `content` varchar(500) DEFAULT NULL COMMENT '反馈的内容',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=gbk;*/


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序

        result.put("userId", userId + "");
        result.put("userName", userName);
        result.put("planId", planId + "");
        result.put("content", content);
        result.put("time", time == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));

        result.put("id", id + "");

        //select f.userId, '' userName, f.planId, f.content, f.time, f.id from t_feedback f
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setId(rs.getLong("id"));
        feedback.setUserId(rs.getLong("userId"));
        feedback.setPlanId(rs.getLong("planId"));
        feedback.setContent(rs.getString("content"));
        feedback.setTime(rs.getTimestamp("time"));
        return feedback;
    }
}
