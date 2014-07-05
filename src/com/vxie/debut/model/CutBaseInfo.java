package com.vxie.debut.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="CUT_BASE_INFO")
public class CutBaseInfo {
	@Id
	@Column(name="cut_Info_Id")
	private Long cutInfoId;
	
	@Column(name="cut_Title")
	private String cutTitle;
	
	@Column(name="cut_Begin_Time")
	private String cutBeginTime;
	
	@Column(name="cut_Manager_Id")
	private Long cutManagerId;

    @Column(name="cut_duration")
    private String cutDuration;
	
	@Transient
	private String cutManagerName;
	
	public Long getCutInfoId() {
		return cutInfoId;
	}
	public void setCutInfoId(Long cutInfoId) {
		this.cutInfoId = cutInfoId;
	}
	public String getCutTitle() {
		return cutTitle;
	}
	public void setCutTitle(String cutTitle) {
		this.cutTitle = cutTitle;
	}
	public String getCutBeginTime() {
		return cutBeginTime;
	}
	public void setCutBeginTime(String cutBeginTime) {
		this.cutBeginTime = cutBeginTime;
	}
	
	public Long getCutManagerId() {
		return cutManagerId;
	}
	public void setCutManagerId(Long cutManagerId) {
		this.cutManagerId = cutManagerId;
	}
	public String getCutManagerName() {
		return cutManagerName;
	}
	public void setCutManagerName(String cutManagerName) {
		this.cutManagerName = cutManagerName;
	}

    public String getCutDuration() {
        return cutDuration;
    }

    public void setCutDuration(String cutDuration) {
        this.cutDuration = cutDuration;
    }
}
