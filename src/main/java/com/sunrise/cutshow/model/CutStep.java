package com.sunrise.cutshow.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="CUT_STEP")
//@SequenceGenerator(name="SEQ_CUT_SHOW", allocationSize=1, sequenceName = "SEQ_CUT_SHOW")
public class CutStep {
	@Id
	@Column(name="step_Id")
	//@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CUT_SHOW")
	private Long stepId;
	
	@Column(name="step_Name")
	private String stepName;
	
	@Column(name="step_Weight_Value")
	private Long stepWeightValue;
	
	@Column(name="step_Cur_Percent")
	private Long stepCurPercent;
	
	@Column(name="step_Times")
	private Long stepTimes;
	
	@Column(name="step_Owner_Id")
	private Long stepOwnerId;
	
	@Column(name="step_Checker_Id")
	private Long stepCheckerId;
	
	@Column(name="step_Index")
	private Long stepIndex;
	
	@Column(name="step_status")
	private Long stepStatus = 0L;
	
	@Column(name="start_time")
	private String startTime;
	
	@Column(name="finish_time")
	private String finishTime;
	
	@Transient
	private String stepVisitUsers;
	@Transient
	private List<CutTask> cutTasks = new ArrayList<CutTask>();
	
	@Transient
	private String stepOwnerName;
	
	@Transient
	private String stepCheckerName;
	
	public Long getStepId() {
		return stepId;
	}
	public void setStepId(Long stepId) {
		this.stepId = stepId;
	}
	public String getStepName() {
		return stepName;
	}
	public void setStepName(String stepName) {
		this.stepName = stepName;
	}
	public Long getStepWeightValue() {
		return stepWeightValue;
	}
	public void setStepWeightValue(Long stepWeightValue) {
		this.stepWeightValue = stepWeightValue;
	}
	public Long getStepCurPercent() {
		return stepCurPercent;
	}
	public void setStepCurPercent(Long stepCurPercent) {
		this.stepCurPercent = stepCurPercent;
	}
	public Long getStepTimes() {
		return stepTimes;
	}
	public void setStepTimes(Long stepTimes) {
		this.stepTimes = stepTimes;
	}
	public Long getStepOwnerId() {
		return stepOwnerId;
	}
	public void setStepOwnerId(Long stepOwnerId) {
		this.stepOwnerId = stepOwnerId;
	}
	public Long getStepCheckerId() {
		return stepCheckerId;
	}
	public void setStepCheckerId(Long stepCheckerId) {
		this.stepCheckerId = stepCheckerId;
	}
	public Long getStepIndex() {
		return stepIndex;
	}
	public void setStepIndex(Long stepIndex) {
		this.stepIndex = stepIndex;
	}
	
	public Long getStepStatus() {
		return stepStatus;
	}
	public void setStepStatus(Long stepStatus) {
		this.stepStatus = stepStatus;
	}
	public String getStepVisitUsers() {
		return stepVisitUsers;
	}
	public void setStepVisitUsers(String stepVisitUsers) {
		this.stepVisitUsers = stepVisitUsers;
	}
	
	public List<CutTask> getCutTasks() {
		return cutTasks;
	}
	public String getStepOwnerName() {
		return stepOwnerName;
	}
	public void setStepOwnerName(String stepOwnerName) {
		this.stepOwnerName = stepOwnerName;
	}
	public String getStepCheckerName() {
		return stepCheckerName;
	}
	public void setStepCheckerName(String stepCheckerName) {
		this.stepCheckerName = stepCheckerName;
	}
	
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(String finishTime) {
		this.finishTime = finishTime;
	}
	
	@Transient
	private double costTime;

	public double getCostTime() {
		return costTime;
	}
	public void setCostTime(double costTime) {
		this.costTime = costTime;
	}
	
}
