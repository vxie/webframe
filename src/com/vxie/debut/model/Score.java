package com.vxie.debut.model;


import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_SCORE")
public class Score  implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "userId")
    private Long userId;

    @Column(name = "planId")
    private Long planId;

    @Column(name = "score")
    private Integer score;

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

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
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

    /* CREATE TABLE `t_score` (
         `id` int(11) NOT NULL AUTO_INCREMENT,
         `userId` int(11) DEFAULT NULL COMMENT '作出评分的会员的id',
         `planId` int(11) DEFAULT NULL COMMENT '被评分的饮食搭配计划Id',
         `score` int(11) DEFAULT NULL COMMENT '分数,0=优,1=良,2=差',
         `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '评分时间',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=gbk;*/


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序

        result.put("userId", userId + "");
        result.put("userName", userName);
        result.put("planId", planId + "");
        result.put("score", score == 0 ? "优" : (score == 1 ? "良" : "差"));
        result.put("time", time == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));

        result.put("id", id + "");

        //select s.userId, '' userName, s.planId, s.score, s.time, s.id from t_score s
        return result;
    }

    public Object mapRow(ResultSet rs, int i) throws SQLException {
        Score score = new Score();
        score.setId(rs.getLong("id"));
        score.setUserId(rs.getLong("userId"));
        score.setPlanId(rs.getLong("planId"));
        score.setScore(rs.getInt("score"));
        score.setTime(rs.getTimestamp("time"));
        return score;
    }

}
