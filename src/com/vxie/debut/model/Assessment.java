package com.vxie.debut.model;


import com.sunrise.sqlpage.intf.RowEntityMapper;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

@Entity
@Table(name = "T_ASSESSMENT")
public class Assessment implements RowEntityMapper {
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "level")
    private Integer level;

    @Column(name = "time")
    private Date time;

    @Column(name = "adminId")
    private Long adminId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
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

    /*CREATE TABLE `t_assessment` (
         `id` int(11) NOT NULL AUTO_INCREMENT,
         `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '考核时间',
         `level` int(10) NOT NULL DEFAULT '1' COMMENT '评分级别,0=优,1=良,2=差',
         `adminId` int(11) DEFAULT NULL COMMENT '被考核人的id',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=gbk;*/


    public LinkedHashMap<String, String> entityToRow() {
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        //字段顺序要严格对应页面列表中的顺序及AjaxPageService中的select顺序
        result.put("time", time == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));
        result.put("level", level == 0 ? "优" : (level == 1 ? "良" : "差"));
        result.put("action", "");  //操作列

        result.put("id", id + "");
        return result;
    }


    public Object mapRow(ResultSet rs, int arg1) throws SQLException {
        Assessment assessment = new Assessment();
        assessment.setId(rs.getLong("id"));
        assessment.setTime(rs.getTimestamp("time"));
        assessment.setLevel(rs.getInt("level"));
        return assessment;
    }

}
