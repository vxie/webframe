package com.vxie.debut.model;

import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_PLAN")
public class Plan implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "userId")
    private Long userId;  //对应的会员Id

    @Column(name = "breakfast")
    private String breakfast;

    @Column(name = "lunch")
    private String lunch;

    @Column(name = "dinner")
    private String dinner;

    @Column(name = "remarks")
    private String remarks;

    @Column(name = "sendTime")
    private Date sendTime;

    @Column(name = "groupId")
    private Long groupId;

    @Column(name = "makeTime")
    private Date makeTime;


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

    public String getBreakfast() {
        return breakfast;
    }

    public void setBreakfast(String breakfast) {
        this.breakfast = breakfast;
    }

    public String getLunch() {
        return lunch;
    }

    public void setLunch(String lunch) {
        this.lunch = lunch;
    }

    public String getDinner() {
        return dinner;
    }

    public void setDinner(String dinner) {
        this.dinner = dinner;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public Date getMakeTime() {
        return makeTime;
    }

    public void setMakeTime(Date makeTime) {
        this.makeTime = makeTime;
    }

    @Transient
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    /* CREATE TABLE `t_plan` (
         `id` int(11) NOT NULL AUTO_INCREMENT,
         `userId` int(11) NOT NULL COMMENT '对应的会员Id',
         `breakfast` varchar(500) DEFAULT NULL COMMENT '早餐的搭配方案',
         `lunch` varchar(500) DEFAULT NULL COMMENT '午餐的搭配方案',
         `dinner` varchar(500) DEFAULT NULL COMMENT '晚餐的搭配方案',
         `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
         `sendTime` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '设置预定的发送给会员的时间',
         `groupId` int(11) DEFAULT NULL COMMENT '会员组Id',
         `makeTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '方案制定(修改)的时间',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=gbk;*/

    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序
        result.put("id", id + "");
        result.put("groupId", groupId + "");
        result.put("userId", userId + "");
        result.put("userName", userName);
        result.put("breakfast", breakfast);
        result.put("lunch", lunch);
        result.put("dinner", dinner);
        result.put("sendTime", sendTime == null ? "" : sdf.format(sendTime));
        result.put("makeTime", makeTime == null ? "" : sdf.format(makeTime));
        result.put("remarks", remarks);
        result.put("action", "");  //操作列

        //select groupId, userId, '' userName, breakfast, lunch, dinner, sendTime, makeTime, remarks, '' action, id from t_plan
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Plan plan = new Plan();
        plan.setId(rs.getLong("id"));
        plan.setGroupId(rs.getLong("groupId"));
        plan.setUserId(rs.getLong("userId"));
        plan.setBreakfast(rs.getString("breakfast"));
        plan.setLunch(rs.getString("lunch"));
        plan.setDinner(rs.getString("dinner"));
        plan.setSendTime(rs.getTimestamp("sendTime"));
        plan.setRemarks(rs.getString("remarks"));
        return plan;
    }
}
